---
title: vue补课
date: 2020-06-28 15:40:40
tags: Vue
categories: Vue
---

## hookEvent

### 组件内部监听生命周期函数

```js
 mounted(){
     // 通过hook监听组件销毁钩子函数，并取消监听事件
     this.$once('hook:updated', () => {})
     //或
     this.$on('hook:updated',()=>{})   
 }
```

### 组件外监听生命周期函数

```js
<oneComponent @hook:updated="someHandler"></oneComponent>
```

## Vue.observable

对于小项目中的状态管理，`vue`官方是不推荐使用`vuex`的；"如果您不打算开发大型单页应用，使用 Vuex 可能是繁琐冗余的。确实是如此——如果您的应用够简单，您最好不要使用 Vuex”

vue 2.6 新增 [Vue.observable](https://cn.vuejs.org/v2/api/#Vue-observable) 方法 可以用它封装一个`vuex`

```javascript
//store
import Vue from 'vue'

// 通过Vue.observable创建一个可响应的对象
export const store = Vue.observable({
  userInfo: {},
  roleIds: []
})

// 定义 mutations, 修改属性
export const mutations = {
  setUserInfo(userInfo) {
    store.userInfo = userInfo
  },
  setRoleIds(roleIds) {
    store.roleIds = roleIds
  }
}
```

在组件中使用

```javascript
<template>
  <div>
    {{ userInfo.name }}
  </div>
</template>
<script>
import { store, mutations } from '../store'
export default {
  computed: {
    userInfo() {
      return store.userInfo
    }
  },
  created() {
    mutations.setUserInfo({
      name: '子君'
    })
  }
}
</script>
```

## watch监听的深度使用

立即执行和深度监听

```js
export default {
  watch: {
    // 在值发生变化之后，重新加载数据
    searchValue: {
    // 通过handler来监听属性变化, 初次调用 newValue为""空字符串， oldValue为 undefined
      handler(newValue, oldValue) {
        if (newValue !== oldValue) {
          this.$_loadData()
        }
      },
      //立即执行属性
      immediate: true,
      //深度监听属性
      deep:true,
      
    }
  }
}

```

除此之外，还可以用 `vm.$watch` 来监听数据，

`vm.$watch` 返回一个取消观察函数，用来停止触发回调：

```
var unwatch = vm.$watch('a', cb,{
	deep:true,
	immediate:true
})
// 之后取消观察
unwatch()
```

## 函数式组件

```js
export default {
  // 通过配置functional属性指定组件为函数式组件
  functional: true,
  // 组件接收的外部属性
  props: {
    avatar: {
      type: String
    }
  },
  /**
   * 渲染函数
   * @param {*} h
   * @param {*} context 函数式组件没有this, props, slots等都在context上面挂着
   */
  render(h, context) {
    const { props } = context
    if (props.avatar) {
      return <img src={props.avatar}></img>
    }
    return <img src="default-avatar.png"></img>
  }
}
```

模板语法声明函数式组件

```vue
<!--在template 上面添加 functional属性-->
<template functional>
  <img :src="props.avatar ? props.avatar : 'default-avatar.png'" />
</template>
<!--根据上一节第六条，可以省略声明props-->
```

函数式组件的优点：

- 函数式组件不需要实例化，无状态，没有生命周期，所以渲染性能要好于普通组件
- 函数式组件结构比较简单，代码结构更清晰

函数式组件与普通组件的区别：

- 函数式组件需要在声明组件是指定functional
- 函数式组件不需要实例化，所以没有`this`,`this`通过`render`函数的第二个参数来代替
- 函数式组件没有生命周期钩子函数，不能使用计算属性，watch等等
- 函数式组件不能通过$emit对外暴露事件，调用事件只能通过`context.listeners.click`的方式调用外部传入的事件
- 因为函数式组件是没有实例化的，所以在外部通过`ref`去引用组件时，实际引用的是`HTMLElement`
- 函数式组件的`props`可以不用显示声明，所以没有在`props`里面声明的属性都会被自动隐式解析为`prop`,而普通组件所有未声明的属性都被解析到`$attrs`里面，并自动挂载到组件根元素上面(可以通过`inheritAttrs`属性禁止)

## require.context实现前端工程自动化

一个webpack的api,通过执行require.context函数获取一个特定的上下文,主要用来实现自动化导入模块,在前端工程中,如果遇到从一个文件夹引入很多模块的情况,可以使用这个api,它会遍历文件夹中的指定文件,然后自动导入,使得不需要每次显式的调用import导入模块

require.context函数接受三个参数

1. directory {String} -读取文件的路径
2. useSubdirectories {Boolean} -是否遍历文件的子目录
3. regExp {RegExp} -匹配文件的正则

require.context函数执行后返回的是**一个函数,并且这个函数有3个属性**

1. resolve {Function} -接受一个参数request,request为test文件夹下面匹配文件的相对路径,返回这个匹配文件相对于整个工程的相对路径

2. keys {Function} -返回匹配成功模块的名字组成的数组

3. id {String} -执行环境的id,返回的是一个字符串,主要用在module.hot.accept,应该是热加载?

使用方法：

```js
   const files = require.context('.', true, /\.js$/)
   
   console.log(files.keys()) // ["./home.js"] 返回一个数组
   let configRouters = []
   /**
   * inject routers
   */
   files.keys().forEach(key => {
     if (key === './index.js') return
     configRouters = configRouters.concat(files(key).default) // 读取出文件中的default模块
   })
   export default configRouters // 抛出一个Vue-router期待的结构的数组
   
```

##    .sync修饰符实现props的双向绑定

一个简单的小demo [官方文档](https://cn.vuejs.org/v2/guide/components-custom-events.html#sync-%E4%BF%AE%E9%A5%B0%E7%AC%A6)

```html
<div id="app">
    <costum-show :isshow.sync="show"></costum-show>
    <div class="show" v-show="show"></div>
  </div>
  <script src="https://cdn.bootcdn.net/ajax/libs/vue/2.6.11/vue.js"></script>
  <script>
    Vue.component('costum-show', {
      props: ['isshow'],
      template: `
     <div>
          <input type="text" val="" @click="showHandle">
     </div>
`,
      methods: {
        showHandle() {
          this.$emit("update:isshow", !this.isshow);
        }
      },
      mounted() {
        console.log(this.isShow);
      },
    })
    var vm = new Vue({
      el: '#app',
      data: {
        show: true
      }
    })
  </script>
```

> 注意带有 `.sync` 修饰符的 `v-bind` **不能**和表达式一起使用 (例如 `v-bind:title.sync=”doc.title + ‘!’”` 是无效的)。取而代之的是，你只能提供你想要绑定的 property 名，类似 `v-model`。
>
> 将 `v-bind.sync` 用在一个字面量的对象上，例如 `v-bind.sync=”{ title: doc.title }”`，是无法正常工作的，因为在解析一个像这样的复杂表达式的时候，有很多边缘情况需要考虑。

## provide&inject ----依赖注入

`Vue`相关的面试经常会被面试官问道，`Vue`父子之间传值的方式有哪些，通常我们会回答，`props`传值，`$emit`事件传值，`vuex`传值，还有`eventbus`传值等等，今天再加一种`provide`与`inject`传值 [官方文档](https://cn.vuejs.org/v2/guide/components-edge-cases.html#%E4%BE%9D%E8%B5%96%E6%B3%A8%E5%85%A5)

`provide` 选项允许我们指定我们想要**提供**给后代组件的数据/方法。

```js
//祖先组件
provide: function () {
  return {
    getMap: this.getMap
  }
}
```

然后在任何后代组件里，我们都可以使用 `inject` 选项来接收指定的我们想要添加在这个实例上的 property：

```js
inject: ['getMap']
```

注意点:

- `provide` 和 `inject` 绑定并不是可响应的。
- `provide` 和 `inject` 主要在开发高阶插件/组件库时使用。并不推荐用于普通应用程序代码中。