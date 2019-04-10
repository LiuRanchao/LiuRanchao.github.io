---
layout: post
title: 《Android组件化架构》
tags:
- book
categories: Android
description: 《Android组件化架构》
---

[豆瓣链接](https://book.douban.com/subject/30190188/)

![](https://img1.doubanio.com/view/subject/l/public/s29735437.jpg)

 - 可以把全部的权限写入Base Module的AndroidManifest.xml
 - 如果使用RxJava，可以考虑将RxBus作为事件总线，代替EventBus3.0
 - 学习RxJava
 - 反射创建一个对象，可以使用Class.newInstance()和Contructor.newInstance()两种方法，推荐使用后者
 - 关系型数据库架构图 
![](https://github.com/lrchao/lrchao.github.io/blob/master/image/%E3%80%8AAndroid%E7%BB%84%E4%BB%B6%E5%8C%96%E6%9E%B6%E6%9E%84%E3%80%8B/4451554887606_.pic.jpg?raw=true)
 - 基础权限架构
![](https://github.com/lrchao/lrchao.github.io/blob/master/image/%E3%80%8AAndroid%E7%BB%84%E4%BB%B6%E5%8C%96%E6%9E%B6%E6%9E%84%E3%80%8B/5531554888229_.pic.jpg?raw=true)
 - 将路由拦截和权限申请结合在一起，拦截跳转的同时并进行权限申请的验证处理
 - 在Base module中定义一个BaseApplication，通过registerActivityLifecycleCallbacks来过去栈顶的activity
 - 如果想使用优先级比较低的依赖，可以使用exclude排除依赖的方式：
 
 ~~~
 implementation ('com.facebook.fresco:fresco:0.10.0') {
    exclude group: 'com.android.support', module 'support-v4'
 }
 ~~~
 
 - 不同渠道，不用依赖

 ~~~
 productFlavors {
    qa {

    }
    googleplay {

                }
}
    
	dependencies {
   	 	qaImplementation project(':xxx')
    	googleplayImplementation project(":xx")
	}
 ~~~
 
  - 如果使用MutlitDex，在Application的attachBaseContext函数中，在super()之后添加MultiDex.install来启动多dex配置，可以减少"class not found"的情况出现


 


 



 
