---
layout: post
title: Proguard
date:2016/09/24
tags:
- 代码混淆
categories: Android
description: Android-Proguard
---

### 一. 不可以混淆的地方

1. 界面
2. WebView界面
3. 引用第三方jar包
4. 序列化对象
5. 调用js
6. JNI反调java方法

	~~~java
	-keepclasseswithmembernames class * { native <methods>; }
	~~~
7. 反射
8. 定义在AndroidManifest.xml的class
9. 动态引用的方法和字段
10. model

	~~~java
	-keep class io.plaidapp.data.api.dribbble.model.** { *; }
	~~~
	
11. 从 JAR/APK 打开资源

### 二. 用法

##### Keep Options:

**- keep**
指定需要保留的类和类成员（作为公共类库，应该保留所有可公开访问的public方法）


- 
1.不混淆package下所有的类和接口:

~~~ gradle
-keep class com.lrchao.package.** { * ; }
~~~

2.不混淆TestClass下的构造方法:

~~~ gradle
-keepclassmembers 
com.lrchao.package.TestClass {
     public <init>(int, int);
} 
~~~

3.不混淆TestClass下的setData()方法

~~~ gradle
－keepclassmembers class
com.lrchao.package.TestClass {
     public void setData(java.lang.String);
}
~~~

4.添加第三方依赖包

~~~ gradle
-libraryjars
libs/android-support-v4.jar
-dontwarn
android.support.v4.** {*;}
-keep class android.support.v4.**{*;}
-keep interface android.support.v4.**{*;}
~~~

注意：需要添加dontwarn,因为默认情况下proguard会检查每一个引用是否正确，但第三房库里往往会有些不会用到的类，<br>
没有正确的引用，所以不配置的话，系统会报错

5.不混淆JS接口类的全名

~~~ gradle
-keepclassmembers class fqcn.of.javascript.interface.for.webview {
 public *;
}
~~~

### ProGuard配置

#### 1.保留选项（配置不进行处理的内容）

-keep {Modifier} {class_specification} 保护指定的类文件和类的成员<br>
-keepclassmembers {modifier} {class_specification} 保护指定类的成员，如果此类受到保护他们会保护的更好<br>
-keepclasseswithmembers {class_specification} 保护指定的类和类的成员，但条件是所有指定的类和类成员是要存在。<br>
-keepnames {class_specification} 保护指定的类和类的成员的名称（如果他们不会压缩步骤中删除）<br>
-keepclassmembernames {class_specification} 保护指定的类的成员的名称（如果他们不会压缩步骤中删除）<br>
-keepclasseswithmembernames {class_specification} 保护指定的类和类的成员的名称，如果所有指定的类成员出席（在压缩步骤之后）<br>
-printseeds {filename} 列出类和类的成员-keep选项的清单，标准输出到给定的文件<br>

#### 2.压缩

-dontshrink 不压缩输入的类文件<br>
-printusage {filename}<br>
-whyareyoukeeping {class_specification}<br>

#### 3.优化

-dontoptimize 不优化输入的类文件<br>
-assumenosideeffects {class_specification} 优化时假设指定的方法，没有任何副作用<br>
-allowaccessmodification 优化时允许访问并修改有修饰符的类和类的成员<br>

#### 4.混淆

-dontobfuscate 不混淆输入的类文件<br>
-obfuscationdictionary {filename} 使用给定文件中的关键字作为要混淆方法的名称<br>
-overloadaggressively 混淆时应用侵入式重载<br>
-useuniqueclassmembernames 确定统一的混淆类的成员名称来增加混淆<br>
-flattenpackagehierarchy {package_name} 重新包装所有重命名的包并放在给定的单一包中<br>
-repackageclass {package_name} 重新包装所有重命名的类文件中放在给定的单一包中<br>
-dontusemixedcaseclassnames 混淆时不会产生形形色色的类名<br>
-keepattributes {attribute_name,...} 保护给定的可选属性，例如LineNumberTable, LocalVariableTable, SourceFile, Deprecated, Synthetic, Signature, and InnerClasses.<br>
-renamesourcefileattribute {string} 设置源文件中给定的字符串常量<br>

在android中在android Manifest文件中的activity，service，provider， receviter，等都不能进行混淆。一些在xml中配置的view也不能进行混淆，android提供的默认配置中都有。

### ProGuard的输出文件及用处

混淆之后，会给我们输出一些文件

- 在gradle方式下是在```<project_dir>/build/proguard/```目录下
- ant是在``<project_dir>/bin/proguard```目录下
- eclipse构建在```<project_dir>/proguard```目录下

分别有以下文件：

- dump.txt 描述apk文件中所有类文件间的内部结构。
- mapping.txt 列出了原始的类，方法，和字段名与混淆后代码之间的映射。
- seeds.txt 列出了未被混淆的类和成员
- usage.txt 列出了从apk中删除的代码

当我们发布的release版本的程序出现bug时，可以通过以上文件（特别时mapping.txt）文件找到错误原始的位置，进行bug修改。同时，可能一开始的proguard配置有错误，也可以通过错误日志，根据这些文件，找到哪些文件不应该混淆，从而修改proguard的配置。

**注意：重新release编译后，这些文件会被覆盖，所以没吃发布程序，最好都保存一份配置文件。**

### 调试Proguard混淆后的程序

上面说了输出的几个文件，我们在改bug时可以使用，通过mapping.txt,通过映射关系找到对应的类，方法，字段等。

另外Proguard文件中包含retrace脚本，可以将一个被混淆过的堆栈跟踪信息还原成一个可读的信息，window下时retrace.bat，linux和mac是retrace.sh，在<sdk_root>/tools/proguard/文件夹下。语法为：

``` java
retrace.bat|retrace.sh [-verbose] mapping.txt [<stacktrace_file>]
```

例如：<br>

``` java
retrace.bat -verbose mapping.txt obfuscated_trace.txt
```

如果你没有指定<stacktrace_file>，retrace工具会从标准输入读取。

一些常用包的Proguard配置

下面再写一些我在项目中使用到的一些第三方包需要单独配置的混淆配置

sharesdk混淆注意:

``` java
-keep class android.net.http.SslError
-keep class android.webkit.**{*;}
-keep class cn.sharesdk.**{*;}
-keep class com.sina.**{*;}
-keep class m.framework.**{*;}
```

Gson混淆配置:

``` java
-keepattributes *Annotation*
-keep class sun.misc.Unsafe { *; }
-keep class com.idea.fifaalarmclock.entity.***
-keep class com.google.gson.stream.** { *; }
```

Umeng sdk混淆配置:

``` java
-keepclassmembers class * {
   public <init>(org.json.JSONObject);
}
-keep class com.umeng.**
-keep public class com.idea.fifaalarmclock.app.R$*{
    public static final int *;
}
-keep public class com.umeng.fb.ui.ThreadView {
}
-dontwarn com.umeng.**
-dontwarn org.apache.commons.**
-keep public class * extends com.umeng.**
-keep class com.umeng.** {*; }
```
### 问题

1

~~~java
Note: the configuration keeps the entry point 'retrofit2.adapter.rxjava2.ResultObservable$ResultObserver { ResultObservable$ResultObserver(io.reactivex.Observer); }' but not the descriptor class 'io.reactivex.Observer'
~~~
ResultObserver 方法的参数 Observer 找不到



### 参考

- [http://ticktick.blog.51cto.com/823160/1413066]()
- [http://www.cnblogs.com/sw926/p/3314165.html]()
- [http://www.oschina.net/question/54100_35490]()
- [http://www.jianshu.com/p/0202845db617]()
- [官网](https://stuff.mit.edu/afs/sipb/project/android/sdk/android-sdk-linux/tools/proguard/docs/index.html#manual/usage.html)
- [常见异常](https://stuff.mit.edu/afs/sipb/project/android/sdk/android-sdk-linux/tools/proguard/docs/index.html#manual/troubleshooting.html)



