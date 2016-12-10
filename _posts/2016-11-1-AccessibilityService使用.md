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

~~~ java
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

### 文档说明

#### AccessibilityServiceInfo属性

- #### android:accessibilityEventTypes  接收事件类型AccessibilityEvent

	- TYPE_VIEW_CLICKED：被点击事件。Button、CompoundButton
	- TYPE_VIEW_LONG_CLICKED：被长按事件Button。CompoundButton
	- TYPE_VIEW_SELECTED：被选中的事件。AdapterView
	- TYPE_VIEW_FOCUSED：获得焦点事件。
	- TYPE_VIEW_TEXT_CHANGED：输入内容改变事件。EditText
	- TYPE_VIEW_TEXT_SELECTION_CHANGED ：输入的索引改变事件。EditText
	- TYPE_VIEW_TEXT_TRAVERSED_AT_MOVEMENT_GRANULARITY：text在view里移动事件
	- TYPE_VIEW_SCROLLED：滑动事件。
	- TYPE_WINDOW_STATE_CHANGED：Window变化事件。例如打开PopupWindow、Menu、Dialog。etc.
	- TYPE_WINDOW_CONTENT_CHANGED：Window的内容变化。adding/removeing view, changing a view size, etc.
	- TYPE_WINDOWS_CHANGED：Window显示在屏幕上的变化。例如window显示，window消失，window大小变化，window图层变化等
	- TYPE_NOTIFICATION_STATE_CHANGED：显示通知事件。
	- TYPE_VIEW_HOVER_ENTER：悬停在view上的进入事件。
	- TYPE_VIEW_HOVER_EXIT:悬停在view上的离开事件。
	- TYPE_TOUCH_INTERACTION_START:用户开始点击屏幕事件。
	- TYPE_TOUCH_INTERACTION_END:用户结束点击屏幕事件。
	- 。。。
 
- #### android:accessibilityFeedbackType：表示设置反馈给用户的方式，常见的有语音播报，手机振动等

- #### android:accessibilityFlags：标示

	- flagDefault： 默认的
	- flagIncludeNotImportantViews：标志包括不重要的view
	- flagRequestTouchExplorationMode：标志请求触摸探测模式
	- flagRequestEnhancedWebAccessibility：标记请求增强的Web可访问性
	- flagReportViewIds：报告视图ID标志
	- flagRequestFilterKeyEvents：标记要求过滤的关键事件
	- flagRetrieveInteractiveWindows：标记检索交互窗口
 
#### - android:canRequestEnhancedWebAccessibility：是否增强WebView的服务

#### - android:canRequestFilterKeyEvents：

#### - android:canRequestTouchExplorationMode：是否需要触摸模式

#### - android:canRetrieveWindowContent：表示是否可以获取当前窗口内容，true表示可以获取否则不可以获取
#### - android:description：表示对当前辅助功能的描述，该值会在Android设置的辅助列表中显示
#### - android:notificationTimeout： 表示两个相同的时间发送的时间间隔
#### - android:packageNames：表示当前辅助服务需要监听的应用包名，用逗号分隔。
#### - android:settingsActivity：允许用户修改此服务的设置的活动的组件名称。



### 参考

- [微信抢红包](http://www.jianshu.com/p/4cd8c109cdfb)
- [Accessibility 实现抢红包(一)](http://blog.csdn.net/yun1185448859/article/details/51959207)
- [Android自动化测试中AccessibilityService获取控件信息（1）](http://blog.csdn.net/itfootball/article/details/21953763)


