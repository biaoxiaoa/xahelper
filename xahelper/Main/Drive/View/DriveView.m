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
@property (strong, nonatomic) MyLinearLayout *rootLayout;

/// 左侧内容
@property (strong, nonatomic) MyLinearLayout *leftLayout;

/// 中间内容
@property (strong, nonatomic) MyLinearLayout *middleLayout;

/// 右侧内容
@property (strong, nonatomic) MyLinearLayout *rightLayout;

/// 日期
@property (strong, nonatomic) UILabel *dateLabel;

/// 当前时间
@property (strong, nonatomic) TimeView *currentTimeView;

/// 连续行驶
@property (strong, nonatomic) UILabel * driveTimeLabel;
@property (strong, nonatomic) TimeView *driveTimeView;

/// 累计
@property (strong, nonatomic) UILabel * cumulativeLabel;
@property (strong, nonatomic) TimeView * cumulativeView;

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
    
    [self initLeftLayout];
}
#pragma mark 初始化左侧
-(void)initLeftLayout{
    [self.leftLayout addSubview:self.dateLabel];
    [self.leftLayout addSubview:self.currentTimeView];
    [self.leftLayout addSubview:self.driveTimeLabel];
    [self.leftLayout addSubview:self.driveTimeView];
    [self.leftLayout addSubview:self.cumulativeLabel];
    [self.leftLayout addSubview:self.cumulativeView];
    [self.leftLayout equalizeSubviewsSpace:YES];
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

-(void)driveTimeHour:(NSUInteger)hour
              minute:(NSUInteger)minute
              second:(NSUInteger)second{
    [self.driveTimeView updateTime:hour
                            minute:minute
                            second:second];
}

-(void)cumulativeTimeHour:(NSUInteger)hour
                   minute:(NSUInteger)minute
                   second:(NSUInteger)second{
    [self.cumulativeView updateTime:hour
                             minute:minute
                             second:second];
}
-(void)driveStatus{
    self.driveTimeLabel.text = @"连续行驶";
    self.cumulativeLabel.text = @"累计行驶";
}
-(void)restStatus{
    self.driveTimeLabel.text = @"连续休息";
    self.cumulativeLabel.text = @"累计休息";
}
#pragma mark label点击
-(void)driveTimeLabelTipAction{
    
    if (self.tipBlock) {
        self.tipBlock();
    }
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

-(UILabel *)commonLabel{
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont boldSystemFontOfSize:40];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.leftPos.equalTo(@0);
    label.rightPos.equalTo(@0);
    label.heightSize.equalTo(@(MyLayoutSize.wrap)).add(10);
    return label;
}

-(UILabel *)dateLabel{
    if (_dateLabel == nil) {
        _dateLabel = [self commonLabel];
    }
    return _dateLabel;
}

-(UILabel *)driveTimeLabel{
    if (_driveTimeLabel == nil) {
        _driveTimeLabel = [self commonLabel];
        _driveTimeLabel.text = @"连续行驶";
        _driveTimeLabel.font = [UIFont boldSystemFontOfSize:30];
        _driveTimeLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tip = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(driveTimeLabelTipAction)];
        [_driveTimeLabel addGestureRecognizer:tip];
    }
    return _driveTimeLabel;
}

-(UILabel *)cumulativeLabel{
    if (_cumulativeLabel == nil) {
        _cumulativeLabel = [self commonLabel];
        _cumulativeLabel.text = @"累计行驶";
        _cumulativeLabel.font = [UIFont boldSystemFontOfSize:30];
    }
    return _cumulativeLabel;
}


-(TimeView *)currentTimeView{
    if (_currentTimeView == nil) {
        _currentTimeView = [[TimeView alloc]init];
        _currentTimeView.backgroundColor = [UIColor clearColor];
        _currentTimeView.leftPos.equalTo(@0);
        _currentTimeView.rightPos.equalTo(@0);
        _currentTimeView.heightSize.equalTo(@(MyLayoutSize.wrap));
    }
    return _currentTimeView;
}

-(TimeView *)driveTimeView{
    if (_driveTimeView == nil) {
        _driveTimeView = [[TimeView alloc]init];
        _driveTimeView.backgroundColor = [UIColor clearColor];
        _driveTimeView.leftPos.equalTo(@0);
        _driveTimeView.rightPos.equalTo(@0);
        _driveTimeView.heightSize.equalTo(@(MyLayoutSize.wrap));
    }
    return _driveTimeView;
}

-(TimeView *)cumulativeView{
    if (_cumulativeView == nil) {
        _cumulativeView = [[TimeView alloc]init];
        _cumulativeView.backgroundColor = [UIColor clearColor];
        _cumulativeView.leftPos.equalTo(@0);
        _cumulativeView.rightPos.equalTo(@0);
        _cumulativeView.heightSize.equalTo(@(MyLayoutSize.wrap));
    }
    return _cumulativeView;
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
