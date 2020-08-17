//
//  DriveView.m
//  xahelper
//
//  Created by 小A on 2020/8/16.
//  Copyright © 2020 小A. All rights reserved.
//

#import "DriveView.h"
#import "TimeView.h"
@interface DriveView()
@property(strong, nonatomic)MyLinearLayout *rootLayout;
@property(strong, nonatomic)TimeView *currentTimeView;
@end
@implementation DriveView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    [self addSubview:self.rootLayout];
    [self.rootLayout addSubview:self.currentTimeView];
    UIView *v1 = [[UIView alloc]init];
    v1.backgroundColor = [UIColor grayColor];
    UIView *v2 = [[UIView alloc]init];
    v2.backgroundColor = [UIColor grayColor];
    [self.rootLayout addSubview:v1];
    [self.rootLayout addSubview:v2];
    [self.rootLayout equalizeSubviews:YES withSpace:10];
}

-(MyLinearLayout *)rootLayout{
    if (_rootLayout == nil) {
        _rootLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
        _rootLayout.backgroundColor = [UIColor clearColor];
        _rootLayout.topPos.equalTo(@0);
        _rootLayout.leftPos.equalTo(@0);
        _rootLayout.bottomPos.equalTo(@0);
        _rootLayout.rightPos.equalTo(@0);
    }
    return _rootLayout;
}
-(TimeView *)currentTimeView{
    if (_currentTimeView == nil) {
        _currentTimeView = [[TimeView alloc]init];
        _currentTimeView.backgroundColor = [UIColor colorWithRed:28/255.0 green:28/255.0 blue:31/255.0 alpha:1];
        _currentTimeView.heightSize.equalTo(self.rootLayout.heightSize);
    }
    return _currentTimeView;
}
@end
