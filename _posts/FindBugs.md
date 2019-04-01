---
layout: post
title: FindBug使用
tags:
- FindBugs
categories: Tools
description: FindBugs遇到的问题
---

### 一， 类型
- Bad practice 不好的习惯
- Dodgy code 狡猾的代码
- Internationalization 国际化
- Malicious code vulnerability 可能受到攻击
- Performance 性能
- Correctness 正确性
- Multithreaded correctness 多线程正确性
- Experimental 实验性

### 二，问题处理

##### 1. Possible doublecheck

``` java
 private static volatile CacheFileClearHelper sInstance ;

    private ExecutorService mExecutorService;

    /**
     * 最多线程数
     */
    private static final int MAX_THREAD_COUNT = 3;

    public static CacheFileClearHelper getInstance()
    {

        if (sInstance == null)
       {
           synchronized (CacheFileClearHelper. class)
           {
               if (sInstance == null)
              {
                  sInstance = new CacheFileClearHelper ();
              }
           }
       }
        return sInstance ;
    }
```
注意的挥发性的改性剂在这里。：）很重要，因为没有它，其他线程没有JMM保证（Java内存模型）来看看它的值的变化。同步不照顾，——它只序列化访问该代码块。

##### 2. Integral value cast to double and then passed to Math.ceil in 

##### 3. NP_UNWRITTEN_FIELD

##### 4. Enum field is public and mutable
枚举不应该用static <br>
内部变量不要public

##### 5. OBL: Method may fail to clean up stream or resource on checked exception (OBL_UNSATISFIED_OBLIGATION_EXCEPTION_EDGE)
在finall语句块状捕获close

##### 6. Static DateFormat
SimpleDateFormat 静态导致线程不安全

``` java
private static final String COMMON_DATE = "dd/MM/yyyy";

SimpleDateFormat format = new SimpleDateFormat(COMMON_DATE);

format.format(new Date());
```

##### 7. Incorrect lazy initialization and update of static field (LI_LAZY_INIT_UPDATE_STATIC)

该方法的初始化中包含了一个迟缓初始化的静态变量。你的方法引用了一个静态变量，估计是类静态变量，那么多线程调用这个方法时，你的变量就会面临线程安全的问题了，除非别的东西阻止任何其他线程访问存储对象从直到它完全被初始化。<br>
解决：使用同步锁

##### 8. Constructor invokes Thread.start()
##### 9. Inconsistent synchronization
##### 10. Serializable inner class
使用静态内部类

##### 11. Non-transient non-serializable instance field in serializable class
这个错误的意思是：在可序列化的类中存在不能序列化或者不能暂存的数据在可序列化的类中存在不能序列化或者不能暂存的数据

##### 12. Comparator doesn't implement Serializable
比较器也要实现Serializable接口

##### 13. Invocation of toString on an array
直接调用数组的toString()

##### 14. Return value of method without side effect is ignored
返回值没有被使用

##### 15. Unread public/protected field
字段没有被使用

##### 16. Dead store to local variable
局部变量不可用

##### 17. Boxing/unboxing to parse a primitive
使用parseXXX()

##### 18. Inefficient use of keySet iterator instead of entrySet iterator
遍历时，使用了map的get(),降低了性能，应该使用entrySet获取key value

##### 19. Method concatenates strings using + in a loop
string字符串拼接没有直接使用了+的方式，应该使用StringBuilder

##### 20. Inconsistent synchronization

##### 21. Method ignores exceptional return value
忽略了返回值

##### 22. Switch statement found where default case is missing

### 三，参考

- [http://wenku.baidu.com/view/65ee27d6360cba1aa811daa6.html]()






