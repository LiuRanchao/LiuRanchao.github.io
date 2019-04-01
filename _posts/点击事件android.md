---
layout: post
title: android-touch system
tags:
- touch
categories: Android
description: android onTouch 事件
---

# 一，How Android Handles Touches  

## 封装在MotionEvent

### 具体动作：

- ACTION_DOWN
- ACTION_UP
- ACTION_MOVE
- ACTION_POINTER_DOWN
- ACTION_POINTER_UP
- ACTION_CANCEL

### Event 数据包括：

- Touch location
- Number of pointers(fingers)
- Event time

通常开始于”ACTION_DOWN”，结束于”ACTION_UP”

### 每一个Event传递过程：

1. 先从硬件和底层框架产生的事件
2. 传递给Activity,是由框架调用，那个Activity的dispatchTouchEvent()来完成的（不建议大家在这里做太多事情）
3. 传递给Window
4. 传递给RootView
5. 传递给ViewGroup
6. 传递给ChildView
7. 然后事件会由底向上传递，知道某个View宣布对这个事件感兴趣为止（onTouchEvent()）。系统停止传递

__如果要对一个事件感兴趣，onTouchEvent()的ACTION_DOWN一定要return true__

__如果在ScrollView中的Button上滑动，Button的onTouchEvent(),不会收到”ACTION_UP”而是收到”ACTION_CANCEL”。因此一般都会将”ACTION_UP”和”ACTION_CANCEL”放在一起处理__

## 二，其他相关类

- ViewConfiguration类中相关常量方法，都是dp单位

 - getScaledTouchSlop() 对手势进行检查是否为scrolling
 - getScaledPagingTouchSlop()对ViewPager检查是否滑动
 - getScalledMinimunFlingVelocity() 检查fling手势

- Hover Event，悬停事件，类似鼠标设备

- GestureDetector. 手势检测器，filing，但没有up和cancel

- ScaleGestureDetector. 缩放手势检测器,但没有up和cancel，因此，在传递给Detector之前，先处理自己感兴趣的事件

- TouchDelegate.触摸代理。允许ParentView来定义特定的触摸区域，传递给子view。例如，在ListView的itemView中有个很小的view，需要点击的话，此时，在ItemView中制定那区域。

- VelocityTracker主要用跟踪触摸屏事件（flinging事件和其他gestures手势事件）的速率

## 三，参考

视频地址：    
[http://v.youku.com/v_show/id_XODQ1MjI2MDQ0.html?f=23088492&from=y1.2-3.4.2]()

Demo地址：   
[https://github.com/devunwired/custom-touch-examples]()




