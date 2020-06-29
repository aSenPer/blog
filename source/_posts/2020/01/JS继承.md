---
title: JS继承
date: 2020-01-15 23:59:35
tags: JS
categories: 每天一个知识点
---

继承的实现主要是依据 **原型链**

### 原型链

构造函数、原型和实例的关系：每个构造函数都有一个原型对象，原型对象都包含一个指向构造函数的指针，而实例都包含一个指向原型对象的内部指针

假如我们让原型对象等于另一个类型的实例，此时的原型对象将包含一个指向另一个原型的指针，相应地，另一个原型中也包含着一个指向另一个构造函数的指针。这就是原型链的基本概念

```js
function SuperType(){ 
	this.property = true; 
}
SuperType.prototype.getSuperValue = function(){ 
	return this.property; 
}; 
function SubType(){ 
	this.subproperty = false; 
} 
//继承了 SuperType 
//将一个函数的实例赋值给另一个函数的原型对象 subType将继承SuperType的所有属性和方法
SubType.prototype = new SuperType(); 
SubType.prototype.getSubValue = function (){ 
	return this.subproperty; 
}; 
var instance = new SubType(); 
alert(instance.getSuperValue()); //true
```

**当以读取模式访问一个实例属性时，首先会在实例中搜索该属性。如果没有找到该属性，则会继续搜索实例的原型。**

#### 确定原型和实例的关系

instance

isPrototypeOf

```js
function SuperType() {
  this.property = true;
  this.color = ['red','black']
}
SuperType.prototype.getSuperValue = function () {
  return this.property;
};

function SubType() {
  this.subproperty = false;
}
//继承了 SuperType 
SubType.prototype = new SuperType();
//添加新方法
SubType.prototype.getSubValue = function () {
  return this.subproperty;
};
//重写超类型中的方法
SubType.prototype.getSuperValue = function () {
  return false;
};
var instance = new SubType();
instance.color.push('pink')
console.log(instance.color); //[ 'red', 'black', 'pink' ]
var instance1 = new SubType()
console.log(instance1.color); //[ 'red', 'black', 'pink' ]
```

从上面这段代码可以看出，当继承 引用数据类型 时，只要某一个实例改变引用数据类型的值，其他实例的该值也会随之变化；也就是说，继承的引用数据类型是共享的

第二点：在创建子类型的实例时，不能向超类型的构造函数中传递参数

### 借用构造函数（ 伪造对象  /  经典继承 ）

```js
function SuperType(name) {
  this.colors = ["red", "blue", "green"];
  this.name = name;
}

function SubType(name) {
  //继承了 SuperType 
  SuperType.call(this, name);
  this.age = 19 
}
var instance1 = new SubType('Tom');
instance1.colors.push("black");
console.log(instance1.colors); //"red,blue,green,black" 
console.log(instance1.name); // Tom
var instance2 = new SubType("Jack");
console.log(instance2.colors); //"red,blue,green"
console.log(instance2.name) //Jack
```

从上面代码看出，借用构造函数将 *SuperType* 利用 *call* 函数将*this* 指向了 *SubType* ,即在子类型构造函数的内部调用超类型构造函数

相较于 原型链 继承，借用构造函数继承的方式实现了子类向超类的参数传递，同时也解决了引用数据类型共享的问题，使每个实例的属性都私有化

缺点：

- 方法都在构造函数中定义，无法实现函数的复用；
- 在超类型的原型中定义的方法，对子类型而言也是不可见的，结果所有类型都只能使用构造函数模式（*这点不明白为啥是不可见的？？？*）

### 组合继承

```js
function SuperType(name) {
  this.name = name;
  this.colors = ["red", "blue", "green"];
}
SuperType.prototype.sayName = function () {
  console.log(this.name);
};

function SubType(name, age) {
  //继承属性
  SuperType.call(this, name);
  this.age = age;
}
//继承方法
SubType.prototype = new SuperType();
console.log(SubType.prototype.constructor); // SuperType函数
SubType.prototype.constructor = SubType;

SubType.prototype.sayAge = function () {
  console.log(this.age);
};
var instance1 = new SubType("Nicholas", 29);
instance1.colors.push("black");
console.log(instance1.colors); //"red,blue,green,black" 
instance1.sayName(); //"Nicholas"; 
instance1.sayAge(); //29 
var instance2 = new SubType("Greg", 27);
console.log(instance2.colors); //"red,blue,green" 
instance2.sayName(); //"Greg"; 
instance2.sayAge(); //27
```

组合继承避免了原型链和借用构造函数的缺陷，融合了它们的优点，成为 JavaScript 中最常用的继承模式

### 原型式继承

```js
var person = { 
  name: "Nicholas", 
  friends: ["Shelby", "Court", "Van"] 
}; 
var anotherPerson = Object.create(person); 
anotherPerson.name = "Greg"; 
anotherPerson.friends.push("Rob"); 
var yetAnotherPerson = Object.create(person); 
yetAnotherPerson.name = "Linda"; 
yetAnotherPerson.friends.push("Barbie"); 
alert(person.friends); //"Shelby,Court,Van,Rob,Barbie"	
```

Object.create()函数接收两个参数：一个用作新对象原型的对象和（可选的）一个为新对象定义额外属性的对象

这种方式同样会共享 引用类型的数据

### 寄生式继承

寄生式（parasitic）继承是与原型式继承紧密相关的一种思路，并且同样也是由克罗克福德推而广之的。寄生式继承的思路与寄生构造函数和工厂模式类似，即创建一个仅用于封装继承过程的函数，该函数在内部以某种方式来增强对象，最后再像真地是它做了所有工作一样返回对象。

```js
function createAnother(original){ 
   var clone = Object(original); //通过调用函数创建一个新对象
   clone.sayHi = function(){ //以某种方式来增强这个对象
   		alert("hi"); 
   }; 
   return clone; //返回这个对象
}
var person = { 
   name: "Nicholas", 
   friends: ["Shelby", "Court", "Van"] 
}; 
var anotherPerson = createAnother(person); 
anotherPerson.sayHi(); //"hi"
```

### 寄生组合式继承

```js
function inheritPrototype(subType, superType){ //继承方法
   var prototype = Object(superType.prototype); //创建对象
   prototype.constructor = subType; //增强对象
   subType.prototype = prototype; //指定对象
}

function SuperType(name){ 
   this.name = name; 
   this.colors = ["red", "blue", "green"]; 
} 
SuperType.prototype.sayName = function(){ 
	 alert(this.name); 
}; 
function SubType(name, age){ //继承属性
   SuperType.call(this, name); 
   this.age = age; 
} 
inheritPrototype(SubType, SuperType); 
SubType.prototype.sayAge = function(){ 
	 alert(this.age); 
};
```

**通过借用构造函数来继承属性，通过原型链的混成形式来继承方法**

### 总结

JavaScript 主要通过原型链实现继承。原型链的构建是通过将一个类型的实例赋值给另一个构造函数的原型实现的。这样，子类型就能够访问超类型的所有属性和方法，这一点与基于类的继承很相似。原型链的问题是对象实例共享所有继承的属性和方法，因此不适宜单独使用。解决这个问题的技术是借用构造函数，即在子类型构造函数的内部调用超类型构造函数。这样就可以做到每个实例都具有自己的属性，同时还能保证只使用构造函数模式来定义类型。使用最多的继承模式是组合继承，这种模式使用原型链继承共享的属性和方法，而通过借用构造函数继承实例属性。

此外，还存在下列可供选择的继承模式。

- 原型式继承，可以在不必预先定义构造函数的情况下实现继承，其本质是执行对给定对象的浅复制。而复制得到的副本还可以得到进一步改造。
- 寄生式继承，与原型式继承非常相似，也是基于某个对象或某些信息创建一个对象，然后增强对象，最后返回对象。为了解决组合继承模式由于多次调用超类型构造函数而导致的低效率问题，可以将这个模式与组合继承一起使用。
- 寄生组合式继承，集寄生式继承和组合继承的优点与一身，是实现基于类型继承的最有效方式。