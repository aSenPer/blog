---
title: JS面试题
date: 2019-04-10 10:29:25
tags: Webpack
categories: Webpack

---
## 普通函数和箭头函数的区别

* 箭头函数不能作构造函数。
* 箭头函数没有argument参数。如果你想访问箭头函数的直接参数，可以使用剩余参数 ...args，剩余参数 ... args 接受箭头函数的执行参数
* 箭头函数没有自己的This.指向，箭头函数内部的 this 值始终等于外部函数的 this值。换句话说，箭头函数可按词法解析 this，箭头函数没有定义自己的执行上下文。
* 常规函数如果缺少 return 语句，或者 return 语句后面没有表达式，则常规函数隐式返回undefined
如果箭头函数包含一个表达式，而你省略了该函数的花括号，则将显式返回该表达式。这些是内联箭头函数
## This指向问题
* this是声明函数时附加的参数，指向特定的对象，也就是隐藏参数。
* this提供了一种更加优雅的方式来隐式的传递对象引用。
* this永远指向调用他的对象
#### 一个测试题
```js
var length = 10;
function fn() {
    console.log(this.length);
}
 
var obj = {
  length: 5,
  method: function(fn) {
    fn();
    arguments[0]();
  }
};
 
obj.method(fn, 1);//输出是什么？
```
只要认准 **this永远指向调用他的对象**，这道题就很简单了
在执行 `obj.method()`时，如果函数内部执行`console.log(this.length)`，函数的调用对象为`obj`,`this`指向`obj`，但是`method()`内部执行的是`fn()`函数，而`fn()`函数的调用对象为`window`，即`window.fn()`，即`this`指向`window`，输出为 10；
参数`fn`和`1`属于[arguments](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Functions/arguments)类数组对象，`arguments[0]()`就是调用了`fn()`,此时`fn`的作用域为`arguments`，即`this`指向`arguments`，`this.length`即传入的参数的长度2
结果输出为 10，2

### 闭包和自执行参数

```javascript
var test = function(a){
    this.a = a;
    return function(b){
        return this.a + b;
    }
}(function(a,b){
    return a;
}(1,2))
test(4)
```

解析

```js
var test = function(a){
    this.a = a;  // this指向window
    return function(b){
        return this.a + b;
    }
}
var getA = function(a,b){
    return a;
}(1,2)   //自执行函数 返回1，b没有用到
即:  
test(getA)(4)  // test(1)(4)
test(1) 返回函数
function(b){
    return this.a+b
}
此时 a 为 1 

很明显 最后返回 1+4 结果为 5
```

## 扩展运算符

```js
let yd = {x:1,y:2}
//以下代码会不会报错
let yd1 = { //不会
  ...yd,
  get x(){
    throw new Error()
  }
}
let yd2 = { //会
  ...yd,
  ...{
    get x(){
      throw new Error()
    }
  }
}
```

扩展运算符的参数对象之中，如果有取值函数`get`，这个函数是会执行的。

[对象的扩展运算符](https://es6.ruanyifeng.com/#docs/object#%E5%AF%B9%E8%B1%A1%E7%9A%84%E6%89%A9%E5%B1%95%E8%BF%90%E7%AE%97%E7%AC%A6)

[数组的扩展运算符](https://es6.ruanyifeng.com/#docs/array#%E6%89%A9%E5%B1%95%E8%BF%90%E7%AE%97%E7%AC%A6)

