//
//  DriveModel.m
//  xahelper
//
//  Created by 小A on 2020/8/16.
//  Copyright © 2020 小A. All rights reserved.
//

#import "DriveViewModel.h"
@interface DriveViewModel()
@property (assign, nonatomic) NSUInteger driveTime;//行驶计时
@property (assign, nonatomic) NSUInteger driveCumulativeTime;//行驶累计
@property (assign, nonatomic) NSUInteger restTime;//休息计时
@property (assign, nonatomic) NSUInteger restCumulativeTime;//休息累计
@property(strong, nonatomic)NSTimer *timer;
@end
@implementation DriveViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initTimer];
    }
    return self;
}
-(void)initTimer{
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timing) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer fireDate];
}
#pragma mark 计时
-(void)timing{
    NSDictionary *timeInfo = [self nowTime];
    NSInteger year = [timeInfo[@"year"] integerValue];
    NSInteger month =  [timeInfo[@"month"] integerValue];
    NSInteger day =  [timeInfo[@"day"] integerValue];
    NSInteger hour = [timeInfo[@"hours"] integerValue];
    NSInteger minute = [timeInfo[@"minutes"] integerValue];
    NSInteger second = [timeInfo[@"seconds"] integerValue];
    if (self.delegate && [self.delegate respondsToSelector:@selector(currentTime:month:day:hour:minute:second:)]) {
        [self.delegate currentTime:year month:month day:day hour:hour minute:minute second:second];
    }
    if (self.status == DriveStatusDriving) {
        [self drive];
    }else if (self.status == DriveStatusResting) {
        [self rest];
    }
}
#pragma mark 更改状态
- (void)changeStatus{
    QMUIAlertAction *action = nil;
    NSString *message = @"";
    if (self.status == DriveStatusStoping || self.status == DriveStatusResting) {
        message = @"您确定要切换到行驶模式吗?";
        action = [QMUIAlertAction actionWithTitle:@"确定" style:QMUIAlertActionStyleDestructive handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
            [self driveSatatus];
         }];
    }else{
        message = @"您确定要切换到休息模式吗?";
        action = [QMUIAlertAction actionWithTitle:@"确定" style:QMUIAlertActionStyleDestructive handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
            [self restStatus];
         }];
    }
    [self showAlert:message alertAction:action];
}
#pragma mark 行驶状态
-(void)driveSatatus{
    self.status = DriveStatusDriving;
    self.restTime = 0;
}
#pragma mark 休息状态
-(void)restStatus{
    self.status = DriveStatusResting;
    self.driveTime = 0;
}
#pragma mark 行驶
-(void)drive{
    self.driveCumulativeTime++;
    self.driveTime++;
    NSDictionary *timeInfo = [self timeFormatted:self.driveTime];
    NSInteger hour = [timeInfo[@"hours"] integerValue];
    NSInteger minute = [timeInfo[@"minutes"] integerValue];
    NSInteger second = [timeInfo[@"seconds"] integerValue];
    if (self.delegate && [self.delegate respondsToSelector:@selector(driveTimeHour:minute:second:)]) {
        [self.delegate driveTimeHour:hour minute:minute second:second];
    }
    
    timeInfo = [self timeFormatted:self.driveCumulativeTime];
    hour = [timeInfo[@"hours"] integerValue];
    minute = [timeInfo[@"minutes"] integerValue];
    second = [timeInfo[@"seconds"] integerValue];
    if (self.delegate && [self.delegate respondsToSelector:@selector(cumulativeTimeHour:minute:second:)]) {
        [self.delegate cumulativeTimeHour:hour minute:minute second:second];
    }
}

#pragma mark 休息
-(void)rest{
    self.restCumulativeTime++;
    self.restTime++;
    NSDictionary *timeInfo = [self timeFormatted:self.restTime];
    NSInteger hour = [timeInfo[@"hours"] integerValue];
    NSInteger minute = [timeInfo[@"minutes"] integerValue];
    NSInteger second = [timeInfo[@"seconds"] integerValue];
    if (self.delegate && [self.delegate respondsToSelector:@selector(driveTimeHour:minute:second:)]) {
        [self.delegate driveTimeHour:hour minute:minute second:second];
    }
    
    timeInfo = [self timeFormatted:self.restCumulativeTime];
    hour = [timeInfo[@"hours"] integerValue];
    minute = [timeInfo[@"minutes"] integerValue];
    second = [timeInfo[@"seconds"] integerValue];
    if (self.delegate && [self.delegate respondsToSelector:@selector(cumulativeTimeHour:minute:second:)]) {
        [self.delegate cumulativeTimeHour:hour minute:minute second:second];
    }
}

-(void)showAlert:(NSString *)message alertAction:(QMUIAlertAction *)action{
   QMUIAlertAction *cancleAction = [QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
    }];

   QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"友情提示" message:message preferredStyle:QMUIAlertControllerStyleAlert];
   [alertController addAction:cancleAction];
    if (action) {
        [alertController addAction:action];
    }
   [alertController showWithAnimated:YES];
}
#pragma mark 现在时间
- (NSDictionary *)nowTime{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
           NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    NSInteger year =[dateComponent year];
    NSInteger month =  [dateComponent month];
    NSInteger day =  [dateComponent day];
    NSInteger hours = [dateComponent hour];
    NSInteger minutes = [dateComponent minute];
    NSInteger seconds = [dateComponent second];
    NSDictionary *timeInfo = @{@"year":@(year),@"month":@(month),@"day":@(day),@"hours":@(hours),@"minutes":@(minutes),@"seconds":@(seconds)};
    return timeInfo;
}

#pragma mark 秒 -> xx时xx分xx秒
- (NSDictionary *)timeFormatted:(NSUInteger)totalSeconds{
    NSUInteger seconds = totalSeconds % 60;
    NSUInteger minutes = (totalSeconds / 60) % 60;
    NSUInteger hours = totalSeconds / 3600;
    NSDictionary *timeInfo = @{@"hours":@(hours),@"minutes":@(minutes),@"seconds":@(seconds)};
    return timeInfo;
}

-(void)setStatus:(DriveStatus)status{
    _status = status;
    if (self.delegate && [self.delegate respondsToSelector:@selector(driveStatusChanged:)]) {
        [self.delegate driveStatusChanged:_status];
    }
}

@end
