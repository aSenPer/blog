---
title: 
date: 2019-05-20 10:29:25
tags: JS
categories: JS
---
对js中不同数据的布尔值类型总结：false:空字符串；null；undefined；0；NaN。  
true：除了上面的false的情况其他都为true；

如下：
```js
var o = { 
          'name':'lee'
        };
var a = \['reg','blue'\];
function checkBoolean(a){
         if(a){
              return true;
         }else{
              return false;
         }
 }
console.log(checkBoolean('')); //false
console.log(checkBoolean(0)); //false
console.log(checkBoolean(null)); //false
console.log(checkBoolean(undefined)); //false
console.log(checkBoolean(NaN)); //false
console.log(checkBoolean(a));//true
console.log(checkBoolean(c));//true
```

javascript中有六种数据类型：string；boolean；Array；Object；null;undefined。如何检测这些数据类型呢，总结方法如下：

**方法一：采用typeof**
```js
       var fn = function(n){
          console.log(n);
       }
       var str = 'string';
       var arr = \[1,2,3\];
       var obj = {
           a:123,
           b:456
       };
       var num = 1;
       var b = true;
       var n = null;       var u = undefined;
       //方法一使用typeof方法。
       console.log(typeof str);//string
       console.log(typeof arr);//object
       console.log(typeof obj);//object
       console.log(typeof num);//number
       console.log(typeof b);//boolean
       console.log(typeof n);//null是一个空的对象
       console.log(typeof u);//undefined
       console.log(typeof fn);//function
```


通过上面的检测我们发现typeof检测的Array和Object的返回类型都是Object，因此用typeof是无法检测出来数组和对象的，采用方法二和方法三则可以检测出来。

**方法二：instanceof**


```js
 var o = { 
           'name':'lee'
         };
 var a = \['reg','blue'\];
 console.log(o instanceof Object);// true
 console.log(a instanceof Array);//  true
 console.log(o instanceof Array);//  false
```


 注意：instaceof只可以用来判断数组和对象，不能判断string和boolean类型，要判断string和boolean类型需要采用方法四。  
 由于数组也属于对象因此我们使用instanceof判断一个数组是否为对象的时候结果也会是true。如：

console.log(a instanceof Object);//true。

下面封装一个方法进行改进：

```js

var o = { 
          'name':'lee'
        };
var a = \['reg','blue'\];
var getDataType = function(o){
            if(o instanceof Array){
                return 'Array'
            }else if( o instanceof Object ){
                return 'Object';
            }else{
                return 'param is no object type';
            }
       };
console.log(getDataType(o));//Object。
console.log(getDataType(a));//Array。

```

**方法三：使用constructor方法**

```js 
var o = { 
           'name':'lee'
        };
var a = \['reg','blue'\];
console.log(o.constructor == Object);//true
console.log(a.constructor == Array);//true
```

**方法四：利用tostring()方法，这个方法是最佳的方案。**


```js
var o = { 
          'name':'lee'
        };
var a = \['reg','blue'\];
function c(name,age){
         this.name = name;
         this.age = age;
 }
var c = new c('kingw','27');
console.log(Object.prototype.toString.call(a));//\[object Array\]
console.log(Object.prototype.toString.call(o));//\[Object Object\]
console.log(Object.prototype.toString.call(c));//\[Object Object\]

//封装一个方法判断数组和对象
function isType(obj){
       var type = Object.prototype.toString.call(obj);
       if(type == '\[object Array\]'){
              return 'Array';
        }else if(type == '\[object Object\]'){
              return "Object"
        }else{
              return 'param is no object type';
        }
}
console.log(isType(o));//Object
console.log(isType(a));//Array

```

**方法五：利用jquery的$.isPlainObject();$.isArray(obj);$.isFunction(obj)进行判断。**

 出处：[http://www.cnblogs.com/xinggood](http://www.cnblogs.com/xinggood)