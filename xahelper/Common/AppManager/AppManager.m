//
//  APPManager.m
//  xahelper
//
//  Created by 小A on 2020/7/27.
//  Copyright © 2020 小A. All rights reserved.
//

#import "AppManager.h"
#import "AppLogManager.h"
@implementation AppManager
+(instancetype)shareManager{
    static AppManager *_shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareManager = [[super allocWithZone:NULL] init];
        [AppManager initAppLogManageFunction];
    });
    return _shareManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [AppManager shareManager];
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return [AppManager shareManager];
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    return [AppManager shareManager];
}
#pragma mark 初始化日志管理功能
+(void)initAppLogManageFunction{
    if (ISDEBUG) {
        [AppLogManager consoleLogToXcode];
    }else{
        [AppLogManager consoleLogToMac];
    }
    [AppLogManager consoleLogToFile];
}
@end
