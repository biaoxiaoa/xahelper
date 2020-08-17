//
//  HelperController.m
//  xahelper
//
//  Created by 小A on 2020/8/16.
//  Copyright © 2020 小A. All rights reserved.
//

#import "HelperController.h"

@interface HelperController ()

@end

@implementation HelperController
-(void)loadView{
    self.view = self.rootLayout;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)portraitLeft{
    NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}
-(void)portrait{
    NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}

-(MyRelativeLayout *)rootLayout{
    if (_rootLayout == nil) {
        _rootLayout = [MyRelativeLayout new];
        _rootLayout.insetsPaddingFromSafeArea = UIRectEdgeNone;
        _rootLayout.backgroundColor = [UIColor orangeColor];
        _rootLayout.topPos.equalTo(@0);
        _rootLayout.leftPos.equalTo(@0);
        _rootLayout.bottomPos.equalTo(@0);
        _rootLayout.rightPos.equalTo(@0);
    }
    return _rootLayout;
}
@end
