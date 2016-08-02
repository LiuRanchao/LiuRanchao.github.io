---
layout: post
title: android-数据库优化
tags:
- 优化
categories: Android
description: android-数据库优化
---

## 一，单线程池  

由于不支持SQLite不支持多线程并发，所以只能单线程处理

## 二，使用索引

适当的索引的好处是让读取变快，当然带来的影响就是数据插入修改的时间增加，因为还得维护索引的变化。不过对于大部分的读操作多于写操作的数据库来说索引还是十分有必要的。关于如何设计索引，可以参考下面这个文章：

[索引优化](http://www.cnblogs.com/anding/p/3254674.html)

1. 使用联合索引 
过多的索引同时也会减慢读取的速度，很典型的一个情况就是比如要同时根据省市区县查询，又可以根据年月日查询，如果每个都做索引那么读取速度将会显著降低。 
对于这种有层级关系的关键字，就可以考虑联合索引了，比如首先根据省查询，然后根据省市查询，层层递进到省市区县的查询方式，就可以使用联合索引，效果非常好。

2. 勿使用过多索引

## 三，事务

1. 提高速度
2. 保持一致性 
  - 方式1 :    
    SQLiteDatabase
  
	~~~ java
	public void inertOrUpdateDateBatch(List<String> sqls) {
	        SQLiteDatabase db = getWritableDatabase();
	        db.beginTransaction();
	        try {
	            for (String sql : sqls) {
	                db.execSQL(sql);
	            }
	            // 设置事务标志为成功，当结束事务时就会提交事务
	            db.setTransactionSuccessful();
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            // 结束事务
	            db.endTransaction();
	            db.close();
	        }
	    }
	~~~
	
   - 方式2：    
   SQLiteDatabase db.insert(“table_name”, null, contentValues) 中也可以批量插入
   
   ~~~ java
   public void insertData(插入数据) {
        db.beginTransaction();
        // 手动设置开始事务
        for (ContentValues v : list) {
            db.insert("表名", null, v);
        }
        db.setTransactionSuccessful();
        // 设置事务处理成功，不设置会自动回滚不提交 
        db.endTransaction();
        // 处理完成 
        db.close();
    }
   ~~~
   
   - 方式3   
	SQLiteStatement 个人比较喜欢用这种方式，对数据的处理看的很清楚明了
	
	~~~ java
	String sql = "insert into表名(对应的列) values(?)"; 
    SQLiteStatement stat = db.compileStatement(sql); 
    db.beginTransaction(); 
    for (数据集) { 
      //环所要插入的数据 
    } 
    db.setTransactionSuccessful(); 
    db.endTransaction(); 
    db.close();
	~~~
	
## 四，单条sql优于多条sql
   
实测发现，对于几十条sql插入当你替换成单条sql时性能有所提升，但是这里要注意的是，换成单条可读性较差，同时会出现sql超长的错误。

## 五，读和写操作是互斥的，写操作过程中可以休眠让读操作进行

由于第一步所说的多数据事务插入，从而会导致插入时间增长那么也会影响数据展示的速度，所以可以在插入过程中休眠操作，以便给读操作流出时间展示数据。

## 六， 增加查询条件

当你只要一条数据时增加limit 1,这样搜索到了后面的就不会再查询了，大大的加快了速度。查询时返回更少的结果集及更少的字段。

## 七， 提前将字段的index映射好

## 八、数据库设计上

1. 通过冗余换取查询速度

2. 减少数据来提升查询速度    
比如下拉操作时，先清除旧数据，再插入新数据保证数据库中的数据总量小，提升查询速度。

3. 避免大数据多表的联合查询    
和1的方式其实是一样的原理，只是这里需要特别拿出来说明以下，比如有文件表，还有多媒体文件表，你可以设计成一张文件表，一张多媒体关联表存放多媒体数据，文件信息还是在文件表中，然后通过外键关联。    
但是如果两个表数据很多，主键还不一致同时数据从服务器下来的数序也不一致那么，两个表的联合查询出来的数据要慢的多，这个时候就可以用冗余来唤起查询速度了。

## 九、异步线程

Sqlite是常用于嵌入式开发中的关系型数据库，完全开源。  
与Web常用的数据库Mysql、Oracle db、sql server不同，Sqlite是一个内嵌式的数据库，数据库服务器就在你的程序中，无需网络配置和管理，数据库服务器端和客户端运行在同一进程内，减少了网络访问的消耗，简化了数据库管理。不过Sqlite在并发、数据库大小、网络方面存在局限性，并且为表级锁，所以也没必要多线程操作。    

Android中数据不多时表查询可能耗时不多，不会导致anr，不过大于100ms时同样会让用户感觉到延时和卡顿，可以放在线程中运行，但sqlite在并发方面存在局限，多线程控制较麻烦，这时候可使用单线程池，在任务中执行db操作，通过handler返回结果和ui线程交互，既不会影响UI线程，同时也能防止并发带来的异常。 
可使用Android提供的AsyncQueryHandler(感谢@内网无法登陆账号 反馈)或类似如下代码完成：

~~~ java
ExecutorService singleThreadExecutor = Executors.newSingleThreadExecutor();
singleThreadExecutor.execute(new Runnable() {
        @Override
        public void run () {
            // db operetions, u can use handler to send message after
            db.insert(yourTableName, null, value);
            handler.sendEmptyMessage(xx);
        }
    });
~~~

## 十，ContentValues的容量调整

SQLiteDatabase提供了方便的ContentValues简化了我们处理列名与值的映射，ContentValues内部采用了HashMap来存储Key-Value数据，ContentValues的初始容量是8，如果当添加的数据超过8之前，则会进行双倍扩容操作，因此建议对ContentValues填入的内容进行估量，设置合理的初始化容量，减少不必要的内部扩容操作。

## 十一，及时关闭Cursor