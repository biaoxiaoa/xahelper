//
//  DriveVC.m
//  xahelper
//
//  Created by 小A on 2020/8/16.
//  Copyright © 2020 小A. All rights reserved.
//

#import "DriveVC.h"
#import "DriveView.h"
@interface DriveVC ()
@property(strong, nonatomic)DriveView *driveView;
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
}

-(DriveView *)driveView{
    if (_driveView == nil) {
        _driveView = [[DriveView alloc]init];
        _driveView.topPos.equalTo(@0);
        _driveView.leftPos.equalTo(@0);
        _driveView.bottomPos.equalTo(@0);
        _driveView.rightPos.equalTo(@0);
    }
    return _driveView;
}
@end
