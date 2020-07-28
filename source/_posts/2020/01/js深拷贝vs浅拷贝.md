---
title: js深拷贝vs浅拷贝
date: 2020-01-14 18:00:17
tags: JS
categories: 每天一个知识点
---
<br>

**前端真是深似海啊！一个深拷贝就涵盖了许多的知识点。学海无涯，加油吧！**

&ensp;&ensp;&ensp;&ensp;深拷贝和浅拷贝都是针对的引用类型，JS中的变量类型分为值类型（基本类型）和引用类型；对值类型进行复制操作会对值进行一份拷贝，而对引用类型赋值，则会进行地址的拷贝，最终两个变量指向同一份数据

## 浅拷贝

![](http://cloud.asenper.cn//20200714113150.webp)

<small>图来自[ConardLi](https://juejin.im/post/5d6aa4f96fb9a06b112ad5b1)</small>

>创建一个新对象，这个对象有着原始对象属性值的一份精确拷贝。如果属性是基本类型，拷贝的就是基本类型的值，如果属性是引用类型，拷贝的就是内存地址 ，所以如果其中一个对象改变了这个地址，就会影响到另一个对象。

### 1.Object.assign()

>Object.assign() 方法可以把任意多个的源对象自身的可枚举属性拷贝给目标对象，然后返回目标对象。

```js
function cloneShallow1(obj) {
  return Object.assign({}, obj)
}
```

### 2.扩展运算符

```js
function cloneShallow2(obj){
  return {...obj}
}
```

### 3.自定义方法循环遍历对象的key，重新赋值

```js
function cloneShallow(obj) {
  let targetObj = {};
  for (const key in obj) {
    if (obj.hasOwnProperty(key)) {
      targetObj[key] = obj[key];
    }
  }
  return targetObj
}
```

## 深拷贝

![](http://cloud.asenper.cn//20200714113226.webp)
<small>图来自[ConardLi](https://juejin.im/post/5d6aa4f96fb9a06b112ad5b1)</small>

> 将一个对象从内存中完整的拷贝一份出来,从堆内存中开辟一个新的区域存放新对象,且修改新对象不会影响原对象

### 1.JSON.parse(JSON.stringify(obj))

> 利用JSON.stringify 将js对象序列化（JSON字符串），再使用JSON.parse来反序列化(还原)js对象。如果断电，对象将不复存在，因此需将对象的内容转换成字符串的形式再保存在磁盘上 )和传输（例如 如果请求的Content-Type是 application/x-www-form-urlencoded，则前端这边需要使用qs.stringify(data)来序列化参数再传给后端，否则后端接受不到； ps: Content-Type 为 application/json;charset=UTF-8或者 multipart/form-data 则可以不需要 ）

```js
function cloneDeep1(obj) {
 return  JSON.parse(JSON.stringify(obj))
}
```

 缺点 只能拷贝JSON对象，等等等等
 参考 <https://blog.csdn.net/u013565133/article/details/102819929>

### 2.基础版

```js
function cloneDeep2(obj) {
  if(Object.prototype.toString.call(obj[key]) == '[object Object]'){
    let targetObj = {};
    for (const key in obj) {
      if (obj.hasOwnProperty(key)) {
        targetObj[key] = cloneDeep2(obj[key])
      }
    }
    return targetObj  
  }else{
    return obj
  }
}
```

只考虑了Object,未考虑数组;拷贝数组时,改变数组会改变原数据

### 3.考虑数组

```js
function cloneDeep3(target) {
    if (typeof target === 'object') {
        let cloneTarget = Array.isArray(target) ? [] : {};
        for (const key in target) {
            cloneTarget[key] = cloneDeep3(target[key]);
        }
        return cloneTarget;
    } else {
        return target;
    }
};
```

### 4.递归实现深度拷贝

> 递归方法实现深度克隆原理：遍历对象、数组直到里边都是基本数据类型，然后再去复制，就是深度拷贝。

**主要考虑到循环引用的问题:例如**

```js
var a = {b:'c'};
a.a = a;

//如果用上面的方法cloneDeep2
cloneDeep2(a)  //会造成死循环 导致内存溢出
```

![](http://cloud.asenper.cn//20200714154414.png)

解决此问题的方案:额外开辟一个存储空间，来存储当前对象和拷贝对象的对应关系，当需要拷贝当前对象时，先去存储空间中找，有没有拷贝过这个对象，如果有的话直接返回，如果没有的话继续拷贝，这样就巧妙化解的循环引用的问题。

```js
function cloneDeep4(obj, hash = new WeakMap()) {
  if (obj === null) return obj; // 如果是null或者undefined我就不进行拷贝操作
  if (obj instanceof Date) return new Date(obj);
  if (obj instanceof RegExp) return new RegExp(obj);
  // 可能是对象或者普通的值  如果是函数的话是不需要深拷贝
  if (typeof obj !== "object") return obj;
  // 是对象的话就要进行深拷贝
  if (hash.get(obj)) return hash.get(obj);
  let cloneObj = new obj.constructor();
  // 找到的是所属类原型上的constructor,而原型上的 constructor指向的是当前类本身
  hash.set(obj, cloneObj);
  for (let key in obj) {
    if (obj.hasOwnProperty(key)) {
      // 实现一个递归拷贝
      cloneObj[key] = cloneDeep4(obj[key], hash);
    }
  }
  return cloneObj;
}
```

参考:
[浅拷贝与深拷贝](https://juejin.im/post/5b5dcf8351882519790c9a2e)
[深拷贝的终极探索](https://juejin.im/post/5bc1ae9be51d450e8b140b0c)
[如何写出一个惊艳面试官的深拷贝?](https://juejin.im/post/5d6aa4f96fb9a06b112ad5b1)
