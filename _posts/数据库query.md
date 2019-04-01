---
layout: post
title: Android数据库query查询
tags:
- 数据库
categories: Android
description: Android数据库query查询
---

首先我们假设我们有如下表格，表格名称“Employees”：

| id | LastName | FirstName | Address         | City     |
|----|----------|-----------|-----------------|----------|
| 1  | Adams    | John      | Oxford Street   | London   |
| 2  | Bush     | George    | Fifth Avenue    | New York |
| 3  | Carter   | Thomas    | Changan Street  | Beijing  |


#### SQL基本格式

~~~ sql
SELECT  列名称  FROM  表名称 
~~~

~~~ java
public  Cursor   query  (String table, String[] columns, String selection, String[] selectionArgs,   
String groupBy, String having, String orderBy, String limit)  
~~~

#### 查询指定字段

~~~ sql
SELECT  FirstName, LastName  FROM  Employees
~~~

~~~ java
String[] columns = new String[] {"FirstName", "LastName"};
~~~

#### WHERE过滤

~~~ sql
SELECT  *  FROM  Employees  WHERE  City= 'Beijing'
~~~

~~~ java
String selection = ”City=?";  
String[] selectionArgs = { "Beijing" }; 
~~~

#### GROUP BY, HAVING, ORDER BY

我们下面举个例子，假设有如下数据表，表名"Orders"：

Id |CustomerName|OrderPrice |	Country |	OrderDate
---|------------|-----------|---------|-----------
1  |Arc	      |100        |China    |2010/1/2
2  |Bor	      |200        |USA      |2010/3/20
3  |Cut	      |500        |Japan    |2010/2/20
4  |Bor	      |300        |USA      |2010/3/2
5  |Arc	      |600        |China    |2010/3/25
6  |Doom	      |200        |China    |2010/3/26


假设我们想查询客户总的订单数在500元以上的，且County在中国的客户的名称和订单总数，且按照CustomerName来排序，默认ASC排序，那么SQL语句应当是：

~~~ sql
SELECT  CustomerName,  SUM (OrderPrice)  FROM  Orders  WHERE  Country=?   
GROUP   BY  CustomerName   
HAVING   SUM (OrderPrice)>500  
ORDER   BY  CustomerName
~~~

~~~ java
String table =  "Orders" ;  
String[] columns = new  String[] { "CustomerName" ,  "SUM(OrderPrice)" };  
String selection = "Country=?" ;  
String[] selectionArgs = new  String[]{ "China" };  
String groupBy = "CustomerName" ;  
String having = "SUM(OrderPrice)>500" ;  
String orderBy = "CustomerName" ;  
Cursor c = db.query(table, columns, selection, selectionArgs, groupBy, having, orderBy, null );   
~~~

查询的结果应该是：

CustomerName |SUM(OrderPrice)
-------------|---------------
Arc          | 700

#### 参考

- [转载](http://blog.csdn.net/scorplopan/article/details/6303559)
