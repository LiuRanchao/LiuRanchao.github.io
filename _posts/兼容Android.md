---
layout: post
title: Android－兼容问题
tags:
- 兼容
categories: Android
description: Android－兼容问题
---

### 1，PopupWindow自定义问题

自定义时，会抛setContentView nullpointexception    
[http://blog.csdn.net/tz2101/article/details/21706765]()

### 2，通知点击不跳转问题 
使用PushDialogActivity,用来显示通知点击跳转的界面无法显示 
或者

~~~ java
PendingIntent resultPendingIntent =
                stackBuilder.getPendingIntent(
                        0,
                        PendingIntent.FLAG_UPDATE_CURRENT
                );
~~~

将”0”改为随机数

### 3，通知图片不显示问题 

由于5.0（21）以后，图标为白色导致.    
[https://www.google.com/design/spec/patterns/notifications.html]()

~~~ java
/**
 * 设置通知的icon, 根据5.0兼容
 *
 * @return notification icon
 */
private int getNotificationIcon() {
        boolean whiteIcon = (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP);
        return whiteIcon ? R.drawable.ic_notify_lollipop : 	R.drawable.ic_notify;
    }
~~~