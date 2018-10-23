---
date: 2018-10-23
title: "iOS面试之道_架构篇_Note"
tags:
- interview
- iOS
categories:
- interview
comment: false
---
每个类、结构体、方法、变量的存在都应该遵循单一职责原则。

# MVC架构的优缺点
优点有2：
- 代码总量少
- 简单易懂

缺点：（造成的原因主要因为**视图层和控制器层高度耦合**）
- 代码过于集中（ViewController功能太过沉重）
   - 交互
   - 视图更新
   - 布局
   - Model数据获取及修改
   - 导航路由
- 难以进行测试
- 难以扩展（*ViewController太过笨重*）
- Model层过于简单
- 网络层无从安放

**总结**: 过于笼统的代码分配，导致除了数据或者视图外的类、结构、方法等都将被放到ViewController中，造成ViewController过于臃肿，与view和无法解耦合

# MVCS
对MVC的一种优化，S即Store，就是数据处理的，可以是数据持久化相关的代码、数据筛选分类之类的等等，无处安放的网络请求代码也可以放到这里

# VIPER架构简介
VIPER架构由5部分组成：
- View
- Interactor
- Presenter
- Entity
- Router

示意图：
![](baseURL/image/VIPER.jpeg)

#### 各模块说明
##### 视图层（View）
与MVP、MVVM一样，它包含与UI相关的一切操作，接受用户交互信息但不处理，而是传递给展示层

##### 展示层（Presenter）
与MVP的Presenter或者MVVM的ViewModel功能类似。

- 响应view传来的交互操作请求
- 不对数据源修改，有修改需求的话就向Interactor发送请求
- 链接路由层

##### 路由层（Router）
负责界面跳转、组件切换
##### 数据管理层（Interactor）
负责处理数据源信息
- 网络请求
- 数据传输
- 缓存、存储
- 生成实例等
- 一些从中间层和模型层的一些逻辑差不多被剥离至此
##### 模型层（Entity）
很简单，只有下面两个东西
- 初始化方法
- 属性相关的get/set方法
