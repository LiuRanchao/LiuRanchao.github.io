---
layout: post
title: APK破解
tags:
- 反编译
categories: Android
description: APK破解
---

### 一，使用APKTOOL

~~~ java
apktool d a.apk
~~~

### 二，使用DEX2JAR

在d2j-dex2jar.sh所在目录下

~~~ java
sh d2j-dex2jar.sh /Users/xxx/xxx/a.apk
~~~

### 参考

- [浅析 Android 打包流程](http://mp.weixin.qq.com/s?__biz=MzI0NjIzNDkwOA==&mid=2247483789&idx=1&sn=6aed8c7907d5bd9c8a5e7f2c2dcdac2e&scene=1&srcid=0831CCuRJsbJNuz1WxU6uUsI#wechat_redirect)
- [ZjDroid工具介绍及脱壳详细示例](http://www.cnblogs.com/goodhacker/p/3961045.html)
- [smali语法](http://blog.isming.me/2015/01/14/android-decompile-smali/)
- [Apktool和Jadx源码分析以及错误纠正](http://www.wjdiankong.cn/android%E9%80%86%E5%90%91%E4%B9%8B%E6%97%85-%E5%8F%8D%E7%BC%96%E8%AF%91%E5%88%A9%E5%99%A8apktool%E5%92%8Cjadx%E6%BA%90%E7%A0%81%E5%88%86%E6%9E%90%E4%BB%A5%E5%8F%8A%E9%94%99%E8%AF%AF%E7%BA%A0/)
- [反编译后重新打包](http://huli.logdown.com/posts/661513-android-apk-decompile)
- [.OS反编译](http://blog.csdn.net/jiangwei0910410003/article/details/51500328)
- [APKTOOL官方文档](https://ibotpeaches.github.io/Apktool/documentation/)
- [DEX2JAE官方文档](http://sourceforge.net/p/dex2jar/wiki/UserGuide/)