//
//  DriveModel.h
//  xahelper
//
//  Created by 小A on 2020/8/16.
//  Copyright © 2020 小A. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol DriveViewModelDelegate <NSObject>
@optional
-(void)currentTime:(NSUInteger)year
             month:(NSUInteger)month
               day:(NSUInteger)day
              hour:(NSUInteger)hour
            minute:(NSUInteger)minute
            second:(NSUInteger)second;

-(void)driveTimeHour:(NSInteger)hour
              minute:(NSInteger)minute
              second:(NSInteger)second;
-(void)cumulativeTimeHour:(NSInteger)hour
              minute:(NSInteger)minute
                   second:(NSInteger)second;
@end
@interface DriveViewModel : NSObject
@property (weak, nonatomic) id<DriveViewModelDelegate> delegate;
@end
