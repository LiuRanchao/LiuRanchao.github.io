---
layout: post
title: Android文档－Training(Best Practices for Interaction and Engagement)
tags:
- 文档
categories: Android
description: Android文档－Training Best Practices for Interaction and Engagement
---

## 一，Designing for Multiple Screens

#### 支持不同的屏幕大小

1. 使用```wrap_content```和```match_parent```     
2. 使用```RelativeLayout```    
3. 使用大小限定符    

	a.```res/layout/main.xml```, single-pane (default) layout ：
	
	~~~ xml
	<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
	    android:orientation="vertical"
	    android:layout_width="match_parent"
	    android:layout_height="match_parent">
	
	    <fragment android:id="@+id/headlines"
	              android:layout_height="fill_parent"
	              android:name="com.example.android.newsreader.HeadlinesFragment"
	              android:layout_width="match_parent" />
	</LinearLayout>
	~~~

	b.```res/layout-large/main.xml```, two-pane layout
	
	~~~ xml
	<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
	    android:layout_width="fill_parent"
	    android:layout_height="fill_parent"
	    android:orientation="horizontal">
	    <fragment android:id="@+id/headlines"
	              android:layout_height="fill_parent"
	              android:name="com.example.android.newsreader.HeadlinesFragment"
	              android:layout_width="400dp"
	              android:layout_marginRight="10dp"/>
	    <fragment android:id="@+id/article"
	              android:layout_height="fill_parent"
	              android:name="com.example.android.newsreader.ArticleFragment"
	              android:layout_width="fill_parent" />
	</LinearLayout>
	~~~

4. 使用最小宽度限定

	a.```res/layout/main.xml```, single-pane (default) layout:
	
	~~~ xml
	<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
	    android:orientation="vertical"
	    android:layout_width="match_parent"
	    android:layout_height="match_parent">
	
	    <fragment android:id="@+id/headlines"
	              android:layout_height="fill_parent"
	              android:name="com.example.android.newsreader.HeadlinesFragment"
	              android:layout_width="match_parent" />
	</LinearLayout>
	~~~
	
	b. ```res/layout-sw600dp/main.xml```, two-pane layout:
	
	~~~ xml
	<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
	    android:layout_width="fill_parent"
	    android:layout_height="fill_parent"
	    android:orientation="horizontal">
	    <fragment android:id="@+id/headlines"
	              android:layout_height="fill_parent"
	              android:name="com.example.android.newsreader.HeadlinesFragment"
	              android:layout_width="400dp"
	              android:layout_marginRight="10dp"/>
	    <fragment android:id="@+id/article"
	              android:layout_height="fill_parent"
	              android:name="com.example.android.newsreader.ArticleFragment"
	              android:layout_width="fill_parent" />
	</LinearLayout>
	~~~

5. 使用布局别名

	a. res/values-large/layout.xml:
	
	~~~ xml
	<resources>
	    <item name="main" type="layout">@layout/main_twopanes</item>
	</resources>
	~~~
	
	b. res/values-sw600dp/layout.xml:
	
	~~~ xml
	<resources>
	    <item name="main" type="layout">@layout/main_twopanes</item>
	</resources>
	~~~

6. 使用方向限定符

	a. res/values-sw600dp-land/layouts.xml:
	
	~~~ xml
	<resources>
	    <item name="main_layout" type="layout">@layout/twopanes</item>
	    <bool name="has_two_panes">true</bool>
	</resources>
	~~~
	
	b. res/values-sw600dp-port/layouts.xml:
	
	~~~ xml
	<resources>
	    <item name="main_layout" type="layout">@layout/onepane</item>
	    <bool name="has_two_panes">false</bool>
	</resources>
	~~~
	
7.  使用Nine-patch Bitmaps
	
