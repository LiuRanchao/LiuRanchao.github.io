---
layout: post
title: Android-优化之ANR
tags:
- 优化
categories: Android
description: Android-优化之ANR
---

## 一，原因 

1. 触摸事件5秒未响应
2. 广播10秒未处理完
3. ServiceTimeout 20秒未处理完
4. 线程死锁

## 二，如何分析

1. 开源框架ANR-WatchDog [https://github.com/SalomonBrys/ANR-WatchDog]()

## 三，如何修改

1. 使用子线程处理耗时操作，例如：网络、数据库、I/0
2. UI线程尽量只做View的操作
3. 使用Handler



