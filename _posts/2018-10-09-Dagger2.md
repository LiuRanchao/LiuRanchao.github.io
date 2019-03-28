---
layout: post
title: Dagger2
tags: android framework
--- 
categories: Android
description: Dagger2
---

## 一，作用

A fast dependency injector for Android and Java.

###@Inject

用于标记需要注入的依赖，或者标记用于提供依赖的方法。

#####1. 构造器注入，@Inject标注在构造器上其实有两层意思。
①告诉Dagger2可以使用这个构造器构建对象<br>
②注入构造器所需要的参数的依赖。 构造器注入的局限：如果有多个构造器，我们只能标注其中一个，无法标注多个。
#####2. 属性注入
标注在属性上。被标注的属性不能使用private修饰，否则无法注入。
#####2. 方法注入
标注在public方法上，Dagger2会在构造器执行之后立即调用这个方法。
方法注入和属性注入基本上没有区别， 那么什么时候应该使用方法注入呢？
比如该依赖需要this对象的时候，使用方法注入可以提供安全的this对象，因为方法注入是在构造器之后执行的。

doesn’t work everywhere:

 - Interfaces can’t be constructed.
 - Third-party classes can’t be annotated.
 - Configurable objects must be configured!
 
For these cases where @Inject is insufficient or awkward, use an @Provides-annotated method to satisfy a dependency. The method’s return type defines which dependency it satisfies.

~~~ java
@Provides static Heater provideHeater() {
  return new ElectricHeater();
}
~~~

###@Component

可以标注接口或抽象类.Component 就是连接**依赖的对象实例**和**需要注入的实例属性**之间的桥梁

###@Provides

@Provides方法必须在Module

###@Singleton

Singleton 作用域可以保证一个 Component 中的单例，但是如果产生多个 Component 实例，那么实例的单例就无法保证了。

###@Reusable

Reusable 作用域不关心绑定的 Component，Reusable 作用域只需要标记目标类或 provide 方法，不用标记 Component。

###Lazy injections
只有在调用 Lazy<T> 的 get() 方法时才会初始化依赖实例注入依赖。
###@BindsOptionalOf
###@BindsInstance

Component 还可以在创建 Component 的时候绑定依赖实例，用以注入。这就是@BindsInstance注解的作用，只能在 Component.Builder 中使用。

###@Subcomponent
###@RootScope
###@ChildScope
###@SessionScope
###@ProducerModule
###@Produces


## 参考

 - [官方文档](https://github.com/google/dagger)
 - [Dagger2 最清晰的使用教程](https://www.jianshu.com/p/24af4c102f62)
 - [Dagger 2 完全解析系列](https://www.jianshu.com/p/26d9f99ea3bb)







