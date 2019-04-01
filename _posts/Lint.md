---
layout: post
title: Lint介绍
tags:
- 优化
categories: Tools
description: Lint介绍
---

### AndroidLintSimpleDateFormat 

解决方案：   

~~~ java
SimpleDateFormat format = new SimpleDateFormat(“yyyy年MM月dd日”); 
~~~

改成： 

~~~ java
SimpleDateFormat format = new SimpleDateFormat(“yyyy年MM月dd日”, Locale.getDefault());
~~~

### AndroidLintHardcodedText 

> Hardcoded text 
Hardcoding text attributes directly in layout files is bad for several reasons: 

> When creating configuration variations (for example for landscape or portrait)you have to repeat the actual text (and keep it up to date when making changes)

> The application cannot be translated to other languages by just adding new translations for existing string resources.

> In Android Studio and Eclipse there are quickfixes to automatically extract this hardcoded string into a resource lookup. 

原因：I18N   
解决：使用strings.xml

### AndroidLintTypographyDashes 

> Hyphen can be replaced with dash

> The “n dash” (–, –) and the “m dash” (—, —) characters are used for ranges (n dash) and breaks (m dash). Using these instead of plain hyphens can make text easier to read and your application will look more polished. 

原因：符号在Strings.xml中使用    
解决：换成转换符

### AndroidLintIconDensities 

> Icon densities validation

> Icons will look best if a custom version is provided for each of the major screen density classes (low, medium, high, extra high). This lint check identifies icons which do not have complete coverage across the densities.

> Low density is not really used much anymore, so this check ignores the ldpi density. To force lint to include it, set the environment variable ANDROID_LINT_INCLUDE_LDPI=true. For more information on current density usage, see [http://developer.android.com/resources/dashboard/screens.html]()
> [http://developer.android.com/guide/practices/screens_support.html]()

原因：缺少多分辨率支持    
解决：在主要分辨率的资源文件夹添加文件

### AndroidLintContentDescription

> Non-textual widgets like ImageViews and ImageButtons should use the contentDescription attribute to specify a textual description of the widget such that screen readers and other accessibility tools can adequately describe the user interface.

> Note that elements in application screens that are purely decorative and do not provide any content or enable a user action should not have accessibility content descriptions. In this case, just suppress the lint warning with a tools:ignore=”ContentDescription” attribute.

> Note that for text fields, you should not set both the hint and the contentDescription attributes since the hint will never be shown. Just set the hint. See [http://developer.android.com/guide/topics/ui/accessibility/checklist.html#special-cases](). 

原因：ImageView没有设置contentDescription    
解决：setContentDescription

### AndroidLintInconsistentLayout 

> Inconsistent Layouts

> This check ensures that a layout resource which is defined in multiple resource folders, specifies the same set of widgets.

> There are cases where this is intentional. For example, you may have a dedicated large tablet layout which adds some extra widgets that are not present in the phone version of the layout. As long as the code accessing the layout resource is careful to handle this properly, it is valid. In that case, you can suppress this lint check for the given extra or missing views, or the whole layout 
 
原因：  
解决:

### AndroidLintInefficientWeight 

> Inefficient layout weight

> When only a single widget in a LinearLayout defines a weight, it is more efficient to assign a width/height of 0dp to it since it will absorb all the remaining space anyway. With a declared width/height of 0dp it does not have to measure its own size first. 

原因：weight使用后，layout_width or layout_height 的设置    
解决：设置为0dp

### AndroidLintInflateParams 

> Layout Inflation without a Parent

> When inflating a layout, avoid passing in null as the parent view, since otherwise any layout parameters on the root of the inflated layout will be ignored. [http://www.doubleencore.com/2013/05/layout-inflation-as-intended]()
 
原因：onDraw() 分配内存导致，例如创建bitmap    
解决：初始化时候创建bitmap

### AndroidLintRtlHardcoded

> Using left/right instead of start/end attributes

> Using Gravity#LEFT and Gravity#RIGHT can lead to problems when a layout is rendered in locales where text flows from right to left. Use Gravity#START and Gravity#END instead. Similarly, in XML gravity and layout_gravity attributes, use start rather than left.

> For XML attributes such as paddingLeft and layout_marginLeft, use paddingStart and layout_marginStart. NOTE: If your minSdkVersion is less than 17, you should add both the older left/right attributes as well as the new start/right attributes. On older platforms, where RTL is not supported and the start/right attributes are unknown and therefore ignored, you need the older left/right attributes. There is a separate lint check which catches that type of error.
 
原因：SDK version高的使用start/end    
解决：旧版start/end 和 left/right 都要写