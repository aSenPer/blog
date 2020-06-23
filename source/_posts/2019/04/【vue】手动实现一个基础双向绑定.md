---
title: 
date: 2019-04-20 10:29:25
tags: Vue
categories: Vue

---
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
</head>
<body>
    <div id="app">
        <input type="" name="" v-model='message'><br>
        <span v-bind='message'></span>
    
    </div>
</body>
</html>
<script type="text/javascript">
    var data = {
        message:''
    }
    var input = document.querySelector('[v-model=message]')
    input.onkeyup=function(){
        data.message = input.value
        // data.message 发生改变 触发 Object.defineproperty
    }
    
    //Object.defineProperty 接受三个参数 
    // obj 要在其上定义属性的对象。
    // prop 要定义或修改的属性的名称。
    // descriptor 将被定义或修改的属性描述符。 仅用到 get 和 set 属性　　 // 这个方法会直接在一个对象上定义一个新属性或者修改对象上的现有属性，并返回该对象。
    Object.defineProperty(data, 'message', {
        // set 接受唯一参数，即该属性新的参数值。
        set(newValue){
            var span = document.querySelector('[v-bind=message]')
            span.innerHTML=newValue　　　　　　　this.value = newValue
        },
        // get 方法执行时没有参数传入
        get(){　　　　     //将newValue 返回给 message
            return this.value
        }

    })

</script>
```