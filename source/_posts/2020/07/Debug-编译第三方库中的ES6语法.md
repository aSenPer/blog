---
title: 'Debug[编译第三方库中的ES6语法]'
date: 2020-07-01 09:53:05
tags: Debug
categories: Debug
---

## 前言

项目中不是所有包的编译输出都是es5，会导致打包后的项目包含未经编译的ES6语法，使项目在某些低版本手机或浏览器中出先问题。问题的解决方法就是对第三方包进行编译。

## 解决方式

在项目的`babel.config.js`中按如下的配置：

```js
module.exports = {  
    ...  
    overrides: [
        {
            include: './node_modules/${第三方库}',// 使用的第三方库
            sourceType: 'unambiguous'
        }  
    ],  
    ...  
};
```

相关API

**[overrides](https://babeljs.io/docs/en/options#overrides)** : <https://babeljs.io/docs/en/options#overrides>
**[sourceType](https://babeljs.io/docs/en/options#sourcetype)**: <https://babeljs.io/docs/en/options#sourcetype>
