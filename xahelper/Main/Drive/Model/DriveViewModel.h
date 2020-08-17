//
//  DriveModel.h
//  xahelper
//
//  Created by 小A on 2020/8/16.
//  Copyright © 2020 小A. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DriveStatus) {
    DriveStatusStoping,
    DriveStatusDriving,
    DriveStatusResting,
};

@protocol DriveViewModelDelegate <NSObject>
@optional
-(void)currentTime:(NSUInteger)year
             month:(NSUInteger)month
               day:(NSUInteger)day
              hour:(NSUInteger)hour
            minute:(NSUInteger)minute
            second:(NSUInteger)second;

-(void)driveTimeHour:(NSUInteger)hour
              minute:(NSUInteger)minute
              second:(NSUInteger)second;

-(void)cumulativeTimeHour:(NSUInteger)hour
              minute:(NSUInteger)minute
                   second:(NSUInteger)second;
-(void)driveStatusChanged:(DriveStatus)status;
@end
@interface DriveViewModel : NSObject
@property (weak, nonatomic) id<DriveViewModelDelegate> delegate;
@property (assign, nonatomic) DriveStatus status;
-(void)changeStatus;
@end
