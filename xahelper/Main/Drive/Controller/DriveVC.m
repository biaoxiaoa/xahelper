//
//  DriveVC.m
//  xahelper
//
//  Created by 小A on 2020/8/16.
//  Copyright © 2020 小A. All rights reserved.
//

#import "DriveVC.h"
#import "DriveView.h"
#import "DriveViewModel.h"
@interface DriveVC ()<DriveViewModelDelegate>
@property(strong, nonatomic)DriveView *driveView;
@property(strong, nonatomic)DriveViewModel *driveViewModel;
@end

@implementation DriveVC


-(void)loadView{
    [super loadView];
    self.rootLayout.backgroundColor = [UIColor colorWithRed:1/255.0 green:0 blue:0 alpha:1];
    [self.rootLayout addSubview:self.driveView];
}

-(void)viewWillAppear:(BOOL)animated{
    [self portraitLeft];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self portrait];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.driveViewModel.delegate = self;
}

#pragma mark DriveViewModelDelegate
-(void)currentTime:(NSUInteger)year
             month:(NSUInteger)month
               day:(NSUInteger)day
              hour:(NSUInteger)hour
            minute:(NSUInteger)minute
            second:(NSUInteger)second{
    
    [self.driveView currentTime:year month:month day:day hour:hour minute:minute second:second];
}

-(void)driveTimeHour:(NSUInteger)hour minute:(NSUInteger)minute second:(NSUInteger)second{
    [self.driveView driveTimeHour:hour minute:minute second:second];
}

-(void)cumulativeTimeHour:(NSUInteger)hour minute:(NSUInteger)minute second:(NSUInteger)second{
    [self.driveView cumulativeTimeHour:hour minute:minute second:second];
}
-(void)driveStatusChanged:(DriveStatus)status{
    if (status==DriveStatusResting) {
        [self.driveView restStatus];
    }else{
        [self.driveView driveStatus];
    }
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
  return UIInterfaceOrientationMaskLandscapeLeft;
}
-(DriveView *)driveView{
    if (_driveView == nil) {
        _driveView = [[DriveView alloc]init];
        _driveView.topPos.equalTo(@0);
        _driveView.leftPos.equalTo(@0);
        _driveView.bottomPos.equalTo(@0);
        _driveView.rightPos.equalTo(@0);
        __weak typeof(self) weakSelf = self;
        _driveView.tipBlock = ^{
            [weakSelf.driveViewModel changeStatus];
        };
    }
    return _driveView;
}
-(DriveViewModel *)driveViewModel{
    if (_driveViewModel == nil) {
        _driveViewModel = [[DriveViewModel alloc]init];
    }
    return _driveViewModel;
}
@end
