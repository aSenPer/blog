---
title: github图片加载问题
date: 2020-02-01 17:55:32
tags: 其它
categories: 其它
---

没有梯子的情况下GitHub中的图片大概率是无法访问的

修改`hosts`文件
添加以下内容 
来自 https://github.com/521xueweihan/GitHub520

```text
# GitHub520 Host Start
185.199.108.154               github.githubassets.com
199.232.68.133                camo.githubusercontent.com
199.232.68.133                github.map.fastly.net
199.232.69.194                github.global.ssl.fastly.net
140.82.112.4                  github.com
140.82.112.6                  api.github.com
199.232.68.133                raw.githubusercontent.com
199.232.68.133                user-images.githubusercontent.com
199.232.68.133                favicons.githubusercontent.com
199.232.68.133                avatars5.githubusercontent.com
199.232.68.133                avatars4.githubusercontent.com
199.232.68.133                avatars3.githubusercontent.com
199.232.68.133                avatars2.githubusercontent.com
199.232.68.133                avatars1.githubusercontent.com
199.232.68.133                avatars0.githubusercontent.com

# GitHub520 Host End
```