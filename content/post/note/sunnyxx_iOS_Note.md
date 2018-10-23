---
date: 2018-10-22
title: "孙源iOS面试总结"
tags:
- 面试
- iOS
categories:

comment: false
---
# Review
##### 主要对这几块进行总结，要结合技术Tips总结出来
项目描述
项目规模
其中职责
技术栈
遇到的挑战及如何解决的

##### 专业技能：
例举技术名词时写出用起做了什么，如：
熟练应用objc runtime技术，曾使用它做了ViewController进入和退出时的**AOP埋点**

##### 更多信息来体现特别
Blog
GitHub
技术探索
对技术的个人理解
做过的有意思的事儿



# 理解应用架构
MVC和MVVM理解是否正确


# [SR]内容管理
- Stack 和 Heap 分别的使用，如何管理？
- ARC 是如何实现的？
- Autorelease 对象何时释放？
- AutoreleasePoll是如何实现的？

# [SR] 理解 Class 与对象模型


# [SR] 理解Runloop

# [SR] 深入理解消息机制
从写下[obj foo] 这行代码直到运行时 foo 被调用，中间都发生了什么？
**掌握**：objc_msgSend 的关键调用，后续如何通过 selector 从 isa 找到 IMP，若运行时没找到 foo 会如何？

**精通**：编译器如何编译成 objc_msgSend、消息 cache 机制、消息转发机制、objc_msgSend 的各个版本、objc_msgSend的实现、跳板机制等
