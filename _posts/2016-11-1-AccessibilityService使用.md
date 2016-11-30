---
layout: post
title: AccessibilityService使用
tags:
- AccessibilityService
categories: Android
description: AccessibilityService使用
---

### 作用

用于模拟用户行为，检测页面变化等。例如“微信抢红包”就利用的该技术。

### 如何使用

1.创建自己的AccessibilityService

~~~ java
public class MyAccessibilityService extends AccessibilityService
~~~

回调方法：

~~~ java
/**
 * 打断获取事件的过程,可以用来关闭资源
 */
@Override
public void onInterrupt() {
}
~~~

~~~
/**
 * 用来绑定服务的方法，可以做一些关于AccessibilityServiceInfo 的初始配置
 */
@Override
protected void onServiceConnected() {
   super.onServiceConnected();
} 
~~~

最核心的回调方法：<br>
用来接收系统反馈回来的各种事件

~~~ java
@Override
public void onAccessibilityEvent(AccessibilityEvent event) {
	final int eventType = event.getEventType();
	if (eventType == AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED) {
		// 处理页面窗口变化
	} else if (eventType == AccessibilityEvent.TYPE_WINDOW_CONTENT_CHANGED) {
		// 处理页面内容变化
	}
}
~~~


2.在res/xml/下创建accessible_service_config.xml<br>
```android:packageNames```中声明要监听的app的包名，多个以```,```分隔<br>
```accessibilityEventTypes```中声明要监听的事件类型

~~~ java
<accessibility-service
    xmlns:android="http://schemas.android.com/apk/res/android"
    android:accessibilityEventTypes="typeAllMask"
    android:accessibilityFeedbackType="feedbackGeneric"
    android:accessibilityFlags="flagDefault"
    android:canRequestEnhancedWebAccessibility="true"
    android:canRequestTouchExplorationMode="true"
    android:canRetrieveWindowContent="true"
    android:description="@string/app_name"
    android:notificationTimeout="100"
    android:packageNames="com.xxx.aaa,com.android.packageinstaller"/> 
~~~

3.在AndroidManifest.xml中声明AccessibilityService

~~~ java
<service
    android:name=".service.MyAccessibilityService"
    android:permission="android.permission.BIND_ACCESSIBILITY_SERVICE">
    <intent-filter>
        <action android:name="android.accessibilityservice.AccessibilityService"/>
    </intent-filter>

    <meta-data
        android:name="android.accessibilityservice"
        android:resource="@xml/accessible_service_config"/>
</service>
~~~

4.在获取页面控件

~~~ java
@Override
public void onAccessibilityEvent(AccessibilityEvent event) {
	 if (eventType == AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED) {
			String packageName = event.getPackageName().toString();
          	LogUtils.d("窗口改变的packageName==" + packageName);
          	String activityName = event.getClassName().toString();
          	LogUtils.d("窗口改变的activityName===" + activityName);
          	
          	// 此时event.getSource()为根View
            // getRootInActiveWindow()得到根view
                
	 } else if (eventType == AccessibilityEvent.TYPE_WINDOW_CONTENT_CHANGED) {
                String viewName = event.getClassName().toString();
                LogUtils.i("内容改变的viewName ===" + viewName);
                
                // 此时event.getSource()为内容改变的View
                // getRootInActiveWindow()得到根view
            }
}
~~~

### 参考

- [微信抢红包](http://www.jianshu.com/p/4cd8c109cdfb)


