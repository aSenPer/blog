---
title: 
date: 2019-07-20 10:29:25
tags: Vue
categories: Vue

---

vue-cli3 打包后 路径错误

1、新建 vue.config.js
```js
module.exports = {
    publicPath: './',    
    lintOnSave:false     //关闭eslint 
}
```
2、router mode模式 设置为 hash