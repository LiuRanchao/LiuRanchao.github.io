---
layout: post
title: android启动优化
tags:
- 优化
categories: Android
description: android启动优化
---

## 一，延迟加载

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

[http://www.zhihu.com/question/35487841](http://www.zhihu.com/question/35487841)

[http://greenrobot.me/devnews/facebook-engineer-improve-android-app/](http://greenrobot.me/devnews/facebook-engineer-improve-android-app/)

