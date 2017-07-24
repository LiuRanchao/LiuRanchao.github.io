---
layout: post
title: android启动优化
tags:
- 优化
categories: Android
description: android启动优化
---

### 一，延迟加载

~~~ java
//     第三种写法:优化的DelayLoad
      getWindow().getDecorView().post(new Runnable() {
            @Override
            public void run() {
                myHandler.post(mLoadingRunnable);
            }
        });
~~~

转载：[http://www.jianshu.com/p/09b115dcb909]()


### 参考

 - [应用启动优化:一种DelayLoad的实现和原理(上篇)](http://www.jianshu.com/p/09b115dcb909)
 - [Facebook工程师是如何改进他们Android客户端的](http://greenrobot.me/devnews/facebook-engineer-improve-android-app/)
 - [Launch-Time Performance](https://developer.android.com/topic/performance/launch-time.html)
 - [Android性能优化（一）之启动加速35%](http://www.jianshu.com/p/f5514b1a826c)

