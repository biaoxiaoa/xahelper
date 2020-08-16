//
//  AppDelegate.m
//  xahelper
//
//  Created by 小A on 2020/8/16.
//  Copyright © 2020 小A. All rights reserved.
//

#import "AppDelegate.h"
#import "AppManager.h"
@interface AppDelegate ()
@property(strong, nonatomic)AppManager *manager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"1111");
    self.manager = [AppManager shareManager];
    return YES;
}

@end
