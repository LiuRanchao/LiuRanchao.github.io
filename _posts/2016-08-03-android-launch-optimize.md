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
