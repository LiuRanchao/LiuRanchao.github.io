---
layout: post
title: WebView
tags: view
--- 
categories: Android
description: WebView 
---

## 一，与JavaScript

### 注入js

~~~ java
WebView.loadUrl("javascript: function xxx(){}");
~~~

### 调用js

~~~ java
WebView.loadUrl("javascript: function callJS()");
~~~

### 调用android的js回调

~~~ java
 mWebView.addJavascriptInterface(new WebAppInterface(getContext()), "Android");
WebView.loadUrl("javascript:window.Android.xxx()")
~~~


## 二，优化

1. 全局用一个webview， 先创建出来， 然后隐藏，解决初始化太慢问题，but浪费内存
2. 动态创建webview
3. 多进程使用webview

WebSettings

~~~ java
webSettings.setJavaScriptEnabled(true);
// 将图片调整到适合webview的大小
webSettings.setUseWideViewPort(true);
// 缩放至屏幕的大小
webSettings.setLoadWithOverviewMode(true);
webSettings.setBuiltInZoomControls(false);
// 隐藏原生的缩放控件
webSettings.setDisplayZoomControls(false);
// 设置可以访问文件
webSettings.setAllowFileAccess(true);
// 设置编码格式
webSettings.setDefaultTextEncodingName("utf-8");
// 设置H5的缓存打开,默认关闭
webSettings.setAppCacheEnabled(true);
// 数据库存储API是否可用
webSettings.setDatabaseEnabled(true);
// DOM存储API是否可用
webSettings.setDomStorageEnabled(true);
// 关闭zoom按钮
webSettings.setSupportZoom(false);
webSettings.setCacheMode(WebSettings.LOAD_DEFAULT);

// Webview在安卓5.0之前默认允许其加载混合网络协议内容
// 在安卓5.0之后，默认不允许加载http与https混合内容，需要设置webview允许其加载混合网络协议内容
if (OSVersionUtils.INSTANCE.hasLollipop()) {
    webSettings.setMixedContentMode(WebSettings.MIXED_CONTENT_ALWAYS_ALLOW);
}
if (OSVersionUtils.INSTANCE.hasKITKAT()) {
    webSettings.setLayoutAlgorithm(WebSettings.LayoutAlgorithm.TEXT_AUTOSIZING);
}
~~~

WebView

~~~ java
setVerticalScrollBarEnabled(true);

if (OSVersionUtils.INSTANCE.hasKITKAT()) {
    setLayerType(View.LAYER_TYPE_HARDWARE, null);
} else {
    setLayerType(View.LAYER_TYPE_SOFTWARE, null);
}
~~~


### 参考
- [必知必会 | WebView 的一切都在这儿](http://www.10tiao.com/html/169/201712/2650824752/1.html)







