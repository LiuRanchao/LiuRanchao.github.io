---
layout: post
title: Mac使用技巧
tags:
- Mac
categories: 生活
description: Mac使用技巧
---

### 一，修改环境变量

#### 步骤1: 
打开终端，输入在终端输入以管理员的权限打开.bash_profile文件命令：

```sudo vim ~/.bash_profile```

#### 步骤2: 
修改文件内容

~~~ java
# Add Gradle 
export GRADE_HOME=/Users/liuranchao/study/gradle-2.1/bin;

export PATH=$GRADE_HOME:$PATH



# Add android sdk root

export ANDROID_SDK_ROOT=/Users/liuranchao/study/android/adt-bundle-mac-x86_64-20140702/sdk

export PATH=$ANDROID_SDK_ROOT/platform-tools:$PATH
~~~

#### 步骤3: 

```:q!```
Vi放弃所作修改而直接退到shell下。 

```:wq```
Vi将先保存文件，然后退出Vi返回到shell。

### 参考

- [http://blog.csdn.net/u012200908/article/details/38496969]()
- [http://blog.csdn.net/tammy_min/article/details/21597083]()