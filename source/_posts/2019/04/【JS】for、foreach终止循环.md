---
title: for、foreach终止循环
date: 2019-04-18 10:29:25
tags: JS
categories: JS
---


foreach 通过 throw   \*\*\*  抛出错误  通过 try {}catch(e){}接受错误 根据错误做出判断

```js
try{
      list.forEach((i) => {
           if(!i.title){
               throw 'BreakT'
            }
            if (i.option_type == 0 || i.option_type == 1) {
                i.option.forEach(v => {
                     if (!v && v !== 0) {
                          throw 'BreakV';
                      }
                 })
              }
     })
 }catch(e){
     uni.showToast({
          icon: 'none',
          title: e == 'BreakT' ? '您有题目未添加标题，请检查' :'您有选项未设置问题，请检查'
     })
     return false;
 }
```

for循环直接 break