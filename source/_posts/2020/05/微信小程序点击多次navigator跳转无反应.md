---
title: 微信小程序点击多次navigator跳转无反应
date: 2020-05-27 20:08:38
tags: 小程序
categories: 小程序
---

`navigator`组件`open-type`属性默认值为`navigate`

而`navigate`对应`navigateTo`方法，可以看到文档中对`navigateTo`的说明：

保留当前页面，跳转到应用内的某个页面。但是不能跳到 tabbar 页面。使用 wx.navigateBack 可以返回到原页面。小程序中页面栈**最多十层**。

**将 `open-type`属性值设为`redirect`即可**

