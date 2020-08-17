//
//  TimeView.h
//  xahelper
//
//  Created by 小A on 2020/8/7.
//  Copyright © 2020 小A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeView : UIView
-(void)updateTime:(NSInteger)hour
           minute:(NSInteger)minute
           second:(NSInteger)second;
@end
