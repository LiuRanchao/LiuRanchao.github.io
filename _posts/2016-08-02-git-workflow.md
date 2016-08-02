---
layout: post
title: git版本控制与工作流
tags:
- git
categories: Tools
description: git版本控制与工作流
---

![](http://ww2.sinaimg.cn/mw690/5ecfffbajw1f6f8tjlsk1g20ng0b40tz.gif)

这篇文章是针对git版本控制和工作流的**总结**，如果有些朋友之前还没使用过git，对git的基本概念和命令不是很熟悉，可以从以下基本教程入手：
 
- [专为设计师而写的GitHub快速入门教程](http://www.ui.cn/detail/20957.html)  
- [git - 简明指南](http://rogerdudler.github.io/git-guide/index.zh.html)   
- [学习Git的在线互动教程](http://pcottle.github.io/learnGitBranching/) 

# 基本概念

## Git是什么？

[Git](https://git-scm.com/)是**分布式**版本控制系统，与SVN类似的**集中化**版本控制系统相比，集中化版本控制系统虽然能够令多个团队成员一起协作开发，但有时如果中央服务器宕机的话，谁也无法在宕机期间提交更新和协同开发。甚至有时，中央服务器磁盘故障，恰巧又没有做备份或备份没及时，那就可能有丢失数据的风险。   

但Git是分布式的版本控制系统，客户端不只是提取最新版本的快照，而且将整个代码仓库镜像复制下来。如果任何协同工作用的服务器发生故障了，也可以用任何一个代码仓库来恢复。而且在协作服务器宕机期间，你也可以提交代码到本地仓库，当协作服务器正常工作后，你再将本地仓库同步到远程仓库。

## 为什么要使用Git

- 能够对文件**版本控制**和**多人协作开发**    
- 拥有强大的**分支特性**，所以能够灵活地以**不同的工作流**协同开发    
- **分布式版本控制系统**，即使协作服务器宕机，也能继续提交代码或文件到本地仓库，当协作服务器恢复正常工作时，再将本地仓库同步到远程仓库。
- 当团队中某个成员完成某个功能时，通过**pull request**操作来通知其他团队成员，其他团队成员能够review code后再合并代码。

## Git有哪些特性

- 文件三种状态(modified, staged, committed)
- 直接记录快照，而非差异比较
- 多数操作仅添加操作
- 近乎所有操作都是本地执行
- 时刻保持数据完整性
有关以上特性的详细解释，请查看Pro git的[git基础章节](http://iissnan.com/progit/html/zh/ch1_3.html)

## Git基本工作流程

1. 在git版本控制的目录下修改某个文件
2. 使用~~~ java git add ~~~命令对修改后的文件快照，保存到暂存区域
3. 使用git commit命令提交更新，将保存在暂存区域的文件快照永久转储到 Git 目录中

## Git基本技巧

- 自动补全
- Git 命令别名
关于具体如何使用自动补全和命名别名技巧，请查看Pro git的[技巧和窍门](http://iissnan.com/progit/html/zh/ch2_7.html)

## Git版本控制

### 创建仓库 

- git init 
- git clone 
- git config

### 保存修改 
- git add 
- git commit

### 查看仓库 
- git status 
- git log –oneline

### 撤销修改,查看之前的commit 
- git checkout 
- 1git checkout 
- git checkout

### 撤销公共修改 
- git revert

### 撤销本地修改 
- git reset 
- git clean 

### 重写Git历史记录 
- git commit –amend 
- git rebase 
- git reflog



