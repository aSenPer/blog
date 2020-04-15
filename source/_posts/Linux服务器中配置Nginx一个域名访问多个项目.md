---
title: Linux服务器中配置Nginx一个域名访问多个项目
date: 2020-04-12 13:33:33
tags: Nginx

---

&emsp;&emsp;务器配置个人博客和其它项目使其能够根据不同 url 跳转到不同项目，(例如:*localhosh://A 项目/，localhosh://B 项目/* )因为对服务器和 Nginx 部署了解甚少，在此记录一下

<!-- more -->

## location 模块的匹配介绍

> 1. ”=”前缀指令匹配，如果匹配成功，则停止其他匹配。
> 2. 普通字符串指令匹配，顺序是从长到短，匹配成功的 location 如果使用^~，则停止其他匹配（正则匹配）。
> 3. 正则表达式指令匹配，按照配置文件里的顺序，成功就停止其他匹配。
> 4. 如果第三步中有匹配成功，则使用该结果，否则使用第二步结果。

### 注意点

> 1. 匹配的顺序是先匹配普通字符串，然后再匹配正则表达式。另外普通字符串匹配顺序是根据配置中字符长度从长到短，也就是说使用普通字符串配置的 location 顺序是无关紧要的，反正最后 nginx 会根据配置的长短来进行匹配，但是需要注意的是正则表达式按照配置文件里的顺序测试。找到第一个匹配的正则表达式将停止搜索。

> 2. 一般情况下，匹配成功了普通字符串 location 后还会进行正则表达式 location 匹配。有两种方法改变这种行为，其一就是使用“=”前缀，这时执行的是严格匹配，并且匹配成功后立即停止其他匹配，同时处理这个请求；另外一种就是使用“^~”前缀，如果把这个前缀用于一个常规字符串那么告诉 nginx 如果路径匹配那么不测试正则表达式。

```js
location = `` / uri;
```

=开头表示精确匹配，只有完全匹配上才能生效。

```js
location ^ (~`` / uri);
```

^~ 开头对 URL 路径进行前缀匹配，并且在正则之前。

```js
location ~ pattern
```

~开头表示区分大小写的正则匹配。

```js
location ~* pattern
```

~\*开头表示不区分大小写的正则匹配。

```js
location`` / uri;
```

不带任何修饰符，也表示前缀匹配，但是在正则匹配之后。

```js
location /
```

通用匹配，任何未匹配到其它 location 的请求都会匹配到，相当于 switch 中的 default。

## alias 和 root 的区别

在[VUE](https://router.vuejs.org/zh/guide/essentials/redirect-and-alias.html#%E9%87%8D%E5%AE%9A%E5%90%91)中也有alias的概念，感觉两者差不多

- alias 和 root 都是用来指定文件路径的，root与alias主要区别在于nginx如何解释location后面的uri，这会使两者分别以不同的方式将请求映射到服务器文件上。
- root的处理结果是：root路径＋location路径
- alias的处理结果是：使用alias路径替换location路径
- alias是一个目录别名的定义，root则是最上层目录的定义。
- 还有一个重要的区别是alias后面必须要用“/”结束，否则会找不到文件
- alias在使用正则匹配时，必须捕捉要匹配的内容并在指定的内容处使用。
- alias只能位于location块中。（root可以不放在location中）

## 配置示例

```js
server {
 *****
 *****
 # 域名+项目1名称
 location ^~ /A/ {
   alias /data/A/;
 }
 # 域名+项目2名称
 location ^~ /B/ {
   alias /data/B/;
 }
    ****
    ****
}

```

参考：[nginx的location、root、alias指令用法和区别](https://www.nginx.cn/4658.html)