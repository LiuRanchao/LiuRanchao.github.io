---
layout: post
title: Kotlin-Collections
tags:
- Kotlin
categories: Kotlin
description: Kotlin
---



### List、Set、Map

区分**可变集合**与**不可变集合**

### 一. 继承关系 ###

~~~ kotlin
List : Collection :	Iterable
Set : Collection :	Iterable
Map
~~~

### 二. 创建 ###

~~~ kotlin
val list = listOf("1", "2", "3")  // 使用 array list 实现的
val list = listOf<String>()
val list = mutableListOf("1", "2", "3")
val list = mutableListOf<String>()

val set = setOf("1", "2", "3")
val set = setOf<String>()
val set = mutableSetOf("1", "2", "3")
val set = mutableSetOf<String>()

val map = mapOf("a" to 1, "b" to 2) // print {a=1, b=2}
val map = mapOf<String, String>()
val map = mutableMapOf("a" to 1, "b" to 2)
val map = mutableMapOf <String, String>()
~~~

### 三. 操作符 ###

#### all ####

~~~ kotlin
val list = listOf(1, 2, 3)
list.all { it > 0 }  // return true
list.all { it > 2 }  // return false
~~~

#### any ####

~~~ kotlin
val list = listOf(1, 2, 3)
println(list.any { it > 2 }) // return true
~~~

#### toSet ####
~~~ kotlin
val list = listOf(1, 2, 3)
list.toSet()
~~~

#### map ####
~~~ kotlin
val list = listOf(1, 2, 3)
println(list.map { it * it}) // print [1, 4, 9]
~~~
 
#### filter ####
~~~ kotlin
val list = listOf(1, 2, 3)
println(list.filter { it > 1 }) // print [2, 3]
~~~   

#### flatMap ####
~~~ kotlin
val list = listOf("abc", "12")
println(list.flatMap { it.toList() }) // print [a, b, c, 1, 2]
~~~ 

#### fold ####
~~~ kotlin
println(listOf(1, 2, 3, 4).fold(2, {
        partProduct, element ->
        element * partProduct
    }))  // print 48 (2 * 1 * 2 * 3 * 4 = 48)
 
~~~ 

#### 。。。 ####
	


	
## 参考

 - [https://www.kotlincn.net/docs/reference/collections.html]()
 - [https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/-list/index.html]()


