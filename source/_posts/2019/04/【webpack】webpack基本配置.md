---
title: 
date: 2019-04-10 10:29:25
tags: Webpack
categories: Webpack

---
```js
const path = require("path");
const HtmlWebpackPlugin \= require("html-webpack-plugin"); //配置路径
const PATH = { //path.jion 把当前文件的绝对路径与相对路径相结合生成新的路径
    app:path.join(\_\_dirname,"src/index.js"),
    build:path.join(\_\_dirname,"dist")
} //module 打包的配置项
module.exports = {
    entry:{
        app:PATH.app
    },
    output:{
        filename:"\[name\].js",
        path:PATH.build
    },
   module:{ //test  匹配类型 通过loader进行合并
 rules:\[
           {
                test:/\\.(js|jsx)$/,
                use:{ //打包js  一个打包的工具
                    loader:"babel-loader",
                    options:{
                        presets:\["@babel/env","@babel/react"\]
                    }
                },
               exclude:\_\_dirname+"node\_modules" },{
               test:/\\.(css|scss)$/,
               loader:\["style-loader","css-loader","sass-loader"\]
           }
       \]
   }, //plugins  插件
 plugins:\[ new HtmlWebpackPlugin({
            template:"index.html",
            filename:"index.html" })
   \]

}
```