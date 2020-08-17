//
//  TimeView.m
//  xahelper
//
//  Created by 小A on 2020/8/7.
//  Copyright © 2020 小A. All rights reserved.
//
#define timeLabelFonSize 40
#import "TimeView.h"
@interface TimeView()
@property (strong, nonatomic) MyLinearLayout * rootLayout;
@property (strong, nonatomic) UILabel * hourLabel;
@property (strong, nonatomic) UILabel * minuteLabel;
@property (strong, nonatomic) UILabel * secondLabel;

@end
@implementation TimeView
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
    [self.rootLayout addSubview:self.hourLabel];
    [self.rootLayout addSubview:self.minuteLabel];
    [self.rootLayout addSubview:self.secondLabel];
}

-(void)updateTime:(NSInteger)hour
           minute:(NSInteger)minute
           second:(NSInteger)second{
    self.hourLabel.text = [NSString stringWithFormat:@"%02lu",hour];
    self.minuteLabel.text = [NSString stringWithFormat:@"%02lu",minute];
    self.secondLabel.text = [NSString stringWithFormat:@"%02lu",second];
}

-(MyLinearLayout *)rootLayout{
    if (_rootLayout == nil) {
        _rootLayout = [[MyLinearLayout alloc]initWithOrientation:MyOrientation_Horz];
        _rootLayout.backgroundColor = [UIColor clearColor];
        _rootLayout.topPos.equalTo(@0);
        _rootLayout.leftPos.equalTo(@0);
        _rootLayout.rightPos.equalTo(@0);
        _rootLayout.heightSize.equalTo(@(MyLayoutSize.wrap));
    }
    return _rootLayout;
}
-(UILabel *)commonLabel{
    UILabel *label = [[UILabel alloc]init];
    if (@available(iOS 9.0, *)) {
        label.font = [UIFont monospacedDigitSystemFontOfSize:timeLabelFonSize weight:UIFontWeightBold];
    } else {
        label.font = [UIFont fontWithName:@"Helvetica" size:timeLabelFonSize];
    }
    label.backgroundColor = [UIColor colorWithRed:1/255.0 green:0 blue:0 alpha:1];
    label.clipsToBounds = YES;
    label.layer.cornerRadius = 5.0f;
    label.layer.borderWidth = 1.0f;
    label.layer.borderColor = label.backgroundColor.CGColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    return label;
}
-(UILabel *)hourLabel{
    if (_hourLabel == nil) {
        _hourLabel = [self commonLabel];
        _hourLabel.topPos.equalTo(@0);
        _hourLabel.leftPos.equalTo(@5);
        _hourLabel.bottomPos.equalTo(@0);
        _hourLabel.widthSize.equalTo(self.rootLayout.widthSize).multiply(0.3);
        _hourLabel.heightSize.equalTo(_hourLabel.widthSize);
    }
    return _hourLabel;
}
-(UILabel *)minuteLabel{
    if (_minuteLabel == nil) {
        _minuteLabel = [self commonLabel];
        _minuteLabel.topPos.equalTo(@0);
        _minuteLabel.leftPos.equalTo(_hourLabel.rightPos).offset(5);
        _minuteLabel.widthSize.equalTo(_hourLabel.widthSize);
        _minuteLabel.heightSize.equalTo(_minuteLabel.widthSize);
    }
    return _minuteLabel;
}
-(UILabel *)secondLabel{
    if (_secondLabel == nil) {
        _secondLabel = [self commonLabel];
        _secondLabel.topPos.equalTo(@0);
        _secondLabel.leftPos.equalTo(_minuteLabel.rightPos).offset(5);
        _secondLabel.widthSize.equalTo(_hourLabel.widthSize);
        _secondLabel.heightSize.equalTo(_secondLabel.widthSize);
    }
    return _secondLabel;
}
@end
