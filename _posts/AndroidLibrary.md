---
layout: post
title: AndroidLibrary
tags:
- Library
categories: Android
description: AndroidLibrary
---

#工程结构
---
一个规范的 Android Library 工程应该由一个 **library模块**与一个**demo模块**共同组成。

~~~
debugImplementation project(':library') //debug 版本直接引用本地项目
releaseImplementation '远程库地址'   //release 版本引用远程版本用来最终测试发现问题
~~~

#指导接入者快速依赖全部 aar
---
###如果你的库没办法发布到 mavenCentral
1. 让你的接入者在他们项目 app 模块下新建 libs/xxx 目录，将你们提供的所有 aar拷贝进去，这个 XXX 可以是你们渠道的名字，以后这个下面的 aar 就全是你们的，跟其它的隔离开。
2. 打开 app 的 build.gradle，在根节点声明：

	~~~
	repositories {
	    flatDir {
	        dirs 'libs/xxx'
	    }
	}
	~~~
	
3. 在 dependencies{} 闭包内添加如下声明：

	~~~
	implementation fileTree(include: ['*.aar'], dir: 'libs/xxx')
	~~~

#引用者的项目必须添加 Kotlin 支持
---
1. 而添加依赖的方法也很简单：只需要 **Android Studio -> Tools -> Kotlin -> Configure Kotlin in project** 。Android Studio 会自动帮助项目添加依赖插件, Gradle Sync 一下如果没问题，就搞定了。

2. 伴生对象里需要暴露的 api 请打上 **@JvmStatic**

#Proguard 混淆
---
###自我混淆
如果你的库仅仅想供人使用，而并没有打算完全开源，请一定记得打开混淆。在打开之前。把需要完全暴露给调用者的方法或者属性打上@android.support.annotation.Keep注解就行

###把自己的 ProGuard 配置文件打包进 aar
打开 library 的 build.gradle， 在 defaultConfig 闭包里调用 consumerProguardFiles() 方法：

~~~
defaultConfig {
    minSdkVersion build_versions.min_sdk
    targetSdkVersion build_versions.target_sdk
    
    consumerProguardFiles 'proguard-rules.pro'

    ...
}
~~~

#so 文件
---
###CMake 直接编译 so 文件
一些安全相关的工作势必要放到 C 层去执行

#Resource 资源
---
###库内部资源的命名不要干扰接入方
有没有一种办法，来让 library 开发者可以向 Android Studio 申明自己需要暴露哪些资源，而哪些不希望暴露呢？

当然是有的。我们可以在 library 的 res/values 下面建立一个 public.xml 文件

~~~
<!--向 Android Studio 声明我只希望暴露这个名称的 string 资源-->
<public name="mls_hello" type="string" />
~~~

#第三方依赖库
---
###JCenter() 能引用到的，不要打包进你自己里面
>
只要第三方应用自己能从 JCenter/MavenCentral 获取到的库，如果你的库也依赖了，请一概使用 **compileOnly**

####使用单个文件统一依赖库的版本
使用一个 versions.gradle 文件来统一所有模块依赖库的版本

#API 设计
---
###不要在人家的 Application 类里蹦迪

1. 不要在你的 init() 方法里做任何耗时操作
2. 更不要提供一个 init() 方法，让人家放在 Application 类里，还让人家“最好建议异步”，这跟耍流氓没区别

###统一入口，用一个平台类去包含所有的功能
这里的**平台类**是我自己取的名字，你可以叫 XXXManager、XXXProxy、XXXService、XXXPlatform都可以，把它设计成单例，或者把内部所有的方法写成静态方法。

###所有的常量，定义到一个类
###帮助接入者检查传入参数的合法性
这里要推荐大家参考一下 **android.support.v4.util.Preconditions** ，这个里面封装好了大量的数据类型的情景检查，源码一看就明白。希望大家在写一个库的时候，都能做好传入参数合法性的检查工作，把问题发现在开发阶段，也能确保运行阶段不被意外值搞到奔溃。

## 参考

 - [编写 Android Library 的最佳实践](https://juejin.im/post/5c9228e7f265da60fe7c2732)
- [Android 开发者>Android Studio>User guide>创建 Android 库](https://developer.android.com/studio/projects/android-library.html#PrivateResources)
