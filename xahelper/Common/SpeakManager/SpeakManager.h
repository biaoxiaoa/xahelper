//
//  SpeakManager.h
//  xahelper
//
//  Created by 小A on 2020/8/11.
//  Copyright © 2020 小A. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpeakManager : NSObject
+(instancetype)shareManager;
-(void)speakMessage:(NSString *)message;
@end
