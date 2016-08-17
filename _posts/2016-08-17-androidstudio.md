---
layout: post
title: AndroidStudio使用
tags:
- AndroidStudio
categories: Tools
description: AndroidStudio使用
---

# 一、问题

#### 问题1:

![](http://i.stack.imgur.com/bj7SN.png)

**解决：**   

> /Applications/Android\ Studio.app/Contents/Info.plist

~~~ xml
... 
<key>JVMVersion</key>
<string>1.7+</string>
...
~~~

[http://stackoverflow.com/questions/35928580/android-n-requires-the-ide-to-be-running-with-java-1-8-or-later/35935433]()
