//
//  AppLogManager.m
//  xahelper
//
//  Created by 小A on 2020/7/2.
//  Copyright © 2020 xiaoa. All rights reserved.
//

#import "AppLogManager.h"
@implementation AppLogManager
+(void)consoleLogToXcode{
    if (@available(iOS 10.0, *)) {
        [DDLog addLogger:[DDOSLogger sharedInstance]];
    } else {
       [DDLog addLogger:[DDTTYLogger sharedInstance]];
    }
}
+(void)closeLogToXcode{
    if (@available(iOS 10.0, *)) {
        [DDLog removeLogger:[DDOSLogger sharedInstance]];
    } else {
        [DDLog removeLogger:[DDTTYLogger sharedInstance]];
    }
}
+(void)consoleLogToMac{
    [DDLog addLogger:[DDASLLogger sharedInstance] withLevel:ddLogLevel];
    DDLogVerbose(@"日志输出到Mac控制台已开启");
}

#pragma mark 关闭日志输出到Mac的控制台
+(void)closeLogToMac{
    [DDLog removeLogger:[DDASLLogger sharedInstance]];
}
#pragma mark 关闭所有日志
+ (void)closAllLog{
    [DDLog removeAllLoggers];
}
#pragma mark 日志输出到文件
+(void)consoleLogToFile{
    DDFileLogger *fileLog = [AppLogManager creatFileLogger];
    [DDLog addLogger:fileLog withLevel:fileLogLevel];
    DDLogVerbose(@"日志记录到文件已开启");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        DDLogVerbose(@"日志文件路径:%@",[AppLogManager logFilePath]);
    });
}

#pragma mark 关闭日志输出到文件
+ (void)closeLogToFile{
   [DDLog removeLogger:[AppLogManager currentFileLogger]];
}

#pragma mark 日志文件路径
+(NSArray *)logFilePath{
    NSArray *logFilePathsArray = [AppLogManager currentFileLogger].logFileManager.sortedLogFilePaths;
    return logFilePathsArray;
}

#pragma mark 获取当前的fileLogger
+(DDFileLogger *)currentFileLogger{
    NSArray *loggerArray = [[DDLog sharedInstance]allLoggers];
    DDFileLogger *fileLogger = nil;
    for (id logger in loggerArray) {
        if ([logger isKindOfClass:[DDFileLogger class]] ) {
            fileLogger = logger;
        }
    }
    return fileLogger;
}


#pragma mark 创建一个fileLogger
+(DDFileLogger *)creatFileLogger{
    /*
     DDFileLogger
     maximumFileSize 属性  日志超过该值（bytes），再次添加日志，日志将会滚动
     rollingFrequency 属性 指定一个时间间隔来进行滚动
     如果以上属性都设置了，任何一个先触发都会滚动日志。
     exp：
     rollingFrequency = 24 hour
     如果到了20 hour时日志的大小就超过了maximumFileSize的值，在增加日志时就会滚动。
     创建一个新的日志文件 24hour重置
     maximumFileSize = 0   禁用通过文件大小决定日志滚动 只能通过rollingFrequency控制
     rollingFrequency = 0  禁用指定时间间隔决定日志滚动 只能通过maximumFileSize控制
     不建议2个属性都禁用
     doNotReuseLogFiles 在程序启动时创建一个新的日志文件
     
     DDLogFileManager
     maximumNumberOfLogFiles 本地可以保存多少个日志文件
     logFilesDiskQuota 日志文件最大的占用空间 滚动日志文件时，文件大小超过该值的旧日志文件会被删除 设置0时禁用该选项
     */
    DDFileLogger *fileLogger = [[DDFileLogger alloc]init];
    fileLogger.maximumFileSize = fileLogMaximumFileSize;
    fileLogger.logFileManager.maximumNumberOfLogFiles = fileLogMaximumNumber;
    fileLogger.logFileManager.logFilesDiskQuota = 0;
    return fileLogger;
}

@end
