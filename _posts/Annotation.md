---
layout: post
title: Java 注解 Annotation
tags:
- Annotation
categories: Java
description: Java 注解 Annotation
---

# 概念

注解是 Java5的一个新特性。注解是插入代码中的一种注释或者是一种元数据(meta data)。
官方的解释:

> Annotations, a form of metadata, provide data about a program that is not part of the program itself. Annotations have no direct effect on the operation of the code they annotate.

### 作用

- 编写文档:通过代码里的元数据生成文档
- 代码分析:通过代码里标识的元数据对代码进行分析
- 编译检查:通过代码里标识的元数据让编译器实现基本的编译检查

## 元注解

元注解的作用就是注解其他注解。Java中定义了4个标准的meta-annotation类型，用以对其他的annotation类型做说明，分别是：

1. @Target
2. @Retention
3. @Documented
4. @Inherited

### @Target

说明了Annotation所修饰的对象的作用：用户描述注解的使用范围   
取值(ElementType):

- CONSTRUCTOR: 描述构造器
- FIELD：描述域
- LOCAL_VARIABLE:描述局部变量
- METHOD:描述方法
- PACKAGE:描述包
- PARAMETER:描述参数
- TYPE:描述类、接口(包括注解类型) 或enum声明

如果没有声明，可以修饰所有

### @Retention

表示需要在什么级别保存该注释信息，用于描述注解的生命周期
取值(RetentionPolicy):

- SOURCE(源码时)
- CLASS(编译时)
- RUNTIME(运行时)

默认为CLASS

### @Documented

标记注解，没有成员   
用于描述其它类型的annotation应该被作为标注的程序成员的公共api，可以文档化

### @Inherited

标记注解    
用该注解修饰的注解，会被子类继承

# Annotation自定义

自定义注解使用@interface声明一个注解，每一个方法就是声明一个配置参数，方法的名称就是参数的名称   
返回的类型就是参数的类型(返回值类型只能是基本类型、Class、String、enum)。可以通过default来声明参数的默认值。    
下面举个例子:

~~~ java
@Documented
@Retention(CLASS)
@Target(FIELD)
@Inherited
public @interface MyAnnotation {
    String name();
    int id() default 1;
    int[] value();
}
~~~

定义了MyAnnotation注解是编译时注解，用于修饰属性，可以被继承和文档化，有3个配置参数。

# Annotation解析

主要是根据@Retention分类，下面主要介绍CLASS和RUNTIME

## 运行时Annotation解析

运行时Annotation是指@Retention为RUNTIME的Annotation,解析Annotation的API：

~~~ java
T getAnnotation(Class annotationClass) //返回改程序上存在、指定类型的注解
Annotation[] getAnnotations()   //返回改程序元素上存在的所有注解
boolean is AnnotationPresent(Annotation)    //判断该程序元素上是否包含指定类型的注解
Annotation[] getDeclaredAnnotations()       //返回直接存在在改元素上的所有注解,不包含继承的注解
~~~

获取注解的信息：

~~~ java
private void processAnnotation(Class<?> clazz) {
    Field[] fields = clazz.getDeclaredFields();
    for (Field field : fields) {
        if (field.isAnnotationPresent(MyAnnotation.class)) {
            MyAnnotation myAnnotation = field.getAnnotation(MyAnnotation.class);
            Log.d("DEBUG", "### id:" + myAnnotation.id() + ", name:" + myAnnotation.name()
                    + ", value: " + myAnnotation.value());
        }
    }
}
~~~

### 编译时Annotation解析

编译时Annotation指@Retention为CLASS的Annotation，由编译器自动解析，基于APT注解处理工具。   
apt：Annotation Processing Tool，官方说明

> The command-line utility apt, annotation processing tool, finds and executes annotation processors based on the annotations present in the set of specified source files being examined. The annotation processors use a set of reflective APIs and supporting infrastructure to perform their processing of program annotations (JSR 175)

如何使用apt：

1. 自定义类集成自 AbstractProcessor
2. 重写其中的 process 函数

上文定义的MyAnnotation，使用apt，该如何进行解析：(在android studio中直接使用AbstractProcessor，会找不到这个类，具体的解决方法，请看知识点[Annotation Processing Tool](http://yeungeek.com/2016/04/27/Android%E5%85%AC%E5%85%B1%E6%8A%80%E6%9C%AF%E7%82%B9%E4%B9%8B%E4%BA%8C-Annotation-Processing-Tool/))

~~~ java
@SupportedAnnotationTypes({ "MyAnnotation" })
public class MyAnnotationProcessor extends AbstractProcessor {
    @Override
    public boolean process(Set<? extends TypeElement> annotations, RoundEnvironment env) {
        for (TypeElement te : annotations) {
            for (Element element : env.getElementsAnnotatedWith(te)) {
                MyAnnotation myAnnotation = element.getAnnotation(MyAnnotation.class);
                ... //具体的处理逻辑
            }
        }
        return false;
    }
}
~~~

SupportedAnnotationTypes 表示这个 Processor 要处理的 Annotation 名字。   
process 函数中参数 annotations 表示待处理的 Annotations，参数 env 表示当前或是之前的运行环境

#### 优点：

- 提高开发效率
- 减少代码量
- apt并不会影响性能

#### 缺点：

- 可读性较差
- 生成一些辅助类，内存消耗变大
- android的65535方法数问题

# 参考

- [官方网站](http://docs.oracle.com/javase/tutorial/java/annotations/index.html)
- [http://yeungeek.com/2016/04/25/Android%E5%85%AC%E5%85%B1%E6%8A%80%E6%9C%AF%E7%82%B9%E4%B9%8B%E4%B8%80-Java%E6%B3%A8%E8%A7%A3/]()



