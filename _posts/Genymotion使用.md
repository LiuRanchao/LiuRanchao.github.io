---
layout: post
title: Genymotion使用
tags:
- Genymotion
categories: Tools
description: Genymotion使用
---

# 一、安装google play

步骤如下：

1. 下载[Genymoton-ARM-Translation_v1.1.zip](https://mega.nz/#!GJ4kzLzC!HBEZC10MArECeZhJyfbA7lzYG1JVaabGNRUXvBp9o-0), [備用載點](http://1drv.ms/1V1dTNj) ,[備用載點2](http://pan.baidu.com/s/1jGzXVym)
2. 將下載好的ZIP檔拖曳到Genymotion模擬器的畫面，它會自己安裝
3. 安裝結束後，重啟模擬器
4. 下载Install gapps ：[Android 5.0.x](https://www.androidfilehost.com/?fid=95784891001614559), [Android 4.4.x](https://www.androidfilehost.com/?fid=95832962473395379), [Android 4.3.x](https://www.androidfilehost.com/?fid=23060877490000124), [Android 4.2.x](https://www.androidfilehost.com/?fid=23060877490000128), [Android 4.1.x](https://www.androidfilehost.com/?fid=22979706399755082), [Android 4.0.x](https://www.androidfilehost.com/?fid=22979706399755108), [Android 2.3.3](https://www.androidfilehost.com/?fid=22979706399755027)
5. 下载成功后，拖进模拟器
6. 安装成功后，重启模拟器
7. 打开模拟器后，会看到提示“Google Play services has stopped“，此时，打开Google Play Store，进行登录认证
8. 然后更新GoogleService

so done~ (此过程都要在墙外操作)
	
# 二、使用 Fiddler抓包

### windows

In your virtual device  

1. Go to Android settings menu
2. In Wireless & Networks section, select Wi-Fi
3. Press and hold for 2 seconds WiredSSID network in the list
4. Choose Modify Network
5. Check Show advanced options
6. Select Manual for Proxy settings menu entry
7. Enter the proxy address: the Fiddler-running PC's **IPAddress** and Port **8888**
Press the Save button

### In Fiddler

1. Click Tools menu > Fiddler Options > Connections
2. Tick the **Allow Remote Computers to connect** box
3. Restart Fiddler.

同时浏览器要设置

![](http://ww4.sinaimg.cn/mw690/5ecfffbagw1f73f00a639j20by0dzgmp.jpg)

# 三、SDCard中添加文件

1. 在Oracle VM VirtualBox在对应的模拟器右键打开设置
2. 共享文件夹
3. 添加文件夹
4. 自动挂载
5. 在模拟器中打开mnt/shared/新建的共享文件名

# 参考

- [http://inthecheesefactory.com/blog/how-to-install-google-services-on-genymotion/en]()
- [http://stackoverflow.com/questions/21554235/how-to-setup-fiddler-and-genymotion]()
- [https://plus.google.com/+GenymotionEmulator/posts/d2ogLdU1rZw]()
- [Genymotion安装配置指南](http://www.snowdream.tech/2016/10/17/android-genymotion-install-and-settings/)

