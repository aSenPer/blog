---
title: 
date: 2019-04-10 10:29:25
tags: Webpack
categories: Webpack

---
### webpack:url-loader 图片路径问题

我们使用webpack打包项目中，在处理图片路径时， 最常用的loader有两种， url-loader 和 file-loader。

我们在写项目中引用路径的时候，填写的URL是基于我们开发时的路径， 但是在webpack打包时， 会将各个模块打包成一个文件，里面引用的路径是相对于入口html文件，并不是相对于我们的原始文件路径的。loader 可以解析项目中引入的URL，并且根据配置，把图片拷贝到相应路径， 再将打包后的文件中的路径 替换为图像的最终路径。

file-loader 和 url-loader 都可以解决这个问题。 但是url-loader会将引入的图片进行编码， 我们引用的时候只需要引入这个文件就可以访问图片了， 可以大大减少 HTTP请求的次数。

url-loader 封装了 file-loader， 但并不依赖他， 所以我们可以只需要安装 url-loader就可以了。

在使用url-loader时，出现了 路径引用错误的 情况。

1.  问题复现

webpack.prod.js
```js
    module.exports = {
        // ...
        rules: [
            // ...
            {
            test: /\.(png|svg|jpg|gif)$/,
            use: [
                // ...
                {
                    loader: 'url-loader', //是指定使用的loader和loader的配置参数
                    options: {
                        limit:500,  //是把小于500B的文件打成Base64的格式，写入JS
                        name: 'images/[name]_[hash:7].[ext]',
                    }
                }
            ]
            },
            {
                test: /\.(css)$/,
                use: [
                    MiniCssExtractPlugin.loader,
                    {
                        loader: 'css-loader',
                    }
                ]
        ],
    }
```


index.js
```js
    import React from 'react';
    import ReactDom from 'react-dom';
    import './index.scss';
    import logo from './logo.png';
    
    ReactDom.render(
        Hello world
            
        ,
        document.getElementById("root")
    );
```

index.css
```js
    #root {
        color: aqua;
        background: url('./logo.png');
    };
```

打包后的 css 文件
```
    #root{background:url(images/logo_e179a47.png);color:#0ff}
```

打包后 的 文件结构

── css

│   └── app.9fd7e730df40df61cc5a.css

├── images

│   └── logo\_e179a47.png

├── js

│  └── app.382da24eb9c30ee2.js

└── index.html

我们在浏览器中打开打包后的 index.html

![](https://user-gold-cdn.xitu.io/2018/9/3/1659f420ecd33c50?imageView2/0/w/1280/h/960/format/webp/ignore-error/1)

可以看出我们在index.js 中 引入的图片是可以正常加载的， 但是我们在css中引入的背景图 并没有加载成功。

2.  问题原因

webpack 在 打包时， 首先会把图片 复制到 /dist/images/ 文件夹下， 然后把 css 文件中的url 路径 替换为webpack中options的name属性指向的路径，即 /images/logo.png, 但是这个路径是相对路径，是相对于 /dist/css/~.css 来说的， 所以此处引用的 文件地址为： /dist/css/images/logo.jpg。 但是我们打包后的css 文件夹中， 并没有 images/logo.png, 所以图片并没有渲染出来。 但是 对于 我们 index.js 中 引用的图片， 此处相对路径是相对于 index.html 来说的， 所以 是可以取到图片的。

3.  解决方式
```js
     {
        test: /\.(css)$/,
        use: [
            {
                loader: MiniCssExtractPlugin.loader,
                options: {
                    publicPath: '../',
                }
            },
            {
                loader: 'css-loader',
            }
        ]
    },
```

在为css文件配置 loader时， 添加 publicPath 属性。 这样做， 我们在图片打包时， 仍会将图片复制在 /dist/images/ 文件夹之下， 但是 在css文件中引用时， 会将路径替换为 publicPath + name。

打包后的 css 文件：
```
    #root{background:url(../images/logo_e179a47.png);color:#0ff}
```

至此， 项目中 css 的文件引用路径 和 js 中的文件引用路径 均为正确的图片路径。

[https://juejin.im/post/5b8d1e926fb9a019b66e4657](https://juejin.im/post/5b8d1e926fb9a019b66e4657)