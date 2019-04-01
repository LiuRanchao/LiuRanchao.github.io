---
layout: post
title: Gson使用
tags:
- JSON
categories: Java
description: Gson使用
---

### 一，JSON -> Object

~~~ java
new Gson().fromJson(jsonStr, clazz);
~~~

#### clazz类配置：

1. 如果字段名相同，只需要写出来getXXX即可
2. 使用```@SerializedName```属性重命名。```@SerializedName(value = "emailAddress", alternate = {"email", "email_address"})```(当上面的三个属性(email_address、email、emailAddress)都中出现任意一个时均可以得到正确的结果。
注：当多种情况同时出时，以最后一个出现的值为准。)
3. 如果是```public```则不需要写getter
4. ```@Expose```可以区分实体中不想被序列化的属性. 使用 new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();创建Gson对象，没有@Expose注释的属性将不会被序列化.

#### 会遇到的问题：

1. 如果数据类型不同，则会抛出异常,导致整个对象为null
2. 如果在JsonString找不到对应的字段名，则返回默认值，不会抛出异常


### 二，JSON -> List

~~~ java
    /**
     * 将json string转换成 List<T>
     *
     * @param jsonStr json string
     */
    public static <T> List<T> readList(String jsonStr) {

        List<T> t = null;
        try {
            Type listType = new TypeToken<List<T>>(){}.getType();
            t  = new Gson().fromJson(jsonStr, listType);
        } catch (Throwable e) {
            e.printStackTrace();
        }
        return t;
    }
~~~

### 三，Object -> JSON

~~~ java
    /**
     * 将对象转换成json string
     *
     * @param obj 要转换成json string 的 对象，
     */
    public static String write(Object obj) {
        String jsonStr = "";
        try {
            jsonStr = gson.toJson(obj);
        } catch (Throwable e) {
            e.printStackTrace();
        }
        return jsonStr;
    }
~~~

### 参考

- [https://github.com/google/gson]()
- [http://www.jianshu.com/p/e740196225a4]()