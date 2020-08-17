//
//  DriveModel.m
//  xahelper
//
//  Created by 小A on 2020/8/16.
//  Copyright © 2020 小A. All rights reserved.
//

#import "DriveViewModel.h"
@interface DriveViewModel()
//@property (assign, nonatomic)NSTimeInterval <#instance#>;
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
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(currentTime) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer fireDate];
}
-(void)currentTime{
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
@end
