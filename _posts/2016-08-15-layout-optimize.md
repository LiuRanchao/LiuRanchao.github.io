---
layout: post
title: Android布局优化
tags:
- 优化
categories: Android
description: Android布局优化
---

# 一、ListView优化

### 1，Adapter
getView()中缓存view,使用ViewHolder

### 2，细化Item
讲getView中的布局细化，多使用type

### 3，减少不必要的视图更新
ListView在滚动时会请求重新获取item，来显示不同内容的item，而如果在获取item时比较耗时就会造成在滚动时出现卡顿的现象。 
那我们可以通过监听ListView的滚动事件来使ListView处于不同的滚动状态时做不同的事情。

比如在ListView处于滚动过程中加载少量的显示数据，当ListView处于空闲的状态时再加载所有的数据，这样就可以减少ListView在滚动过程中的开销，从而提供ListView的滚动速度。

### 4，减少item view层级

# 二，一般布局

### 5，使用include标签

### 6，使用viewstub标签

### 7，使用merge标签

