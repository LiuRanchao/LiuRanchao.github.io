---
layout: post
title: Kotlin-Lambda
tags:
- Kotlin
categories: Kotlin
description: Kotlin-Lambda
---



### 函数类型

Kotlin 使用类似 (Int) -> String 的一系列函数类型来处理函数的声明： val onClick: () -> Unit = ……。

 - (A, B) -> C 表示接受类型分别为 A 与 B 两个参数并返回一个 C 类型值的函数类型。参数类型列表可以为空，如 () -> A 。Unit 返回类型不可省略
 - 类型 A.(B) -> C 表示可以在 A 的接收者对象上以一个 B 类型参数来调用并返回一个 C 类型值的函数。
 - 挂起函数属于特殊种类的函数类型，它的表示法中有一个 suspend 修饰符 ，例如 suspend () -> Unit 或者 suspend A.(B) -> C。
 - (x: Int, y: Int) -> Point
 - 如需将函数类型指定为可空，请使用圆括号：((Int, Int) -> Int)?
 - 函数类型可以使用圆括号进行接合：(Int) -> ((Int) -> Unit)
 - 箭头表示法是右结合的，(Int) -> (Int) -> Unit 与前述示例等价，但不等于 ((Int) -> (Int)) -> Unit。
 - 还可以通过使用类型别名给函数类型起一个别称： typealias ClickHandler = (Button, ClickEvent) -> Unit
 	
 	
### 函数类型实例化 ###

- lambda 表达式: { a, b -> a + b }
- 匿名函数: fun(s: String): Int { return s.toIntOrNull() ?: 0 }
- 如果Lambda中有参数未使用，可以使用下划线代替参数名：

	~~~ kotlin
	val map = mapOf(1 to 1, 2 to 2, 3 to 3)
    for ((key, value) in map) {
        print("$value!") // 打印1!2!3!
    }
    for ((_, value2) in map) {
        print("$value2!") // 打印1!2!3!
    }
	~~~

### 函数引用 ###

~~~ kotlin
fun <A, B, C> compose(f: (B) -> C, g: (A) -> B): (A) -> C {
return { x -> f(g(x)) }
~~~

表示 接受两个参数(B) -> C 和 (A) -> B 返回一个 (A) -> C

### 语法 ###

~~~ kotlin
val sum: (Int, Int) -> Int = { x, y -> x + y }  
~~~

表示是一个(Int, Int) -> Int 类型的变量，默认值为x, y -> x + y

### 函数类型调用 ###

 - 调用的时候可以使用函数引用(::)
 
	~~~ kotlin
	fun toBeSynchronized() = sharedResource.operation()  
	val result = lock(lock, ::toBeSynchronized)  
	~~~

- 传递Lambdas调用：

	~~~ kotlin
	val result = lock(lock, { sharedResource.operation() })
	~~~
	
	在Kotlin中，若函数最后一个参数为函数类型，调用时，该参数可以放到函数的外面：
	
	~~~ kotlin
	lock (lock) {
			sharedResource.operation()
	}
	~~~

	
## 参考

 - [https://www.jianshu.com/p/ac175caf20d0]()
 - [https://www.kotlincn.net/docs/reference/lambdas.html]()



