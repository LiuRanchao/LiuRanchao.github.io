---
layout: post
title: Robolectric
tags:
- Robolectric
categories: Android
description: 基于JavaProject，跳过了模拟器，直接运行在JVM 
---

# 一、概述

基于JavaProject，跳过了模拟器，直接运行在JVM   

官网：   
[http://robolectric.org/]()   

例子：  
[https://github.com/robolectric/deckard-gradle/blob/master/build.gradle]()
[https://github.com/geniusmart/LoveUT]()  
[http://www.jianshu.com/p/9d988a2f8ff7]()  
[http://www.jianshu.com/p/3aa0e4efcfd3]()    

Guide:    
[https://github.com/codepath/android_guides/wiki/Unit-Testing-with-Robolectric]()     
[http://tech.meituan.com/Android_unit_test.html]()   
[http://www.jianshu.com/p/9d988a2f8ff7]()    
[http://www.infoq.com/cn/articles/android-unit-test]()

# 二，常用API

~~~ android
LoginActivity loginActivity = Robolectric.buildActivity(LoginActivity.class).create().get();
~~~

# 三，断言

~~~ java
org.assertj.core.api.Assertions.assertThat
org.assertj.android.api.Assertions.assertThat
assertThat(view).isGone();

junit.framework.Assert.assertNotNull
assertEquals()
assertNotNull()
assertTrue()
assertFalse()
~~~

# 四，运行

1. 打开 Gradle 面板，在面板中执行测试 
2. 右键 MainActivityTest > Run ‘MainActivityTest’
3. 在终端中运行   

~~~ java
./gradlew test
~~~

查看报告
执行完测试之后，会在 app/build/reports/tests/目录下生成相应地测试报告，使用浏览器打开

# 五，常见问题

1. 使用shadowOf报错httpclient找不到 
[http://www.apkfuns.com/robolectric%E4%BD%BF%E7%94%A8shadowof%E6%8A%A5%E9%94%99httpclient%E6%89%BE%E4%B8%8D%E5%88%B0.html]()

# 六，依赖

[https://github.com/robolectric/robolectric/wiki/2.4-to-3.0-Upgrade-Guide]()

~~~ gradle
testCompile ‘org.robolectric:robolectric:3.0’
~~~
