//
//  HelperController.h
//  xahelper
//
//  Created by 小A on 2020/8/16.
//  Copyright © 2020 小A. All rights reserved.
//

#import "QMUICommonViewController.h"

@interface HelperController : QMUICommonViewController
//根布局对象
@property (strong, nonatomic) MyRelativeLayout * rootLayout;

/// 屏幕左旋转
-(void)portraitLeft;

/// 屏幕竖直
-(void)portrait;
@end
