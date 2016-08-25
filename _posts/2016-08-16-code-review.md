---
layout: post
title: CodeReview
tags:
- 代码规范
categories: 软件工程
description: CodeReview
---

# 一，分析点

1. 统一的命名
2. 代码风格
3. 代码相似分析
4. 代码难度分析
5. 检查TODO

### 一，Architecture/Design

#### 1， 单一职责原则
这是经常被违背的原则。一个类只能干一个事情, 一个方法最好也只干一件事情。 比较常见的违背是一个类既干UI的事情，又干逻辑的事情, 这个在低质量的客户端代码里很常见。

#### 2，行为是否统一
- 比如缓存是否统一，错误处理是否统一， 错误提示是否统一， 弹出框是否统一 等等。
- 同一逻辑/同一行为 有没有走同一Code Path？低质量程序的另一个特征是，同一行为/同一逻辑，因为出现在不同的地方或者被不同的方式触发，没有走同一Code Path 或者各处有一份copy的实现， 导致非常难以维护。

#### 3，代码污染
代码有没有对其他模块强耦合 ？

#### 4，重复代码
主要看有没有把公用组件，可复用的代码，函数抽取出来。

#### 5，Open/Closed 原则
- 就是好不好扩展。 Open for extension, closed for modification.   
- 面向接口编程 和 不是 面向实现编程   
- 主要就是看有没有进行合适的抽象， 把一些行为抽象为接口。

#### 6，健壮性
- 有没有考虑线程安全性， 数据访问的一致性
- 对Corner case有没有考虑完整，逻辑是否健壮？有没有潜在的bug？
- 有没有内存泄漏？有没有循环依赖?（针对特定语言，比如Objective-C) ？有没有野指针？
错误处理
- 有没有很好的Error Handling？比如网络出错，IO出错。
- 改动是不是对代码的提升
- 新的改动是打补丁，让代码质量继续恶化，还是对代码质量做了修复？

#### 7，效率/性能
- 关键算法的时间复杂度多少？有没有可能有潜在的性能瓶颈。
- 客户端程序 对频繁消息 和较大数据等耗时操作是否处理得当。

### 二，Style
#### 1，可读性
衡量可读性的可以有很好实践的标准，就是Reviewer能否非常容易的理解这个代码。 如果不是，那意味着代码的可读性要进行改进。
#### 2，命名
- 命名对可读性非常重要，我倾向于函数名/方法名长一点都没关系，必须是能自我阐述的。
- 英语用词尽量准确一点（哪怕有时候需要借助Google Translate，是值得的）

#### 3，函数长度/类长度
函数太长的不好阅读。 类太长了，比如超过了1000行，那你要看一下是否违反的“单一职责” 原则。

#### 4，参数个数
不要太多， 一般不要超过3个。

# 二，好处

- Code Review保证开发质量，整个过程有章可循，无需顾及“面子”，能够修正很多平时不注意或者明知故犯的小毛病
- Code Review高效沟通交流，不需电话和视频会议，让北京深圳两地的同事们一起协同工作
- Code Review帮助知识传递，团队内细粒度的知识分享， 大家一起逐行的点评代码比用技术交流会以及KM投稿更细致
- Code Review保证代码的可持续使用，代码风格不一致导致一个系统每次移交负责人都被重写一次
- Code Review和敏捷开发相容，而不是相斥，敏捷不是片面追求发布次数，而是保证质量的发布
- CodeReview 是一种社交的途径， 鼓励小组成员之间多做技术交流
- CodeReview 对新人的成长极其有利。 
- CodeReview 增加团队内代码的可维护性, 同一份代码至少会有两个人熟悉——代码的作者和审阅者

# 三，如何建设一个团队的 code review 文化， 跟随 Google 的脚步， 也有一些具体的意见

- 需要培养合格的reviewer。 建立各种编程语言的readability认证机制，从一组“种子”reviewer开始，让更多同事获得认证成为合格的reviewers
- 需要细化和公开各种语言的code style。 评注中可以给出建议的出处的URL，使得保持代码风格和可维护性落到实处
- 需要建立Code Lab机制。 帮助工程师们入门开发流程和规范
- 需要建立change approval机制。 鼓励组内更多工程师改进代码（敏捷），但是修改在提交前除了必须通过review，还需要相关责任人的approval；在加速开发滚动的同时，保证权责分明
- 引导轻量 review。我们都经历过有些工程师发一个 change issue 的时候， 几十个文件一并发出来， 一个 issue 可能是累积一周的修改， reviewer 看到这种 issue 几乎都是崩溃的，不可能保证 review 质量。 所以好的 issue 应该是轻量的， 大的 issue 应该拆分为小的 issue 发送。下图是 Cisco 公司的codereview 报告中摘出的， 如果一个 issue 的修改代码行数超过 400， 基本上 reviewer 是不可能认真 review 帮你找出 bug 的 。
- 明确issue 能否提交是工程师自己的责任。开发人员有时候抱怨别人 review 得慢， 拖延时间。 我们小组内部通常明确指出：一个 issue 能否提交是开发人员自己的责任。 开发人员自己要积极推动合作人员帮忙 review issue， 推动 issue 被通过并及时提交。

# 参考

- [android的命名标准](http://blog.csdn.net/vipzjyno1/article/details/23542617)  
- [http://jimhuang.cn/?p=59]()
- [让 Code Review成为一种习惯](http://mp.weixin.qq.com/s?__biz=MjM5NzA1MTcyMA==&mid=205557687&idx=3&sn=627a9e51fb0bd53d039a74593c645263&scene=2&from=timeline&isappinstalled=0#rd)

---
---

# 实践总结

1. ListView中的getView方法中创建对象 
2. 控件封装的不够灵活，掺杂具体业务