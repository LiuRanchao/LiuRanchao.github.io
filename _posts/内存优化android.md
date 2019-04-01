---
layout: post
title: Android 内存优化
tags:
- 优化
categories: Android
description: Android 内存优化
---

## 1.注册没取消
广播 或者 单例 的注册 ，在Activity关闭时 要反注册

## 2.集合中的对象没有清理

## 3.资源对象没有关闭
如 cursor，file

## 4.没有利用已有对象，而频繁创建

## 5.对象没有及时释放
设置成null, 类变量用完尽快释放

## 6.bitmap没有及时释放

## 7.apapter没有使用缓存

## 8.线程 

1. 将线程的内部类，改为静态内部类。 
2. 在线程内部采用弱引用保存Context引用。

## 9.运用SoftRefrence

## 10.集合对象，预先设置大小

## 11.使用final 修饰static

## 12.使用增强for循环

## 13.优化过的数据结构

[SparseArray](http://developer.android.com/reference/android/util/SparseArray.html), [SparseBooleanArray](http://developer.android.com/reference/android/util/SparseBooleanArray.html), [LongSparseArray](http://developer.android.com/reference/android/support/v4/util/LongSparseArray.html)

## 14.查看ANR日志

## 15.捕获可能OOM的地方

## 16.使用静态Handler

~~~ java
private static class XXXHandler extends Handler {
private WeakReference<XXX> mXXX;
@Override
        public void handleMessage(Message msg)
        {
            super.handleMessage(msg);
            switch (msg.what)
            {
                case 0:
                    if (mXXX.get() != null)
                    {
                        // do something
                    }
                    break;
            }
        }
}
~~~

## 17.常量使用static final

## 18.避免使用浮点类型

## 19.单例对象持有Activity对象

## 20.单例对象内的数组持有生命周期应该结束的对象

## 21.调用了

~~~ java
View.getViewTreeObserver().addOnXXXListener
~~~

而没有调用

~~~ java
View.getViewTreeObserver().removeXXXListener
~~~

## 22.静态的成员变量

~~~ java
static TextView mTextViewLogin
~~~

## 23.节制的使用service 
使用IntentService

## 24.onTrimMemory()方法，进行资源释放

~~~ java
@Override  
public void onTrimMemory(int level) {  
    super.onTrimMemory(level);  
    switch (level) {  
    case TRIM_MEMORY_UI_HIDDEN:  
        // 进行资源释放操作  
        break;  
    }  
}
~~~

1. 应用程序正在运行时 
TRIM_MEMORY_RUNNING_MODERATE 表示应用程序正常运行，并且不会被杀掉。但是目前手机的内存已经有点低了，系统可能会开始根据LRU缓存规则来去杀死进程了。 
TRIM_MEMORY_RUNNING_LOW 表示应用程序正常运行，并且不会被杀掉。但是目前手机的内存已经非常低了，我们应该去释放掉一些不必要的资源以提升系统的性能，同时这也会直接影响到我们应用程序的性能。 
TRIM_MEMORY_RUNNING_CRITICAL 表示应用程序仍然正常运行，但是系统已经根据LRU缓存规则杀掉了大部分缓存的进程了。这个时候我们应当尽可能地去释放任何不必要的资源，不然的话系统可能会继续杀掉所有缓存中的进程，并且开始杀掉一些本来应当保持运行的进程，比如说后台运行的服务。

2. 应用程序被缓存 
TRIM_MEMORY_BACKGROUND 表示手机目前内存已经很低了，系统准备开始根据LRU缓存来清理进程。这个时候我们的程序在LRU缓存列表的最近位置，是不太可能被清理掉的，但这时去释放掉一些比较容易恢复的资源能够让手机的内存变得比较充足，从而让我们的程序更长时间地保留在缓存当中，这样当用户返回我们的程序时会感觉非常顺畅，而不是经历了一次重新启动的过程。 
TRIM_MEMORY_MODERATE 表示手机目前内存已经很低了，并且我们的程序处于LRU缓存列表的中间位置，如果手机内存还得不到进一步释放的话，那么我们的程序就有被系统杀掉的风险了。 
TRIM_MEMORY_COMPLETE 表示手机目前内存已经很低了，并且我们的程序处于LRU缓存列表的最边缘位置，系统会最优先考虑杀掉我们的应用程序，在这个时候应当尽可能地把一切可以释放的东西都进行释放。

因为onTrimMemory()是在API14才加进来的，所以如果要支持API14之前的话，则可以考虑 onLowMemory()这个方法，它粗略的相等于onTrimMemory()回调的TRIM_MEMORY_COMPLETE事件。

注意：当系统安装LRU cache杀进程的时候，尽管大部分时间是从下往上按顺序杀，有时候系统也会将占用内存比较大的进程纳入被杀范围，以尽快得到足够的内存。所以你的应用在LRU list中占用的内存越少，你就越能避免被杀掉，当你恢复的时候也会更快。

## 25.知晓内存的开支情况 
我们还应当清楚我们所使用语言的内存开支和消耗情况，并且在整个软件的设计和开发当中都应该将这些信息考虑在内。可能有一些看起来无关痛痒的写法，结果却会导致很大一部分的内存开支，例如：

使用枚举通常会比使用静态常量要消耗两倍以上的内存，在Android开发当中我们应当尽可能地不使用枚举。 
任何一个Java类，包括内部类、匿名类，都要占用大概500字节的内存空间。 
任何一个类的实例要消耗12-16字节的内存开支，因此频繁创建实例也是会一定程序上影响内存的。 
在使用HashMap时，即使你只设置了一个基本数据类型的键，比如说int，但是也会按照对象的大小来分配内存，大概是32字节，而不是4字节。因此最好的办法就是像上面所说的一样，使用优化过的数据集合。

## 26.为序列化的数据使用nano protobufs 
[Protocol buffers](https://developers.google.com/protocol-buffers/docs/overview)是由Google为序列化结构数据而设计的，一种语言无关，平台无关，具有良好扩展性的协议。类似XML，却比XML更加轻量，快速，简单。如果你需要为你的数据实现协议化，你应该在客户端的代码中总是使用nano protobufs。通常的协议化操作会生成大量繁琐的代码，这容易给你的app带来许多问题：增加RAM的使用量，显著增加APK的大小，更慢的执行速度，更容易达到DEX的字符限制。

关于更多细节，请参考[protobuf readme](https://android.googlesource.com/platform/external/protobuf/+/master/java/README.txt)的”Nano version”章节。

## 27.尽量避免使用依赖注入框架 
现在有很多人都喜欢在Android工程当中使用依赖注入框架，比如说像Guice或者RoboGuice等，因为它们可以简化一些复杂的编码操作，比如可以将下面的一段代码：

~~~ java
class AndroidWay extends Activity {   
    TextView name;   
    ImageView thumbnail;   
    LocationManager loc;   
    Drawable icon;   
    String myName;   

    public void onCreate(Bundle savedInstanceState) {   
        super.onCreate(savedInstanceState);   
        setContentView(R.layout.main);  
        name      = (TextView) findViewById(R.id.name);   
        thumbnail = (ImageView) findViewById(R.id.thumbnail);   
        loc       = (LocationManager) getSystemService(Activity.LOCATION_SERVICE);   
        icon      = getResources().getDrawable(R.drawable.icon);   
        myName    = getString(R.string.app_name);   
        name.setText( "Hello, " + myName );   
    }   
}
~~~

简化成这样的一种写法：

~~~ java
@ContentView(R.layout.main)  
class RoboWay extends RoboActivity {   
    @InjectView(R.id.name)             TextView name;   
    @InjectView(R.id.thumbnail)        ImageView thumbnail;   
    @InjectResource(R.drawable.icon)   Drawable icon;   
    @InjectResource(R.string.app_name) String myName;   
    @Inject                            LocationManager loc;   

    public void onCreate(Bundle savedInstanceState) {   
        super.onCreate(savedInstanceState);   
        name.setText( "Hello, " + myName );   
    }   
}
~~~

看上去确实十分诱人，我们甚至可以将findViewById()这一类的繁琐操作全部省去了。但是这些框架为了要搜寻代码中的注解，通常都需要经历较长的初始化过程，并且还可能将一些你用不到的对象也一并加载到内存当中。这些用不到的对象会一直占用着内存空间，可能要过很久之后才会得到释放，相较之下，也许多敲几行看似繁琐的代码才是更好的选择。

## 28.谨慎使用external libraries 
很多External library的代码都不是为移动网络环境而编写的，在移动客户端则显示的效率不高。至少，当你决定使用一个external library的时候，你应该针对移动网络做繁琐的porting与maintenance的工作。

即使是针对Android而设计的library，也可能是很危险的，因为每一个library所做的事情都是不一样的。例如，其中一个lib使用的是nano protobufs, 而另外一个使用的是micro protobufs。那么这样，在你的app里面就有2种protobuf的实现方式。这样的冲突同样可能发生在输出日志，加载图片，缓存等等模块里面。

同样不要陷入为了1个或者2个功能而导入整个library的陷阱。如果没有一个合适的库与你的需求相吻合，你应该考虑自己去实现，而不是导入一个大而全的解决方案。

## 29.优化整体性能 
官方有列出许多优化整个app性能的文章：[Best Practices for Performance](http://developer.android.com/training/best-performance.html). 这篇文章就是其中之一。有些文章是讲解如何优化app的CPU使用效率，有些是如何优化app的内存使用效率。

你还应该阅读[optimizing your UI](http://developer.android.com/tools/debugging/debugging-ui.html)来为layout进行优化。同样还应该关注lint工具所提出的建议，进行优化。

## 30.使用ProGuard来剔除不需要的代码 
[ProGuard](http://developer.android.com/tools/help/proguard.html)能够通过移除不需要的代码，重命名类，域与方法等方对代码进行压缩，优化与混淆。使用ProGuard可以是的你的代码更加紧凑，这样能够使用更少mapped代码所需要的RAM。

## 31 对最终的APK使用zipalign 
在编写完所有代码，并通过编译系统生成APK之后，你需要使用[zipalign](http://developer.android.com/tools/help/zipalign.html)对APK进行重新校准。如果你不做这个步骤，会导致你的APK需要更多的RAM，因为一些类似图片资源的东西不能被mapped。

Notes::Google Play不接受没有经过zipalign的APK。

## 32.分析你的RAM使用情况 
一旦你获取到一个相对稳定的版本后，需要分析你的app整个生命周期内使用的内存情况，并进行优化，更多细节请参考[Investigating Your RAM Usage](http://developer.android.com/tools/debugging/debugging-memory.html).

## 33.使用多进程 
如果合适的话，有一个更高级的技术可以帮助你的app管理内存使用：通过把你的app组件切分成多个组件，运行在不同的进程中。这个技术必须谨慎使用，大多数app都不应该运行在多个进程中。因为如果使用不当，它会显著增加内存的使用，而不是减少。当你的app需要在后台运行与前台一样的大量的任务的时候，可以考虑使用这个技术。

一个典型的例子是创建一个可以长时间后台播放的Music Player。如果整个app运行在一个进程中，当后台播放的时候，前台的那些UI资源也没有办法得到释放。类似这样的app可以切分成2个进程：一个用来操作UI，另外一个用来后台的Service.

你可以通过在manifest文件中声明’android:process’属性来实现某个组件运行在另外一个进程的操作。

~~~ xml
<service android:name=".PlaybackService"
         android:process=":background" />
~~~

## 34.检查你应该使用多少的内存 
正如前面提到的，每一个Android设备都会有不同的RAM总大小与可用空间，因此不同设备为app提供了不同大小的heap限制。你可以通过调用[getMemoryClass()](http://developer.android.com/reference/android/app/ActivityManager.html#getMemoryClass%28%29)来获取你的app的可用heap大小。如果你的app尝试申请更多的内存，会出现OutOfMemory的错误。

## 35.Bitmap优化 
Android中的大部分内存问题归根结底都是Bitmap的问题，如果打开MAT(Memory analyzer tool)来看，实际占用内存大的都是一些Bitmap(以byte数组的形式存储)。所以Bitmap的优化应该是我们着重去解决的。Google在其官方有针对Bitmap的使用专门写了一个专题 : [Displaying Bitmaps Efficiently](http://developer.android.com/training/displaying-bitmaps/index.html), 对应的中文翻译在 ：[displaying-bitmaps](https://github.com/kesenhoo/android-training-course-in-chinese/tree/master/graphics/displaying-bitmaps) , 在优化Bitmap资源之前，请先看看这个系列的文档，以确保自己正确地使用了Bitmap。

Bitmap如果没有被释放，那么一般只有两个问题：

用户在使用完这个Bitmap之后，没有主动去释放Bitmap资源。 
这个Bitmap资源被引用所以无法被释放 。

## 参考

[http://developer.android.com/training/articles/memory.html]()
[http://blog.csdn.net/a396901990/article/details/38707007]()
[http://blog.csdn.net/a396901990/article/details/37914465]()

## 相关工具
1.DDMS 
2.memory analyzer tools 
3.[https://github.com/square/leakcanary]()
