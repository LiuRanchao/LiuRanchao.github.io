---
layout: post
title: android UI适配
tags:
- 适配
categories: Android
description: android的UI适配
---

# android-UI适配

## 一，使用不同的value文件夹

### 方案1：
> DisplayMetrics metrics = getResources().getDisplayMetrics(); 
Though Android doesn’t use a direct pixel mapping, it uses a handful of quantized Density Independent Pixel values then scales to the actual screen size. So the metrics.densityDpi property will be one of the DENSITY_??? constants (120, 160, 213, 240, 320, 480 or 640 dpi).

> If you need the actual lcd pixel density (perhaps for an OpenGL app) you can get it from the metrics.xdpi and metrics.ydpi properties for horizontal and vertical density respectively.

> If you are targeting API Levels earlier than 4. The metrics.density property is a floating point scaling factor from the reference density (160dpi). The same value now provided by metrics.densityDpican be calculated

~~~ java
int densityDpi = (int)(metrics.density * 160f);
~~~

### 方案2：
getResources().getDisplayMetrics().density; 
> 0.75 - ldpi    
1.0 - mdpi   
1.5 - hdpi   
2.0 - xhdpi   
3.0 - xxhdpi   
4.0 - xxxhdpi

### 方案3：

~~~ java
DisplayMetrics metrics = new DisplayMetrics(); 
	getWindowManager().getDefaultDisplay().getMetrics(metrics); 
	switch(metrics.densityDpi){ 
		case DisplayMetrics.DENSITY_LOW: 
			break; 
		case DisplayMetrics.DENSITY_MEDIUM: 
			break; 
		case DisplayMetrics.DENSITY_HIGH: 
			break; 
}
~~~

## 二.尽量使用RelativeLayout

## 三.使用wrap_content, match_parent

## 四.使用据尺寸限定词

布局文件放在加上类似large，sw600dp等这样限定词的文件夹中，以此来告诉系统根据屏幕选择对应的布局文件，比如下面例子的layout-large文件夹）

多应用都为大屏幕实现了“two-panes”模式（应用可能在一个方框中实现一个list，另外一个则实现list的content），平板和电视都是大到能在一个屏幕上适应两个方框，但是手机屏幕却只能单个显示。

## 五.使用最小宽度限定词

老版Galaxy Tab和一般的7寸平板，有很多的应用都想针对这些不同的设备（比如5和7寸的设备）定义不同的布局，但是这些设备都被定义为了large尺寸屏幕。正是因为这个，所以Android在3.2的时候开始使用最小宽度限定词。最小宽度限定词允许你根据设备的最小宽度（dp单位）来指定不同布局。

这样意味着当你的设备的最小宽度等于600dp或者更大时，系统选择layout-sw600dp/main.xml（two_panes）的布局，而小一点的屏幕则会选择layout/main.xml（single_panes）的布局。 然而，在3.2之前还没有将sw600dp作为一个限定词出现，所以，你还是需要使用large限定词来做。 因此，你还是应该要有一个布局文件名为res/layout-large/main.xml，和res/layout-sw600dp/main.xml一样。

### 如何避免像这样出现重复的布局文件？

#### 解决方案一 
layout-sw600dp和layout-xlarge同时存在，建立不同的values文件夹的layout.xml

比如有一个布局要兼容大小屏幕，在Activity中引入的布局名字为activity_my_schedule：

在 res文件夹下创建不同的 values文件夹，来指向同一布局文件
res/values/layout.xml

~~~ xml
<resources>
<item name="activity_my_schedule" type="layout">@layout/activity_my_schedule_wide</item>
</resources>
~~~

res/values-sw600dp\layout.xml

~~~ xml
<resources>
<item name="activity_my_schedule" type="layout">@layout/activity_my_schedule_wide</item>
</resources>
~~~

#### 另一种解决方案 
你可以只使用一个layout布局文件，在 res文件夹下创建不同的 values文件夹，来指向不同的局文件。

我们来看Google开源项目Iosched中的实际应用，在layout下面有两个布局文件，分别用于适配大小屏幕：
> res/layout/activity_my_schedule_wide   
res/layout/activity_my_schedule_narrow

创建不同的values文件夹的layout，layout用于小屏幕，values-sw600dp-land用于横屏的情况：
res/values/layout.xml

~~~ xml
<resources>
<item name="activity_my_schedule" type="layout">@layout/activity_my_schedule_narrow</item>
</resources>
~~~

res/values-sw600dp-land\layout.xml

~~~ xml
<resources>
<item name="activity_my_schedule" type="layout">@layout/activity_my_schedule_wide</item>
</resources>
~~~

更复杂的需求，不同的情况选择不同的布局，只需要在res下面建立不同的values的layout，引用指定的布局名称即可,常见的values类型有:

> res/values/layouts.xml:   
res/values-sw600dp-land/layouts.xml:   
res/values-sw600dp-port/layouts.xml:   
res/values-xlarge-land/layouts.xml:   
res/values-xlarge-port/layouts.xml:

## 五.使用nine patch

## 六.动态设置

## 参考
[http://developer.android.com/guide/practices/screens_support.html#qualifiers]()
[http://developer.android.com/guide/practices/screens_support.html]()
[http://www.lightskystreet.com/2015/02/04/android_screen_ajust/]()
[http://blog.csdn.net/zhaokaiqiang1992/article/details/45419023]()
[http://blog.csdn.net/lmj623565791/article/details/45460089]()