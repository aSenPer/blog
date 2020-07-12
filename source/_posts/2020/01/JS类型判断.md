---
title: JS类型判断
date: 2020-01-12 09:55:06
tags: JS
categories: 每天一个知识点
---

## typeof

`typeof`主要用来检测基本数据类型，可能返回的结果为 ：`string`、`number`、`boolean`、`undefined`、`function`、`object` ;
**并不能检测对象的类型**

## instanceof

`instanceof`主要用来检测引用数据类型，判断 A 是否为 B 的实例返回的结果为 `Boolean` 类型；

``` js
alert(*** instanceof Object);// 变量  是否是 Object
alert(*** instanceof Array); // 变量  是否是 Array
alert(*** instanceof RegExp);// 变量  是否是 RegExp
```

根据规定，所有引用类型的值都是 `Object` 的实例。因此，在检测一个引用类型值和 `Object` 构造函数时，`instanceof` 操作符始终会返回 `true`。**当然，如果使用 `instanceof` 操作符检测基本类型的值，则该操作符始终会返回 `false`，因为基本类型不是对象。**

## 安全的类型检测 Object.prototype.toString.call()

从以上来看，typeof  和  instanceof 各有弊端 ，typof能检测为对象，但不能检测出对象的类型；instanceof 能检测为基本类型，但检测不出基本类型的类别；[Object.prototype.toString.call()](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Object/toString#Using_toString()_to_detect_object_class) 就弥补了这个缺陷；
**任何值上调用 Object 原生的 toString()方法，都会返回一个[object NativeConstructorName]格式的字符串。每个类在内部都有一个[[Class]]属性，这个属性中就指定了该字符串中的构造函数名。**
例如
`alert(Object.prototype.toString.call(value)); //"[object Array]"`

该方法时最通用的类型检测
封装一下

```js
function type (param) {
  return Object.prototype.toString.call(param).match(/\s+(\w+)/)[1] //正则匹配
}
```
