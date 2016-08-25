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

# 二、快捷键

Action | Windows | Mac
-------|---------|------
生成getter/setter | Alt + Insert | Cmd + N
查看最近打开过的文件 | Ctrl + E | Cmd + E
查看调用的地方 | Alt + F7 | 
注释代码(//) | Ctrl + / | Cmd + /
注释代码(/**/) | Ctrl + Shift + / | Cmd + Option + /
格式化代码 | Ctrl + Alt + L | Cmd + Option + L
清除无效包引用 | Alt + Ctrl + O | Option + Control + O
当前文件查找 | Ctrl + F | Cmd + F
当前文件查找和替换 | Ctrl + R	 | Cmd + R
上下移动代码 | Alt + Shift + Up/Down | Option + Shift + Up/Down
删除行 | Ctrl + Y | Cmd + Delete
扩大缩小选中范围 | Ctrl + W/Ctrl + Shift + W | Option + Up/Down
快捷生成结构体 | Ctrl + Alt + T | Cmd + Option + T
快捷覆写方法 | Ctrl + O | Cmd + O
快捷定位到行首/尾 | Ctrl + Left/Right | Cmd + Left/Right
折叠展开代码块 | Ctrl + Plus/Minus | Cmd + Plus,Minus
折叠展开全部代码块 | Ctrl + Shift + Plus,Minus | Cmd + Shift + Plus,Minus
文件方法结构 | Ctrl + F12 | 	Cmd + F12
查找调用的位置 | Ctrl + Alt + H | Ctrl + Option + H
大小写转换 | Ctrl + Shift + U | Cmd + Shift + U
快速提取方法 | Ctrl + Alt + M | Cmd + Option + M
查找快捷键的菜单或者动作 | Ctrl + Shift + A | Cmd + Shift + A
关闭或恢复其他窗口 | Ctrl + Shift + F12 | Cmd + Shift + F12
查看方法需要的参数 | Ctrl + P | Cmd + P
Try catch | Ctrl + Alt + T | Cmd + Alt + T

# 三、其它用法

#### 1.加入调试条件 ，断点右键

#### 2.Find Actions(ctrl+shift+a)输入”analyze stacktrace”即可查看堆栈信息。

#### 3.Find Actions(ctrl+shift+a)输入”Analyze Data Flow to Here”，可以查看某个变量某个参数其值是如何一路赋值过来的。 对于分析代码非常有用。

