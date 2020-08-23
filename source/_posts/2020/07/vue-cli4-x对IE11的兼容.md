---
title: Debug[vue-cli4.x对IE11的兼容]
date: 2020-07-02 11:12:56
tags: Debug
categories: Debug
---

## 前言

Vue项目对IE的兼容相当不友好，不过时代在进步，IE注定被淘汰。但是当前还是有一大批的用户使用IE，不得不对它做兼容处理。通常一个Vue项目中会用一些第三方插件，这些插件也会对IE有着限制，所以要根据项目要求使用相应的兼容性的插件。或者对第三方插件也进行转码， [Debug-编译第三方库中的ES6语法](/2020/07/01/Debug-编译第三方库中的ES6语法/) 持续更新~

## 兼容到IE11

项目背景

​    `vue-cli4.x`

​    `iviewUI`

​    `vue-quill-editor`(兼容IE10以上版本不包括IE10！)

### 1、根据项目需求修改 `package.json`中的 `browserslist` 配置

```json
"browserslist": [
    "> 1%",
    "last 2 versions",
    "last 10 Chrome versions",
    "last 5 Firefox versions",
    "Safari >= 6",
    "ie > 10",
    "not dead"
  ]
```

### 2、 配置 `babel-polyfill`进行转码

```js
安装
cnpm install --save babel-polyfill
在main.js头部引入
import 'babel-polyfill'
```

### 3、组件的按需引入

各UI框架都有相应的配置。这里说的是按需引入后IE的兼容问题，其它的框架不清楚，项目中使用的是 `iview UI`,按需引入后IE11出现 **无效字符** 的错误。

解决方式：在`vue.config.js` 添加以下内容,完美解决问题

```js
chainWebpack: config => {
    // iview 按需引入ie报错无效字符 添加该配置项 解决该问题
    config.module
      .rule('view-design')
      .test(/view-design.src.*?js$/)
      .use('babel')
      .loader('babel-loader')
      .end()
  },
```
