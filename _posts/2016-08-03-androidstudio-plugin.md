---
layout: post
title: AndroidStudio的插件整理
tags:
- AndroidStudio
categories: Tools
description: AndroidStudio的插件整理
---

## 一、H.A.X.M（硬件加速执行管理器） 

如果你想使用Android模拟器更快地执行应用程序，那么H.A.X.M是你的最佳选择。H.A.X.M提供Android SDK模拟器在英特尔系统中的硬件加速。我认为H.A.X.M是最有用的插件，因为它能让Android开发人员尽快地在模拟器上运行最新的Android版本。

安装H.A.X.M

打开Android SDK管理器，选择“Intel x86 Emulator Accelerator (HAXM installer)”，接受许可并安装软件包。

![](http://ww1.sinaimg.cn/mw690/5ecfffbajw1f6gb9ju1pkj20gm0c1djm.jpg)

这个进程只是下载软件包，还没有安装。为了完成安装到图片所示的SDK路径

> C:\Users\Administrator\AppData\Local\Android\sdk\

（安装在Windows机器上）并找到下载的文件夹。我的是：

> C:\Users\Administrator\AppData\Local\Android\sdk\extras\intel.

打开安装文件Hardware_Accelerated_Execution_Manager，单击可执行的intelhaxm-android，继续安装。完成此安装后，你就可以使用该模拟器了。

![](http://ww2.sinaimg.cn/mw690/5ecfffbajw1f6gbc4ymovj20mm0c942m.jpg)

## 二、Genymotion

Genymotion是测试Android应用程序，使你能够运行Android定制版本的旗舰工具。它是为了VirtualBox内部的执行而创建的，并配备了一整套与虚拟Android环境交互所需的传感器和功能。使用Genymotion能让你在多种虚拟开发设备上测试Android应用程序，并且它的模拟器比默认模拟器要快很多。 

## 三、Android Drawable Importer

为了适应所有Android屏幕的大小和密度，每个Android项目都会包含drawable文件夹。任何具备Android开发经验的开发人员都知道，为了支持所有的屏幕尺寸，你必须给每个屏幕类型导入不同的画板。Android Drawable Importer插件能让这项工作变得更容易。它可以减少导入缩放图像到Android项目所需的工作量。Android Drawable Importer添加了一个在不同分辨率导入画板或缩放指定图像到定义分辨率的选项。这个插件加速了开发人员的画板工作。

## 四、Android ButterKnife Zelezny

Android ButterKnife是一个“Android视图注入库”。它提供了一个更好的代码视图，使之更具可读性。

## 五、Android Holo Colors Generator

开发Android应用程序需要伟大的设计和布局。Android Holo Colors Generator则是定制符合喜好的Android应用程序的最简单方法。Android Holo Colors Generator是一个允许你为你的应用程序随心所欲地创建Android布局组件的插件。此插件会生成所有必要的可在项目中使用的相关的XML画板和样式资源。

## 六、Robotium Recorder

Robotium Recorder是一个自动化测试框架，用于测试在模拟器和Android设备上原生的和混合的移动应用程序。Robotium Recorder可以让你记录测试案例和用户操作。你也可以查看不同Android活动时的系统功能和用户测试场景。

Robotium Recorder能让你看到当你的应用程序运行在设备上时，它是否能按预期工作，或者是否能对用户动作做出正确的回应。如果你想要开发稳定的Android应用程序，那么此插件对于进行彻底的测试很有帮助。

## 七、jimu Mirror

Android Studio配备了一个可视化的布局编辑器。但是一个静态的布局预览有时候对于开发人员而言可能还不够，因为静态预览不能预览动画、颜色和触摸区域，所以jimu Mirror来了，这是一个可以让你在真实的设备上迅速测试布局的插件。jimu Mirror允许在设备上预览随同编码更新的Android布局。

## 八、Strings-xml-tools

Strings-xml-tools是一个虽小但很有用的插件，可以用来管理Android项目中的字符串资源。它提供了排序Android本地文件和添加缺少的字符串的基本操作。虽然这个插件是有限制的，但如果应用程序有大量的字符串资源，那这个插件就非常有用了。

## 九、Gradle Retrolambda Plugin

retrolambda﻿ 是一个把 Java 8 的lambda 表达式移植到 Java 5、6、7 版本的类库。配合gradle-retrolambda 则可以在 Android 中使用 lambda 表达式了。  
 
项目地址：[https://github.com/evant/gradle-retrolambda]()

## 十、GsonFormat

根据 JSONObject 格式的字符串,自动生成实体类参数的插件  
 
项目地址：[https://github.com/zzz40500/GsonFormat]()

## 十一、dagger-intellij-plugin

为dagger这个依赖注入框架提供的插件，方便快速将带@Inject的对象和带@Provides的方法建立起视觉关联。   

项目地址：[https://github.com/square/dagger-intellij-plugin]()

## 十二、otto-intellij-plugin

为事件订阅和分发事件建立起视觉关联的插件。

项目地址：[https://github.com/square/otto-intellij-plugin]()

## 十三、Parceler

通过注解及工具类自动完成实体类 Parcelable 及值传递

项目地址：[https://github.com/johncarl81/parceler]()

## 十四、Patch-Resizer

自动生成 png 及点 9 图片的不同分辨率版本

项目地址：[https://github.com/redwarp/9-Patch-Resizer]()

## 十五、Android Parcelable code generator

顾名思义，这是个生成实现了Parcelable接口的代码的插件。

在你的类中，按下alt + insert键弹出插入代码的上下文菜单，你会看到在下面有一个Parcelable，如下所示。选择它之后，就会在你的类当中插入实现了Parcelable接口的代码。从此不用再手动写Parcelable代码，感觉怎样呢？ 

## 十六、AndroidCodeGenerator

它的介绍说是可以生成ViewHolder和findView方法的代码。不过怎么生成findView方法的代码我还没找到，但生成ViewHolder也是挺酷炫的。

## 十七、Android Layout ID Converter

由于上面的插件当中我没找到生成findView代码的使用方法，于是我又找到了另一个插件来生成这样的代码。

## 十八、SelectorChapek for Android

这是用于生成Selector的插件。你需要在drawable文件夹中右键，在弹出的菜单中选择Generate Android Selectors，如下所示，它就会根据你的几个drawable文件夹里的资源的命名，帮你生成Selector代码。当然，你的资源文件需要根据约定的后缀来命名。比如按下状态为_pressed，正常状态为_normal，不可用状态为_disable，等等。更详细的说明可以看Github上该项目的说明文件。

项目地址为：[https://github.com/inmite/android-selector-chapek]()

## 十九、FindBugs-IDEA

## 二十、CheckStyle-IDEA

## 二十一、GrepCode

[http://GrepCode.com](http://grepcode.com/) Code Search 找源码必备~[GrepCode IntelliJ Plugin](http://grepcode.com/intellij)

## 二十二、RestClient

模拟HTTP请求测试与服务端的通讯请求，功能强大~

## 二十三、gradle-packer-plugin

让多渠道打包变的更简单

项目地址：[https://github.com/mcxiaoke/gradle-packer-plugin]()

## 二十四、android-material-design-icon-generator-plugin

material-design-icon资源生成器 icon资源都是官方提供：google/material-design-icons · GitHub

项目地址：[https://github.com/konifar/android-material-design-icon-generator-plugin]()

## 二十五、dexcount-gradle-plugin

方法数计算，对于较大应用避免方法爆棚很有用

项目地址：[https://github.com/KeepSafe/dexcount-gradle-plugin]()

## 二十六、android-unit-test

添加Android单元测试

项目地址：[https://github.com/JCAndKSolutions/android-unit-test]()

## 二十七、robolectric-gradle-plugin

Robolectric测试辅助工具

项目地址：[https://github.com/robolectric/robolectric-gradle-plugin]()

## 二十八、GradleDependenciesHelperPlugin

maven gradle 依赖支持自动补全

项目地址：[https://github.com/ligi/GradleDependenciesHelperPlugin]()

## 二十九、folding-plugin

可创建layout的文件夹，管理布局文件

项目地址：[https://github.com/dmytrodanylyk/folding-plugin]()

## 更多：

[http://www.jianshu.com/p/4b37ec5ce3f9]()





