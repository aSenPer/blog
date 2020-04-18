---
title: 解决cannot remove '.user.ini'Operation not permitted
date: 2020-04-18 10:29:25
tags: Linux
categories: Linux
---
在Linux中删除整个git仓库，删除失败出现 cannot remove '.user.ini'Operation not permitted，原因就是文件中含有某种属性不可更改，删除该属性就可以了
<!-- more -->
在Linux中rm -rf的威力是十分巨大的，特别是附带了 -f 参数，不少新手都干过用root用户执行 rm -rf /命令这种傻事，如果云服务器没有快照，简直就是灾难，从根目录开始所有文件被递归删除，连系统都被损坏。

但是，偶尔也会遇到使用rm -rf也删除不了的文件，执行后报rm: cannot remove `.user.ini': Operation not permitted，

这时候需要使用到Linux的chattr命令， chattr命令用于改变文件属性。这项指令可改变存放在ext2文件系统上的文件或目录属性，这些属性共有以下8种模式：
a：让文件或目录仅供附加用途。
b：不更新文件或目录的最后存取时间。
c：将文件或目录压缩后存放。
d：将文件或目录排除在倾倒操作之外。
i：不得任意更动文件或目录。
s：保密性删除文件或目录。
S：即时更新文件或目录。
u：预防以外删除。
语法chattr[-RV][-v<版本编号>][+/-/=<属性>][文件或目录...]参数
　　-R 递归处理，将指定目录下的所有文件及子目录一并处理。
　　-v<版本编号> 设置文件或目录版本。
　　-V 显示指令执行过程。
　　+<属性> 开启文件或目录的该项属性。
　　-<属性> 关闭文件或目录的该项属性。
　　=<属性> 指定文件或目录的该项属性。

进入到`.user.ini'所在目录，执行一下 lsattr -a，查看文件下下边包含文件的属性，看到`.user.ini'有个'i'属性，代表不得任意更动文件或目录，正是此属性在作祟：


然后执行命令：
``
chattr -i .user.ini
``
就可以去除掉此属性，然后我们再执行删除，就可以顺利删除掉了：

原文链接：https://blog.csdn.net/sinat_35861727/article/details/79040755