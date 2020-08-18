//
//  DriveModel.m
//  xahelper
//
//  Created by 小A on 2020/8/16.
//  Copyright © 2020 小A. All rights reserved.
//

//播报间隔
#define speakCurrentTimeInterreveal 25 * 60

#import "DriveViewModel.h"
#import "SpeakManager.h"
@interface DriveViewModel()
@property (strong, nonatomic) SpeakManager *speaker;
@property (assign, nonatomic) NSUInteger driveTime;//行驶计时
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) NSUInteger driveCumulativeTime;//行驶累计
@property (assign, nonatomic) NSUInteger restTime;//休息计时
@property (assign, nonatomic) NSUInteger restCumulativeTime;//休息累计
@property (assign, nonatomic) NSUInteger speakTime;
@property (assign, nonatomic) NSUInteger saveTime;//进入后台前记录时间
@end
@implementation DriveViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initTimer];
        [self initNotifaction];
    }
    return self;
}
#pragma mark 初始化计时器
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
#pragma mark 播报
-(void)speak{
    if (self.status!=DriveStatusDriving) {
        return;
    }
    if (self.speakTime == speakCurrentTimeInterreveal) {
        NSDictionary *timeInfo = [self nowTime];
        NSInteger year = [timeInfo[@"year"] integerValue];
        NSInteger month =  [timeInfo[@"month"] integerValue];
        NSInteger day =  [timeInfo[@"day"] integerValue];
        NSInteger hour = [timeInfo[@"hours"] integerValue];
        NSInteger minute = [timeInfo[@"minutes"] integerValue];
        NSString *message = [NSString stringWithFormat:@"现在是%ld年%ld月%ld日%ld时%ld分",year,month,day,hour,minute];
        timeInfo = [self timeFormatted:self.driveTime];
        hour = 1;
        minute = [timeInfo[@"minutes"] integerValue];
        if (hour > 0 && minute >0) {
            message = [NSString stringWithFormat:@"%@,您已连续行驶%ld小时%ld分",message,hour,minute];
        }else if (hour > 0){
            message = [NSString stringWithFormat:@"%@,您已连续行驶%ld小时",message,hour];
        }else if (minute > 0) {
            if ([message containsString:@"您已连续行驶"]) {
                message = [NSString stringWithFormat:@"%@,%ld分",message,minute];
            }else{
                message = [NSString stringWithFormat:@"%@,您已连续行驶%ld分钟",message,minute];
            }
        }
        [self speakMessage:message];
        self.speakTime = 0;
    }
    self.speakTime++;
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
    [self speakMessage:@"行车不规范"];
    self.status = DriveStatusDriving;
    self.restTime = 0;
}
#pragma mark 休息状态
-(void)restStatus{
    [self speakMessage:@"把能量回满后在重新出发吧..."];
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
    [self speak];
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
#pragma mark 前后台通知
-(void)initNotifaction{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}

#pragma mark 进入后台
-(void)appWillEnterBackground{
    DDLogVerbose(@"进入后台");
    self.saveTime = [[NSDate date]timeIntervalSince1970];
}

#pragma mark 进入前台
-(void)applicationDidBecomeActive{
    DDLogVerbose(@"进入前台");
    NSUInteger nowTime = [[NSDate date]timeIntervalSince1970];
    NSUInteger intereval =nowTime - self.saveTime;
    if (self.status == DriveStatusDriving) {
        self.driveTime = self.driveTime + intereval;
        self.driveCumulativeTime = self.driveCumulativeTime + intereval;
    }else if (self.status == DriveStatusResting) {
        self.restTime = self.restTime + intereval;
        self.restCumulativeTime = self.restCumulativeTime + intereval;
    }
}

#pragma mark 播报
-(void)speakMessage:(NSString *)message{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.speaker speakMessage:message];
    });
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
-(SpeakManager *)speaker{
    if (_speaker == nil) {
        _speaker = [SpeakManager shareManager];
    }
    return _speaker;
}
@end
