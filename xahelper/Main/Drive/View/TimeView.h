//
//  TimeView.h
//  xahelper
//
//  Created by 小A on 2020/8/7.
//  Copyright © 2020 小A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeView : UIView

/// 更新时间
/// @param hour 小时
/// @param minute 分钟
/// @param second 秒
-(void)updateTime:(NSUInteger)hour
           minute:(NSUInteger)minute
           second:(NSUInteger)second;
@end
