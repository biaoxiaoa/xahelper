//
//  AppLogManager.h
//  xahelper
//
//  Created by 小A on 2020/7/2.
//  Copyright © 2020 xiaoa. All rights reserved.
//

/*
 信息输出可以使用以下几个函数。分别对应不通的日志级别。
 DDLogError 错误
 DDLogWarn  警告
 DDLogInfo  信息
 DDLogDebug 调试
 DDLogVerbose 普通
 exp:
 输出一些不需要记录的日志信息
 DDLogVerbose(@"测试");
 */

#import <Foundation/Foundation.h>
//日志文件大小。单位（bytes）
static CGFloat fileLogMaximumFileSize = 1024 * 1024;
//本地最多日志文件的数量
static NSUInteger fileLogMaximumNumber = 3;
@interface AppLogManager : NSObject
/// 日志输出到Xcode控制台
+(void)consoleLogToXcode;

/// 关闭日志输出到Xcode控制台
+ (void)closeLogToXcode;

/// 日志输出到MAC中的【控制台.app】
///注意：开启该项时，日志也会输出到Xcode的控制台。会出现一条日志输出2次的情况。开启该项时自动调用closeLogToXcode方法关闭在xcode控制台的输出
+(void)consoleLogToMac;

/// 关闭日志输出到Mac的【控制台.app】
+(void)closeLogToMac;

/// 日志输出到文件
+(void)consoleLogToFile;

/// 关闭日志输出到文件
+(void)closeLogToFile;

/// 关闭所有日志
+ (void)closAllLog;

/// 日志文件路径
/// 记入文件的日志级别包括error warning info debug。第一次运行APP时会出现获取不到日志文件路径的情况，是因为没有出现以上级别的日志，所以日志文件没创建
+(NSArray *)logFilePath;
@end
