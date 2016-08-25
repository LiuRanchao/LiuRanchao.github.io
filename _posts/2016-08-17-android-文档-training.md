---
layout: post
title: Android文档－Training(Best Practices for Interaction and Engagement)
tags:
- 文档
categories: Android
description: Android文档－Training Best Practices for Interaction and Engagement
---

## 一，Designing Effective Navigation

### 1，Planning Screens and Their Relationships

![](https://developer.android.com/images/training/app-navigation-screen-planning-erd.png)

### 2，Planning for Multiple Touchscreen Sizes

### 3，Providing Descendant and Lateral Navigation

### 4，Providing Ancestral and Temporal Navigation

### 5，Putting it All Together: Wireframing the Example App

## 二，Implementing Effective Navigation

### 1，Creating Swipe Views with Tabs

##### a，Implement Swipe Views

##### b，ViewPager

需要关联一个```PagerAdapter```
有两种Adapter可以使用：

- ```FragmentPagerAdapter```  page数量固定，而且比较少
- ```FragmentStatePagerAdapter``` page数量不确定，每次滑动到另一个pages时，销毁当前page

##### c，Add Tabs to the Action Bar

~~~ java
@Override
public void onCreate(Bundle savedInstanceState) {
    final ActionBar actionBar = getActionBar();
    ...

    // Specify that tabs should be displayed in the action bar.
    actionBar.setNavigationMode(ActionBar.NAVIGATION_MODE_TABS);

    // Create a tab listener that is called when the user changes tabs.
    ActionBar.TabListener tabListener = new ActionBar.TabListener() {
        public void onTabSelected(ActionBar.Tab tab, FragmentTransaction ft) {
            // show the given tab
        }

        public void onTabUnselected(ActionBar.Tab tab, FragmentTransaction ft) {
            // hide the given tab
        }

        public void onTabReselected(ActionBar.Tab tab, FragmentTransaction ft) {
            // probably ignore this event
        }
    };

    // Add 3 tabs, specifying the tab's text and TabListener
    for (int i = 0; i < 3; i++) {
        actionBar.addTab(
                actionBar.newTab()
                        .setText("Tab " + (i + 1))
                        .setTabListener(tabListener));
    }
}
~~~

##### d，Change Tabs with Swipe Views

~~~ java
@Override
public void onCreate(Bundle savedInstanceState) {
    ...

    // Create a tab listener that is called when the user changes tabs.
    ActionBar.TabListener tabListener = new ActionBar.TabListener() {
        public void onTabSelected(ActionBar.Tab tab, FragmentTransaction ft) {
            // When the tab is selected, switch to the
            // corresponding page in the ViewPager.
            mViewPager.setCurrentItem(tab.getPosition());
        }
        ...
    };
}
~~~

~~~ java
@Override
public void onCreate(Bundle savedInstanceState) {
    ...

    mViewPager = (ViewPager) findViewById(R.id.pager);
    mViewPager.setOnPageChangeListener(
            new ViewPager.SimpleOnPageChangeListener() {
                @Override
                public void onPageSelected(int position) {
                    // When swiping between pages, select the
                    // corresponding tab.
                    getActionBar().setSelectedNavigationItem(position);
                }
            });
    ...
}

~~~

##### e，Use a Title Strip Instead of Tabs

~~~ xml
<android.support.v4.view.ViewPager
    xmlns:android="http://schemas.android.com/apk/res/android"
    android:id="@+id/pager"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <android.support.v4.view.PagerTitleStrip
        android:id="@+id/pager_title_strip"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_gravity="top"
        android:background="#33b5e5"
        android:textColor="#fff"
        android:paddingTop="4dp"
        android:paddingBottom="4dp" />

</android.support.v4.view.ViewPager>
~~~

### 2，Creating a Navigation Drawer

##### a，Create a Drawer Layout

```DrawerLayout```

~~~ xml
<android.support.v4.widget.DrawerLayout
    xmlns:android="http://schemas.android.com/apk/res/android"
    android:id="@+id/drawer_layout"
    android:layout_width="match_parent"
    android:layout_height="match_parent">
    <!-- The main content view -->
    <FrameLayout
        android:id="@+id/content_frame"
        android:layout_width="match_parent"
        android:layout_height="match_parent" />
    <!-- The navigation drawer -->
    <ListView android:id="@+id/left_drawer"
        android:layout_width="240dp"
        android:layout_height="match_parent"
        android:layout_gravity="start"
        android:choiceMode="singleChoice"
        android:divider="@android:color/transparent"
        android:dividerHeight="0dp"
        android:background="#111"/>
</android.support.v4.widget.DrawerLayout>
~~~

特点：

- The main content view (the FrameLayout above) must be the **first child** in the DrawerLayout
- The main content view is set to **match the parent** view's width and height
- The drawer view (the ListView) **must specify its horizontal gravity** with the android:layout_gravity attribute
- The drawer view specifies its width in dp units and the **height matches the parent view**

##### b，Initialize the Drawer List

##### c，Handle Navigation Click Events

When the user selects an item in the drawer's list, the system calls [onItemClick()](https://developer.android.com/reference/android/widget/AdapterView.OnItemClickListener.html#onItemClick(android.widget.AdapterView<?>, android.view.View, int, long)) on the [OnItemClickListener](https://developer.android.com/reference/android/widget/AdapterView.OnItemClickListener.html) given to [setOnItemClickListener()](https://developer.android.com/reference/android/widget/AdapterView.html#setOnItemClickListener(android.widget.AdapterView.OnItemClickListener)).

##### d，Listen for Open and Close Events

call [setDrawerListener()](https://developer.android.com/reference/android/support/v4/widget/DrawerLayout.html#setDrawerListener(android.support.v4.widget.DrawerLayout.DrawerListener)) on your [DrawerLayout](https://developer.android.com/reference/android/support/v4/widget/DrawerLayout.html) and pass it an implementation of DrawerLayout.DrawerListener.

##### e，Open and Close with the App Icon

- [ActionBarDrawerToggle](https://developer.android.com/reference/android/support/v4/app/ActionBarDrawerToggle.html)

### 3，Providing Up Navigation

##### a，Specify the Parent Activity

使用[android:parentActivityName](https://developer.android.com/guide/topics/manifest/activity-element.html#parent)     
the manifest file中   

- Android 4.1 (API level 16) 在```<activity android:parentActivityName="com.example.myfirstapp.MainActivity">```
- Android 4.0 and lower 使用 ```<meta-data>```

~~~ java
<application ... >
    ...
    <!-- The main/home activity (it has no parent activity) -->
    <activity
        android:name="com.example.myfirstapp.MainActivity" ...>
        ...
    </activity>
    <!-- A child of the main activity -->
    <activity
        android:name="com.example.myfirstapp.DisplayMessageActivity"
        android:label="@string/title_activity_display_message"
        android:parentActivityName="com.example.myfirstapp.MainActivity" >
        <!-- Parent activity meta-data to support 4.0 and lower -->
        <meta-data
            android:name="android.support.PARENT_ACTIVITY"
            android:value="com.example.myfirstapp.MainActivity" />
    </activity>
</application>
~~~

##### b，Add Up Action

[setDisplayHomeAsUpEnabled()](https://developer.android.com/reference/android/app/ActionBar.html#setDisplayHomeAsUpEnabled(boolean))

##### c，Navigate Up to Parent Activity

[NavUtils](https://developer.android.com/reference/android/support/v4/app/NavUtils.html) class's static method, navigateUpFromSameTask()

##### d，Navigate up with a new back stack

[TaskStackBuilder](https://developer.android.com/reference/android/support/v4/app/TaskStackBuilder.html)

### 4，Providing Proper Back Navigation

##### a，Synthesize a new Back Stack for Deep Links

- Specify parent activities in the manifest
- Create back stack when starting the activity.[TaskStackBuilder](https://developer.android.com/reference/android/support/v4/app/TaskStackBuilder.html)，[PendingIntent](https://developer.android.com/reference/android/app/PendingIntent.html)

##### b，Implement Back Navigation for Fragments

[FragmentTransaction](https://developer.android.com/reference/android/app/FragmentTransaction.html)

~~~ java
// Works with either the framework FragmentManager or the
// support package FragmentManager (getSupportFragmentManager).
getSupportFragmentManager().beginTransaction()
                           .add(detailFragment, "detail")
                           // Add this transaction to the back stack
                           .addToBackStack()
                           .commit();
~~~


##### c，Implement Back Navigation for WebViews

### 5，Implementing Descendant Navigation

##### a，Implement Master/Detail Flows Across Handsets and Tablets

##### b，Navigate into External Activities

[FLAG_ACTIVITY_CLEAR_WHEN_TASK_RESET](https://developer.android.com/reference/android/content/Intent.html#FLAG_ACTIVITY_CLEAR_WHEN_TASK_RESET)

## 三，Notifying the User
