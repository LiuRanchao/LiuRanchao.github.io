---
layout: post
title: Android－ListView
tags:
- ListView
categories: Android
description: Android－ListView
---

#### 1. android:stackFromBottom

在ListView和GridView中使用，使它们的内容从底部开始显示。

#### 2. android:transcriptMode

设置列表的transcriptMode模式，该模式指定列表添加新的选项的时候，是否自动滑动到底部，显示新的选项。 

 - disabled：取消transcriptMode模式，默认的 
 - normal：当接受到数据集合改变的通知，并且仅仅当最后一个选项已经显示在屏幕的时候，自动滑动到底部。 
 - alwaysScroll：无论当前列表显示什么选项，列表将会自动滑动到底部显示最新的选项。 

#### 3. android:cacheColorHint

该属性在官方文档和个资料中找不到比较好的描述；根据实际的体验，当你设置的ListView的背景时，应该设置该属性为“#00000000”（透明），不然在滑动的时候，列表的颜色会变黑或者背景图片小时的情况！ 

#### 4. android:divider

列表之间绘制的颜色或者图片。一般开发中用于分隔表项。 
在实际开发过程中，如果你不想要列表之间的分割线，可以设置属性为@null

#### 5. android:fadingEdge

设置列表的阴影

#### 6. android:fastScrollEnabled

启用快速滑动条，它能快速的滑动列表。但在实际的测试中发现，当你的数据比较小的时候，是不会显示快速滚动条。 

#### 7. android:listSelector

用来指明列表当前选中的选项的图片

#### 8. android:drawSelectorOnTop

设置为true时候，listSelector的图片将会被绘制在被选中的选项之上。 

#### 9. android:choiceMode

定义了列表的选择行为，默认的情况下，列表没有选择行为。 

 - none：正常不指定选择的列表 
 - singleChoice：列表允许一个选择 
 - multipleChoice：列表允许选择多个

