---
title: 服务器登录显示version N/A -> N/A is not yet installed
date: 2020-06-09 09:44:10
tags: Node

---

服务器登录显示 
```
N/A: version "N/A -> N/A" is not yet installed.
You need to run "nvm install N/A" to install it before using it
```
虽然没有影响使用，但看着真的很别扭，强迫证表示一定要干掉它！
问题原因看描述就很清楚了，nvm使用了没有安装的node版本，
nvm list 查看下node版本列表
nvm -v 查看下当前node版本号
nvm use 当前node版本号 
这样就可以了
还有一种方法
之前服务器安装了宝塔，在宝塔里安装了pm2来管理node,但是在此之前我记得是单独装过node，问题应该是出在这里了😀
