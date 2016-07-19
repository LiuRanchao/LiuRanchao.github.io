---
layout: post
title: 如何使用WebP
tags:
- WebP
categories: Jekyll
description: WebP（发音weppy），是一种同时提供了有损压缩与无损压缩的图片文件格式，派生自视频编码格式VP8，是由Google在购买On2 Technologies后发展出来，以BSD授权条款发布。 WebP最初在2010年发布，目标是减少文件大小，但达到和JPEG格式相同的图片质量，希望能够减少图片档在网络上的发送时间。 2011年11月8日，Google开始让WebP支持无损压缩和透明色的功能，而在2012年8月16日的参考实做libwebp 0.2.0中正式支持。根据Google较早的测试，WebP的无损压缩比网络上找到的PNG档少了45％的文件大小，即使这些PNG档在使用pngcrush和PNGOUT处理过，WebP还是可以减少28％的文件大小。
---
##一，安装
1.  下载最新的[webp lib](https://storage.googleapis.com/downloads.webmproject.org/releases/webp/index.html)下载并解压
2.  在安装web lib前还需要安装准备工具
Windows 需要Visual C++
Mac 需要 MacPorts   

###只以Mac为例
###安装使用MacPorts   
安装MacPorts需要xcode，这里就先不讲这个了，假设已经安装了xcode   

1.  打开[MacPorts官网](https://guide.macports.org/)  。由于pkg没有对应我的Mac版本，所以我们才用源文件的安装方式，如果是pkg的话，则就省去了以下步骤   
2. 下载[MacPorts源文件](https://distfiles.macports.org/MacPorts/MacPorts-2.3.3.tar.bz2)   
3. 解压下载好好的文件，在控制台输入如下命令    

    ```
$ cd MacPorts-2.3.3/
$ ./configure
$ make
$ sudo make install     
    ```
4.  等待自动下载后，配置环境变量。    

    ```
    export PATH=$PATH:/opt/local/bin   
    export PATH=$PATH:/opt/local/sbin/	
    ```
这样MacPorts就安装好了～～

###构建WebpLib
1.   Untar or unzip the package. This creates a directory named libwebp-0.5.0/:
tar xvzf libwebp-0.5.0.tar.gz
2.   Build WebP encoder cwebp and decoder dwebp:
Go to the directory where libwebp-0.5.0/ was extracted to and run the following commands 

    ```
    cd libwebp-0.5.0
    ./configure
    make
    sudo make install
    ```
OK。这样就可以使用webp啦～

##二，使用
具体使用规则 [参考文档](https://developers.google.com/speed/webp/docs/cwebp)   

1.   png to WebP

	```
    cwebp -q 80 image.png -o image.webp1
	``` 
2.   webp to png   

	```
	dwebp image.webp -o image.png
	```


##参考
1. [在线转换](https://convertio.co/zh/webp-jpg/)
2. 相关官网

    >https://developers.google.com/speed/webp/
https://guide.macports.org/

