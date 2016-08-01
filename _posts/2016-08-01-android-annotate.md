---
layout: post
title: android-注解
tags:
- 注解
categories: Android
description: android-注解
---

## 系统注解

@NonNull：不允许为null    
@NULLABLE：允许为 null    
@CheckResult：检查return的直 是否 有使用    
@Keep ：不被混淆   
@StringRes ：必须写入 R.string.xxx    
@AnyRes ：任何 R.xxx.xxx    
@IntDef ：@StringDef 定义常量 类似枚举   
@UiThread @MainThread @WorkerThread @BinderThread ：声明该方法的所在线程    
@ColorInt ：声明Color的值，不是R.color.xxxx    
@Size, @IntRange, @FloatRange ：限制范围    
@RequiresPermission ：需要权限的声明    
@CallSuper ：需要调用super    
@VisibleForTesting ：声明变量为测试所用   



## 参考

官方网站：[http://tools.android.com/tech-docs/support-annotations]()
