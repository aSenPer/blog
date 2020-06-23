---
title: 
date: 2019-05-20 10:29:25
tags: JS
categories: JS
---

### String对象方法

方法一: indexOf()   (推荐)
```js
var str = "123";
console.log(str.indexOf("3") != -1 );  // true
```
indexOf() 方法可返回某个指定的字符串值在字符串中首次出现的位置。如果要检索的字符串值没有出现，则该方法返回 -1。

方法二: search() 
```js
var str = "123";
console.log(str.search("3") != -1 );  // true
```
search() 方法用于检索字符串中指定的子字符串，或检索与正则表达式相匹配的子字符串。如果没有找到任何匹配的子串，则返回 -1。

方法三:match()
```js
var str = "123";
var reg = RegExp(/3/);
if(str.match(reg)){
    // 包含        
}
```
match() 方法可在字符串内检索指定的值，或找到一个或多个正则表达式的匹配。

### RegExp 对象方法

方法四:test() 
```js
var str = "123";
var reg = RegExp(/3/);
console.log(reg.test(str)); // true
```
test() 方法用于检索字符串中指定的值。返回 true 或 false。

方法五:exec()
```js
var str = "123";
var reg = RegExp(/3/);
if(reg.exec(str)){
    // 包含        
}
```
exec() 方法用于检索字符串中的正则表达式的匹配。返回一个数组，其中存放匹配的结果。如果未找到匹配，则返回值为 null。

[https://www.cnblogs.com/ooo0/p/7741651.html](https://www.cnblogs.com/ooo0/p/7741651.html)