---
layout: post
title: android-res/drawable
tags:
- drawable
categories: Android
description: android-res/drawable
---

## layer-list 

可以将多个图片按照顺序层叠起来

~~~ xml
<?xml version="1.0" encoding="utf-8"?>
<layer-list xmlns:android="http://schemas.android.com/apk/res/android">
    <item>
      <bitmap android:src="@drawable/android_red"
        android:gravity="center" />
    </item>
    <item android:top="10dp" android:left="10dp">
      <bitmap android:src="@drawable/android_green"
        android:gravity="center" />
    </item>
    <item android:top="20dp" android:left="20dp">
      <bitmap android:src="@drawable/android_blue"
        android:gravity="center" />
    </item>
</layer-list>
~~~

## selector

~~~ xml
<?xml version="1.0" encoding="utf-8" ?>     
<selector xmlns:Android="http://schemas.android.com/apk/res/android">   
<!-- 默认时的背景图片-->    
<item Android:drawable="@drawable/pic1" />      
<!-- 没有焦点时的背景图片 -->    
<item 
   Android:state_window_focused="false"      
   android:drawable="@drawable/pic_blue" 
   />     
<!-- 非触摸模式下获得焦点并单击时的背景图片 -->    
<item 
   Android:state_focused="true" 
   android:state_pressed="true"   
   android:drawable= "@drawable/pic_red" 
   />   
<!-- 触摸模式下单击时的背景图片-->    
<item 
   Android:state_focused="false" 
   Android:state_pressed="true"   
   Android:drawable="@drawable/pic_pink" 
   />    
<!--选中时的图片背景-->    
<item 
   Android:state_selected="true" 
   android:drawable="@drawable/pic_orange" 
   />     
<!--获得焦点时的图片背景-->    
<item 
   Android:state_focused="true" 
   Android:drawable="@drawable/pic_green" 
   />     
</selector> 
~~~

## shape

~~~ xml
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android"
    android:shape="rectangle">
    <solid android:color="#ffff0000" />
    <padding android:left="5dp" android:top="2dp" android:right="2dp"
        android:bottom="5dp" />
    <stroke android:width="2dp" android:color="#ffffffff" android:dashGap="5dp"
        android:dashWidth="10dp" />
</shape>
~~~

## level-list 

imageView上根据不同的条件显示不同的图片，类似电量

~~~ xml
<level-list xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:maxLevel="0" android:drawable="@drawable/battery_0" />
    <item android:maxLevel="1" android:drawable="@drawable/battery_1" />
    <item android:maxLevel="2" android:drawable="@drawable/battery_2" />
    <item android:maxLevel="3" android:drawable="@drawable/battery_3" />
    <item android:maxLevel="4" android:drawable="@drawable/battery_4" />
</level-list>
~~~

## transition 

一个TransitionDrawable是一个特殊的Drawable对象，可以实现两个drawable资源之间淡入淡出的效果。 
节点下的每个代表一个drawable资源。只能有两个。先前转换调用startTransition()。向后，调用 reverseTransition()。

~~~ xml
<?xml version="1.0" encoding="utf-8"?>
<transition
xmlns:android="http://schemas.android.com/apk/res/android" >
    <item
        android:drawable="@[package:]drawable/drawable_resource"
        android:id="@[+][package:]id/resource_name"
        android:top="dimension"
        android:right="dimension"
        android:bottom="dimension"
        android:left="dimension" />
</transition>
~~~

## inset

嵌入图像资源的使用

~~~ xml
<?xml version="1.0" encoding="utf-8"?>
<inset xmlns:android="http://schemas.android.com/apk/res/android"
    android:drawable="@drawable/logo"
    android:insetBottom="10dp"
    android:insetLeft="10dp"
    android:insetRight="10dp"
    android:insetTop="10dp" >

</inset>
<!--
     android:insetBottom="10dp" 图像距离下边的距离
    android:insetLeft="10dp" 图像距离左标的距离
    android:insetRight="10dp" 图像距离右边的距离
    android:insetTop="10dp" 图像距离上边的距离
-->
~~~

## clip

剪切图像资源，可以只显示一部分图像。

~~~ xml
<clip xmlns:android="http://schemas.android.com/apk/res/android"
    android:drawable="@drawable/progress"
    android:clipOrientation="horizontal"
    android:gravity="left">
</clip>
~~~