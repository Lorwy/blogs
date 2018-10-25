# 47.熟悉系统框架
##· Foundation
NSObject 、 NSArray 、 NSDictionary 等都属于其中，是最主要的框架
NSLinguisticTagger 可以解析字符串并找到其中的全部名词、动词、代词等

##· CoreFoundation
CoreFoundation 不是 Objective-C 的框架

##· CFNetwork
C 语言级别的网络通信能力，是将“BSD套接字”（BSD socket）抽象成易于使用的网络接口，Foundation 框架再封装的 CFNetwork 为 Objective-C 语言的接口
##· CoreAudio
提供 C 语言 API 可用来操作设备上的音频硬件。 这套 API 可以抽象出另外一套 Objective-C 式 API，用来处理音频问题更简单

##· AVFoundation
提供 Objective-C 对象可以用来回放并录制音频及视频
##· CoreData
数据持久化的一个框架，提供 Objective-C 接口可以将对象放入数据库

##· CoreText
提供 C 语言接口，可以高效执行文字排版及渲染操作

##· QuartzCore

##· CoreGraphics

# 48.多用块枚举，少用 for 循环

