//
//  DriveView.h
//  xahelper
//
//  Created by 小A on 2020/8/16.
//  Copyright © 2020 小A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DriveView : UIView

/// 当前时间
/// @param year 年
/// @param month 月
/// @param day 日
/// @param hour 时
/// @param minute 分
/// @param second 秒
-(void)currentTime:(NSUInteger)year
             month:(NSUInteger)month
               day:(NSUInteger)day
              hour:(NSUInteger)hour
            minute:(NSUInteger)minute
            second:(NSUInteger)second;
@end
