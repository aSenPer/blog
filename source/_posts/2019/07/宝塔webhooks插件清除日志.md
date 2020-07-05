---
title: 宝塔webhooks插件清除日志
date: 2019-07-02 09:02:32
tags: hexo
categories: hexo
---

&emsp;&emsp;博客提交的多了，webhooks的日志也越来越多，每次都要把滚动条拉到最底，滚动条还特别小，就想着能不能添加一个清除日志的功能。正好在宝塔论坛里看到了这样的一边文章，转载过来，记录一下
[https://www.bt.cn/bbs/thread-30978-1-2.html](https://www.bt.cn/bbs/thread-30978-1-2.html)

打开文件路径 /www/server/panel/plugin/webhook
找到 index.html 文件 编辑

修改 获取列表方法
第78行  直接替换

```js
 zbody += '<tr>'
       +'<td>'+mlist[i].title+'</td>'
       +'<td>'+getLocalTime(mlist[i].addtime)+'</td>'
       +'<td>'+getLocalTime(mlist[i].uptime)+'</td>'
       +'<td>'+mlist[i].count+'</td>'
       +'<td><a href="javascript:showWebHookCode(\''+mlist[i].url+'\',\''+mlist[i].access_key+'\')" class="btlink">查看密钥</a></td>'
       +'<td><div style="text-align: right;"><a href="javascript:RunHook(\''+mlist[i].access_key+'\');" class="btlink">测试</a> | '
       +'<a href="javascript:OnlineEditFile(0,\'/www/server/panel/plugin/webhook/script/'+mlist[i].access_key+'\');" class="btlink">编辑</a> | '
       +'<a href="javascript:DeleteHook(\''+mlist[i].access_key+'\');" class="btlink">删除</a></div>'
       +'<div style="text-align: right;"><a href="javascript:GetLogs(\'/www/server/panel/plugin/webhook/script/'+mlist[i].access_key+'.log\');" class="btlink">日志</a> | '
       +'<a href="javascript:ClearLogs(\'/www/server/panel/plugin/webhook/script/'+mlist[i].access_key+'.log\');" class="btlink">清除日志</a></div></td>'
       +'</tr>'
```

添加清除日志的方法

```js
//清除日志
function ClearLogs(path){
    loadT = layer.msg('正在清除...',{icon:16,time:0,shade: [0.3, '#000']});
    var data='&path='+path
    $.post('/files?action=DeleteFile',data,function(rdata){
        layer.close(loadT);
        if(!rdata.status) {
            layer.msg(rdata.msg,{icon:2});
            return;
        };
        layer.msg(rdata.msg,{icon:rdata.status?1:2});
    });
}
```

完工
![](https://img2020.cnblogs.com/blog/1524685/202006/1524685-20200630090102486-1644179180.png)
