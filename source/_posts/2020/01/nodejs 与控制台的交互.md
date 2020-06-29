---
title: nodejs与控制台的交互
date: 2020-01-29 18:05:08
tags: Node
categories: Node
---
## Nodejs [Process对象](https://blog.csdn.net/u012060033/article/details/102758129)
```js
const chalk = require('chalk') //终端样式库 https://github.com/chalk/chalk
process.stdout.write(chalk.green("请输入用户名:"));
process.stdin.on('data', (input) => {
  input = input.toString().trim();
  console.log(chalk.blue(input))
  if (input === '') { //输入为空时触发 end 事件
    process.stdin.emit('end'); 
    return
  }
});
process.stdin.on('end', () => {
  console.log(chalk.red('end'))
})
```