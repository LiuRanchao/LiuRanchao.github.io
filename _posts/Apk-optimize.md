---
layout: post
title: Android APK优化
tags:
- 优化
categories: Android
description: Android APK优化
---

#### 1. 开启minifyEnabled
#### 2. 开启shrinkResources
#### 3. 已经去除不相关的大型库
#### 4. 图片和代码已经经历过粗略的一轮清理
#### 5. tinypng有损压缩
[https://tinypng.com/]()
#### 6. png换成jpg
一些背景，启动页，宣传页的PNG图片比较大，这些图片图形比较复杂，如果转用有损JPG可能只有不到一半（当然是有损，不过通过设置压缩参数可以这种损失比较小到忽略）。
#### 7. jpg换成webp
#### 8. 大图缩小
#### 9. 覆盖aar里的一些默认的大图
一些aar库里面包含根本就没有用的图。最典型的是support-v4兼容库中包含一些“可能”用到的图片，实际上在你的app中不会用到。

![](https://github.com/lrchao/lrchao.github.io/blob/master/image/2016-08-03-android-apk-optimize/apk_reduce_support_res_override.png?raw=true)

我没有把所有图都替换掉，只是把几张大一点点的图（选中的那些图）用1x1的图片替换，如果9patch图的话，要做成3x3的9patch图替换。
support库可能还算好的，就怕有些库引用了一些大图而不自知，可以在/build/intermediates/exploded-aar/下的各个aar库的res目录查找检验。
apk减小了18k。

#### 10. 删除armable-v7包的so
感谢@杨辉__ ,@kymjs张涛的提醒，armable-v7和armable文件夹可以只保留armable。
当然，armable-v7a的库会对图形渲染方面有很大的改进，因为我们主要是一些业务上动态库，所以删掉无大碍。

![](https://github.com/lrchao/lrchao.github.io/blob/master/image/2016-08-03-android-apk-optimize/apk_reduce_armable_v7_so.png?raw=true)

#### 11. 微信资源压缩打包
这个方案网上一直在说，之前一直没有需求或者动力实践，在这里感谢一下@裸奔的凯子哥的推荐和交流，他那边的apk可以压小1M，效果还是比较惊人的。
这个步骤我是在后面很多步压缩之后测试的，每个阶段的压缩结果都会有些许出入，所以数据仅供参考。

![](https://github.com/lrchao/lrchao.github.io/blob/master/image/2016-08-03-android-apk-optimize/apk_reduce_wechat_7zip.png?raw=true)

通过正常压缩，apk包减小了464k。
如果开启7zip，apk包减小了594k。
apk减小了594k。

PS: 官方已经发布AndResGuard到gradle中，非常方便：

~~~ java
apply plugin: 'AndResGuard'
buildscript {
    dependencies {
        classpath 'com.tencent.mm:AndResGuard-gradle-plugin:1.1.7'
    }
}
andResGuard {
    mappingFile = null
    use7zip = true
    useSign = true
    keepRoot = false
    // add <your_application_id>.R.drawable.icon into whitelist.
    // because the launcher will get thgge icon with his name
    def packageName = <your_application_id>
    whiteList = [
        //for your icon
        packageName + ".R.drawable.icon",
        //for fabric
        packageName + ".R.string.com.crashlytics.*",
        //for umeng update
        packageName + ".R.string.umeng*",
        packageName + ".R.string.UM*",
        packageName + ".R.string.tb_*",
        packageName + ".R.layout.umeng*",
        packageName + ".R.layout.tb_*",
        packageName + ".R.drawable.umeng*",
        packageName + ".R.drawable.tb_*",
        packageName + ".R.anim.umeng*",
        packageName + ".R.color.umeng*",
        packageName + ".R.color.tb_*",
        packageName + ".R.style.*UM*",
        packageName + ".R.style.umeng*",
        packageName + ".R.id.umeng*"
    ]
    compressFilePattern = [
        "*.png",
        "*.jpg",
        "*.jpeg",
        "*.gif",
        "resources.arsc"
    ]
    sevenzip {
        artifact = 'com.tencent.mm:SevenZip:1.1.7'
        //path = "/usr/local/bin/7za"
    }
}
~~~

会生成一个andresguard/resguard的Task，自动读取release签名进行重新混淆打包。

详情参考：[Android资源混淆工具使用说明](https://github.com/shwenzhang/AndResGuard) 

原理介绍：[安装包立减1M–微信Android资源混淆打包工具](http://mp.weixin.qq.com/s?__biz=MzAwNDY1ODY2OQ==&mid=208135658&idx=1&sn=ac9bd6b4927e9e82f9fa14e396183a8f#rd)

#### 12. proguard深度混淆代码
之前为了简单起见，很多包都直接忽略了，现在启动严格模式，把能混淆的都混淆了：

![](https://github.com/lrchao/lrchao.github.io/blob/master/image/2016-08-03-android-apk-optimize/apk_reduce_proguard_package.png?raw=true)

采用微信压缩方案最终效果比较：

![](https://github.com/lrchao/lrchao.github.io/blob/master/image/2016-08-03-android-apk-optimize/apk_reduce_proguard_package_final.png?raw=true)

apk减小了215k。

PS:混淆后，一定要经过严格测试，有时候甚至很难发现错误，比如我开启严格混淆，用了一段时间之后慢慢发现了两个bug，排除了两个包程序才正常。

#### 13. 从服务端下载文件

#### 14. 开源库裁剪

#### 15. proguard去符号表
之前为了保留调试信息，我们是在Proguard保留了符号表的：

~~~ java
-keepattributes SourceFile,LineNumberTable
~~~

官方渠道我觉得还是尽量保留这个，现在针对推广渠道，只能采用特殊手段，注释这一行。
apk减小了230k。<br>
ps:以后友盟上看推广渠道的bug要辛苦一点，手动上传mapping.txt了。

#### 16. provided关键字
可以对仅在运行时需要的库设置provided关键字，实际并不被打包：

~~~ java
provided 'com.android.support:support-annotations:22.0.0'
~~~

我没有发现这样的场景，如果说有的话，就是support-annotations，但是经过后来的测试验证，support-annotations本来就会在release版本中被minifyEnabled掉，所以对support-annotations设置provided是没有意义的。
如果有实际场景，欢迎留言说明，不甚感激。
apk没有减小。

#### 17. 表情包在线化
虽然应用的表情不多，只有50来个，但是如果能把这部分表情放到网上，不仅能有效减小apk大小，还可以方便后期扩展支持：

![](https://github.com/lrchao/lrchao.github.io/blob/master/image/2016-08-03-android-apk-optimize/apk_reduce_emoji_list.png?raw=true)

#### 18. 全版本兼容的着色方案
考虑着色方案主要目的是更方便支持多主题，减轻UI工作量，减少工程里一大堆selector文件等，然后才是，顺便的减小一下apk大小。<br>
通过着色方案，我们去除了10多张纯色的按下状态图片和对应的xml等等。
PS: 具体实现可以参考 [http://www.race604.com/tint-drawable/](http://www.race604.com/tint-drawable/)

#### 19. 去除重复库
发现两个地方：

> 现在发现七牛的SDK引用了android-async-http-1.4.6.jar，虽然不大，只有95.4k，但是感觉完全可以写一个轻量级的jar，控制在10～20k就足够了，具体可以在现有的网络库上实现。<br>
> <br>
> 自己工程使用的是UIL，但是引入的第三方库引用了picasso，两个重复的图片下载库也是完全没用必要的。

现在还没有处理这块，新任务介入，延期优化，敬请期待。

#### 20. 插件化

#### 21. Facebook的redex优化字节码
redex是facebook发布的一款android字节码的优化工具，需要按照说明文档自行配置一下。

~~~ java
redex input.apk -o output.apk --sign -s <KEYSTORE> -a <KEYALIAS> -p <KEYPASS>
~~~

下面我们来看看它的效果，仅redex的话，减小了157k：

![](https://github.com/lrchao/lrchao.github.io/blob/master/image/2016-08-03-android-apk-optimize/apk_reduce_redex.png?raw=true)

如果先进行微信混淆，再redex，减小了565k，redex只贡献了10k：

![](https://github.com/lrchao/lrchao.github.io/blob/master/image/2016-08-03-android-apk-optimize/apk_reduce_resguard_redex.png?raw=true)

如果先进行redex，在进行微信混淆，减小了711k，redex贡献了157k：

![](https://github.com/lrchao/lrchao.github.io/blob/master/image/2016-08-03-android-apk-optimize/apk_reduce_redex_resguard.png?raw=true)

最后一种的效果是最好的，这是很容易解释的，如果最后是redex的重新打包则浪费了前面的7zip压缩，所以为了最优效果要注意顺序。
另外，据反应redex后会有崩溃的现象，这个要留意一下，我这里压缩之后都是可以正常运行的。

详情参考：[ReDex: An Android Bytecode Optimizer](https://github.com/facebook/redex)

#### 22. 去除无用的语言资源
通过配置resConfigs可以选择只打包哪几种语言，进而去掉各种aar包中全世界的语言，尤其是support包中的。

![]()

选择保留什么语言要根据产品的用户和市场来定，如果只选择默认英语和中文语言，配置如下

~~~ java
android {
    defaultConfig {
        resConfigs "zh"
    }
}
~~~

如果不采用微信压缩方案结果对比，apk减小了197k。
如果采用微信压缩（开启7zip）对比结果，apk只减小了16k，因为微信对resources.arsc进行了强力压缩，厉害！ <br>
apk减小了16k

#### 23. 删除x86包的so
x86的包删除了之后，测试反应好像有些机器容易崩溃，未能经过严格测试，所以主版本又复原了，只在个别渠道执行这条措施。
一般情况下不会有问题，测试了一下效果，apk减小了78k。
这里作为候选方案备用。

### 参考：

- [APK瘦身实践](http://jayfeng.com/2015/12/29/APK%E7%98%A6%E8%BA%AB%E5%AE%9E%E8%B7%B5/)
- [如何将apk大小减少6M的](http://blog.csdn.net/UsherFor/article/details/46827587)

