---
title: 
date: 2019-04-18 10:29:25
tags: JS
categories: JS
---

```js
$(function(){ function pushHistory() { var state = {
            title: "title",
            url: "#" };
        window.history.pushState(state, "title", "#");
    }
    pushHistory();
    window.addEventListener("popstate", function(e) {
        alert("我监听到了浏览器的返回按钮事件啦"); // 根据自己的需求实现自己的功能
    }, false);
});

```