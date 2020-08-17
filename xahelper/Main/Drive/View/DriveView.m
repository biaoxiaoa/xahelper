//
//  DriveView.m
//  xahelper
//
//  Created by 小A on 2020/8/16.
//  Copyright © 2020 小A. All rights reserved.
//
#define contentLayoutBackgroundColor [UIColor colorWithRed:28/255.0 green:28/255.0 blue:31/255.0 alpha:1]
#import "DriveView.h"
#import "TimeView.h"
@interface DriveView()

/// 根布局
@property(strong, nonatomic)MyLinearLayout *rootLayout;

/// 左侧内容
@property(strong, nonatomic)MyLinearLayout *leftLayout;

/// 中间内容
@property(strong, nonatomic)MyLinearLayout *middleLayout;

/// 右侧内容
@property(strong, nonatomic)MyLinearLayout *rightLayout;

/// 日期
@property(strong, nonatomic)UILabel *dateLabel;

/// 当前时间
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
    [self.rootLayout addSubview:self.leftLayout];
    [self.rootLayout addSubview:self.middleLayout];
    [self.rootLayout addSubview:self.rightLayout];
    [self.rootLayout equalizeSubviews:YES withSpace:10];
    
    [self.leftLayout addSubview:self.dateLabel];
    [self.leftLayout addSubview:self.currentTimeView];
}
-(void)currentTime:(NSUInteger)year
             month:(NSUInteger)month
               day:(NSUInteger)day
              hour:(NSUInteger)hour
            minute:(NSUInteger)minute
            second:(NSUInteger)second{
    self.dateLabel.text = [NSString stringWithFormat:@"%ld-%02ld-%02ld",year,month,day];
    [self.currentTimeView updateTime:hour minute:minute second:second];
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

-(UILabel *)dateLabel{
    if (_dateLabel == nil) {
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.font = [UIFont boldSystemFontOfSize:40];
        _dateLabel.textColor = [UIColor whiteColor];
        _dateLabel.text = @"2020-08-17";
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.topPos.equalTo(@5);
        _dateLabel.leftPos.equalTo(@0);
        _dateLabel.rightPos.equalTo(@0);
        _dateLabel.heightSize.equalTo(@(MyLayoutSize.wrap)).add(10);
    }
    return _dateLabel;
}


-(TimeView *)currentTimeView{
    if (_currentTimeView == nil) {
        _currentTimeView = [[TimeView alloc]init];
        _currentTimeView.backgroundColor = [UIColor clearColor];
        _currentTimeView.topPos.equalTo(self.dateLabel.bottomPos);
        _currentTimeView.leftPos.equalTo(@0);
        _currentTimeView.rightPos.equalTo(@0);
        _currentTimeView.heightSize.equalTo(@(MyLayoutSize.wrap)).add(10);
    }
    return _currentTimeView;
}
-(MyLinearLayout *)leftLayout{
    if (_leftLayout == nil) {
        _leftLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
        _leftLayout.backgroundColor = contentLayoutBackgroundColor;
        _leftLayout.heightSize.equalTo(self.rootLayout.heightSize);
    }
    return _leftLayout;
}
-(MyLinearLayout *)middleLayout{
    if (_middleLayout == nil) {
        _middleLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
        _middleLayout.backgroundColor = contentLayoutBackgroundColor;
        _middleLayout.heightSize.equalTo(self.rootLayout.heightSize);
    }
    return _middleLayout;
}
-(MyLinearLayout *)rightLayout{
    if (_rightLayout == nil) {
        _rightLayout = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
        _rightLayout.backgroundColor = contentLayoutBackgroundColor;
        _rightLayout.heightSize.equalTo(self.rootLayout.heightSize);
    }
    return _rightLayout;
}
@end
