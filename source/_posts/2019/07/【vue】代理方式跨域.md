---
title: 
date: 2019-07-20 10:29:25
tags: Vue
categories: Vue

---
### 正向代理与反向代理

前端使用代理主要用于跨域请求，

关于跨域：常用的方式

*   JSONP：利用script标签可跨域的特点，在跨域脚本中可以直接回调当前脚本的函数。
    
*   CORS：服务器设置HTTP响应头中Access-Control-Allow-Origin值，解除跨域限制    
    

但是这两个跨域方案都存在一个致命的缺陷，严重依赖后端的协助，

代理 就可以作为 前端独立解决跨域的方案

**正向代理**

是指一个位于客户端和目标服务器(target server)之间的服务器，为了从目标服务器取得内容，客户端向代理发送一个请求并指定目标(目标服务器)，然后代理向目标服务器转交请求并将获得的内容返回给客户端。

 　　vue-cli 3.x  新建vue.config.js文件
```js
module.exports = {
    devServer: {
        proxy: { // proxy all requests starting with /api to jsonplaceholder
            '/api': {
                target: 'http://localhost:8080',   //代理接口
                changeOrigin: true,
                pathRewrite: { '^/api': '/mock'    //代理的路径
 }
            }
        }
    }
}
```
**反向代理**

反向代理（Reverse Proxy）是指以代理服务器来接受internet上的连接请求，然后将请求转发给内部网络上的服务器，并将从服务器上得到的结果返回给internet上请求连接的客户端，此时代理服务器对外就表现为一个反向代理服务器。

[https://www.cnblogs.com/softidea/p/7425894.html](https://www.cnblogs.com/softidea/p/7425894.html)