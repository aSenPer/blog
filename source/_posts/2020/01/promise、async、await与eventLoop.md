---
title: promise、async、await与eventLoop
date: 2020-01-14 23:54:54
tags: JS
categories: 每天一个知识点
---


## Promise

promise的作用是用来解决回调地狱，它使得异步操作具备同步操作的接口，使得程序具备正常的同步运行的流程，回调函数不必再一层层嵌套

可以通过 `new Promise`来创建一个`promise`对象，

该对象含有一个状态 *PromiseStatus*，一个值*PromiseValue*

*PromiseStatus*的值，也就是promise的状态分为三种： `fulfilled/resolved` （已完成）`rejected`（已拒绝） `pending`（进行中）

这三种的状态的变化途径只有两种。

•  异步操作从“未完成”到“已完成”

•  异步操作从“未完成”到“失败”

Promise构造函数接受一个函数作为参数，该函数的两个参数分别是resolve和reject。

resolve函数的作用是，将Promise对象的状态从“未完成”变为“成功”（即从Pending变为Resolved），在异步操作成功时调用，并将异步操作的结果，作为参数传递出去；

reject函数的作用是，将Promise对象的状态从“未完成”变为“失败”（即从Pending变为Rejected），在异步操作失败时调用，并将异步操作报出的错误，作为参数传递出去。

```javascript
new Promise((resolve,reject)=>{
  setTimeout(()=>{
    resolve('res')
  },3000)
}).then(res=>{
  console.log(res) //res
  return 12
}).then(res=>{
  console.log(res) //12
  return 34
}).then(res=>{
  console.log(res) //34
}).catch(err=>{
  console.log(err)
})
```

从上面这个例子可以看出，`promise`的`then`方法接收上一个`then`方法的返回值，这个就是解决回调地狱的关键

then方法可以接受两个回调函数，一个成功时的回调，一个失败时的回调（可以省略），当然也可以用catch接收失败的回调。这两个函数都接受异步操作传回的值作为参数

上面这个**例子是串行执行若干异步任务**，promise还可以**并行执行异步任务。**

```javascript
promise.all([task1,task2]).then(res=>{  //task1,task2皆为promise
   res 为 一个包含 task1,task2结果的的数组
})
```

**`Promise.race(iterable)`** 方法返回一个 promise，一旦迭代器中的某个promise解决或拒绝，返回的 promise就会解决或拒绝。

```javascript
var p5 = new Promise(function(resolve, reject) { 
  setTimeout(resolve, 500, "five"); 
});
var p6 = new Promise(function(resolve, reject) { 
  setTimeout(reject, 100, "six");
});

Promise.race([p5, p6]).then(res=>{
  console.log(res); //不执行
}).catch(err=>{
  console.log(err+'---------'); //six
});

```

`race` 函数返回一个 `Promise`，它将与第一个传递的 promise 相同的完成方式被完成。

**它可以是完成（ resolves），也可以是失败（rejects），这要取决于第一个完成的方式是两个中的哪个**。

如果传的迭代是空的，则返回的 promise 将永远等待。

如果迭代包含一个或多个非承诺值和/或已解决/拒绝的承诺，则` Promise.race` 将解析为迭代中找到的第一个值。

## Event Loop

event loop是JS的运行机制，在事件循环内部，分为两种类型的列队：宏任务（*macrotask*）列队和微任务（*microtask*）列队，分别用于对应的宏任务与微任务

JS中常见的宏任务和微任务有

### MacroTask（宏任务）

- `setTimeout`、`setInterval`、`setImmediate`（浏览器暂时不支持，只有 IE10 支持，具体可见 [`MDN`](https://developer.mozilla.org/zh-CN/docs/Web/API/Window/setImmediate)）、`I/O`、`UI Rendering`。

### MicroTask（微任务）

- `Process.nextTick`（[Node独有](https://nodejs.org/zh-cn/docs/guides/event-loop-timers-and-nexttick/)）、`Promise`、`Object.observe(废弃)`、`MutationObserver`

### 浏览器中的 Event Loop

`Javascript` 有一个 `main thread` 主线程和 `call-stack` 调用栈 (执行栈)，所有的任务都会被放到调用栈等待主线程执行。

### JS 调用栈

JS 调用栈采用的是后进先出的规则，当函数执行的时候，会被添加到栈的顶部，当执行栈执行完成后，就会从栈顶移出，直到栈内被清空。

### 同步任务和异步任务

`Javascript` 单线程任务被分为**同步任务**和**异步任务**，同步任务会在调用栈中按照顺序等待主线程依次执行，异步任务会在异步任务有了结果后，将注册的回调函数放入任务队列中等待主线程空闲的时候（调用栈被清空），被读取到栈内等待主线程的执行

执行栈在执行完**同步任务**后，查看**执行栈**是否为空，如果执行栈为空，就会去检查**微任务** (`microTask`) 队列是否为空，如果为空的话，就执行 `Task`（宏任务），否则就一次性执行完所有微任务。
每次单个**宏任务**执行完毕后，检查**微任务** (`microTask`) 队列是否为空，如果不为空的话，会按照**先入先**出的规则全部执行完**微任务** (`microTask`) 后，设置**微任务** (`microTask`) 队列为 `null`，然后再执行**宏任务**，如此循环。

## async await

`async`函数 用来定义一个返回`AsyncFunction`对象的异步函数。异步函数是指通过事件循环异步执行的函数，它会通过一个隐式的 `Promise`返回其结果。

当遇到 await 关键字的时候，异步函数被暂停。函数体的执行被暂停，async 函数中剩余的代码会在微任务中运行而不是一个常规任务！

await关键字可以暂停异步函数的执行，并等待Promise执行，然后继续执行异步函数，并返回结果。**只能在异步函数中使用**



```javascript
//检测一下学习成果
console.log('script start')

async function async1() {
  await async2()
  console.log('async1 end')
}
async function async2() {
  console.log('async2 end')
}
async1()

setTimeout(function() {
  console.log('setTimeout')
}, 0)

new Promise(resolve => {
  console.log('Promise')
  resolve()
})
  .then(function() {
    console.log('promise1')
  })
  .then(function() {
    console.log('promise2')
  })

console.log('script end')
```

