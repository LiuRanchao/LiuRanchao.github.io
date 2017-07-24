---
layout: post
title: Kotlin使用
tags:
- Kotlin
categories: Kotlin
description: Kotlin
---



### 一,基本语法

1. var：变量
2. val：常量
3. in: 判断一个对象是否在某一个区间内

	~~~ java
	//如果存在于区间(1,Y-1)，则打印OK
	if (x in 1..y-1) 
	  print("OK")
	
	~~~

4. when ： 类似于 Java 中的 switch，可以自动判断参数的类型并转换为响应的匹配值。

	~~~ java
	fun cases(obj: Any) { 
	  when (obj) {
	    1       -> print("第一项")
	    "hello" -> print("这个是字符串hello")
	    is Long -> print("这是一个Long类型数据")
	    !is String -> print("这不是String类型的数据")
	    else    -> print("else类似于Java中的default")
	  }
	}
	~~~
	
5. is : 与 Java 中的instanceof关键字类似

	~~~ java
	fun getStringLength(obj: Any): Int? {
	  if (obj is String) {
	    // 做过类型判断以后，obj会被系统自动转换为String类型
	    return obj.length 
	  }
	
	  //同时还可以使用!is，来取反
	  if (obj !is String){
	  }
	
	  // 代码块外部的obj仍然是Any类型的引用
	  return null
	} 
	~~~
	
6. 空值检测

	Kotlin 是空指针安全的，也就意味着你不会再看到那恼人的空指针异常。
	例如这句代码 println(files?.size)，只会在files不为空时执行。
	以及，你可以这样写

	~~~ java
	//当data不为空的时候，执行语句块
	data?.let{
		//... 
	}
	
	//相反的，以下代码当data为空时才会执行
	data?:let{
		//...
	}
	~~~

7. fun : 函数使用关键字fun声明.如下代码创建了一个名为say()的函数，它接受一个String类型的参数，并返回一个String类型的值

	~~~ java
	fun say(str: String): String {
		return str
	}
	~~~

	同时，在 Kotlin 中，如果像这种简单的函数，可以简写为
	
	~~~ java 
	fun say(str: String): String = str
	~~~
	
	如果是返回Int类型，那么你甚至连返回类型都可以不写
	
	~~~ java
	fun getIntValue(value: Int) = value
	~~~
	
	函数的默认参数
	
	~~~ java
	fun say(str: String = "hello"): String = str
	~~~
	
	这时候你可以调用say()，来得到默认的字符串 "hello"，也可以自己传入参数say("world")来得到传入参数值。
	
	变参函数
	
	~~~ java
	//在Java中，我们这么表示一个变长函数
	public boolean hasEmpty(String... strArray){
		for (String str : strArray){
			if ("".equals(str) || str == null)
				return true;
		}
		return false;
	}
	
	//在Kotlin中，使用关键字vararg来表示
	fun hasEmpty(vararg strArray: String?): Boolean{
		for (str in strArray){
			if ("".equals(str) || str == null)
				return true	
		}
		return false
	}	
	~~~
	
	扩展函数
	
	你可以给父类添加一个方法，这个方法将可以在所有子类中使用
例如，在 Android 开发中，我们常常使用这样的扩展函数：

	~~~ java
	fun Activity.toast(message: CharSequence, duration: Int = Toast.LENGTH_SHORT) {
	    Toast.makeText(this, message, duration).show()
	}
	~~~
	
	这样，我们就可以在每一个Activity中直接使用toast()函数了。
	
	将函数作为参数
	
	~~~ java
	kotlin fun lock<T>(lock: Lock, body: () -> T ) : T { 
		lock.lock() 
		try { 
			return body() 
			} finally { 
				lock.unlock() 
				} 
		}
	~~~

	上面的代码中，我们传入了一个无参的 body() 作为 lock() 的参数
	
	
## 二， 在 Kotlin 中调用 Java 代码

1. 返回 void 的方法
	
	如果一个 Java 方法返回 void，对应的在 Kotlin 代码中它将返回 Unit。关于 Unit，本书将在 第五章函数部分着重讲解。 
现在你只需要知道在Java 中返回为 void 的函数，在 Kotlin 中可以省略这个返回类型。

2. 与 Kotlin 关键字冲突的处理

	Java 有 static 关键字，在 Kotlin 中没有这个关键字，你需要使用@JvmStatic替代这个关键字。
	
	同样，在 Kotlin 中也有很多的关键字是 Java 中是没有的。例如 in,is,data等。如果 Java 中使用了这些关键字，需要加上反引号(`)转义来避免冲突。例如
	
~~~ java
// Java 代码中有个方法叫 is()
public void is(){
	//...
}

// 转换为 Kotlin 代码需要加反引号转义
fun `is`() {
   //...
}
~~~

## 三，在 Java 中调用 Kotlin 代码

1. static 方法

	在 Kotlin 中没有 static关键字,那么如果在 Java 代码中想要通过类名调用一个 Kotlin 类的方法，你需要给这个方法加入@JvmStatic注解。否则你必须通过对象调用这个方法。
	
	~~~ java
	StringUtils.isEmpty("hello");  
	StringUtils.INSTANCE.isEmpty2("hello");
	
	object StringUtils {
	    @JvmStatic fun isEmpty(str: String): Boolean {
	        return "" == str
	    }
	
	    fun isEmpty2(str: String): Boolean {
	        return "" == str
	    }
	}
	~~~
	
	如果你阅读 Kotlin 代码，应该经常看到这样一种写法。
	
	~~~ java
	class StringUtils {
	    companion object {
	       fun isEmpty(str: String): Boolean {
		        return "" == str
		    }
	    }
	}
	~~~
	
	companion object表示外部类的一个伴生对象，你可以把他理解为外部类自动创建了一个对象作为自己的field。
	
	与上面的类似，Java 在调用时，可以这样写：StringUtils.Companion. isEmpty();
关于伴生对象
	
## 转载

 - [https://kymjs.com/code/2017/02/03/01/]()
 - [https://www.kotlincn.net/docs/reference/android-overview.html]()
 - [Test](https://github.com/Kotlin/kotlin-koans)

