---
title: visibilitychange监听浏览器标签页是否显示
date: 2020-06-28 15:27:43
tags: JS
categories: JS
---

```javascript
document.addEventListener("visibilitychange", function () {
  if(document.visibilityState == 'hiden'){
    //标签页隐藏
  }else{
    //标签页显示
  }
});
```