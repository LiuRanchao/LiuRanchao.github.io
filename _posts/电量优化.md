---
layout: post
title: android-电量优化
tags:
- 优化
categories: Android
description: android-电量优化
---

## 一，网络相关  

- 把零散的网络请求打包成一个
- 集中网络请求时间，减少唤醒Wi-Fi的次数
- 通过预先加载方式
- 减少请求数量
- 连接网络前，检查网络是否可用，如果不可用就不需要执行响应的程序


## 二，屏幕相关

- 减少唤醒屏幕的次数和持续时间 


## 三，其他

- 某些操作可以在充电时处理，e.g.统计请求，或预加载一些请求

## 参考

[https://developer.android.com/intl/zh-cn/training/efficient-downloads/index.html]()


