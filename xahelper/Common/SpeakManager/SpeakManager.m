//
//  SpeakManager.m
//  xahelper
//
//  Created by 小A on 2020/8/11.
//  Copyright © 2020 小A. All rights reserved.
//

#import "SpeakManager.h"
#import <AVFoundation/AVFoundation.h>
@interface SpeakManager()
@property(strong, nonatomic)AVAudioPlayer *player;
@end
@implementation SpeakManager
+(instancetype)shareManager{
    static SpeakManager *_shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareManager = [[super allocWithZone:NULL] init];
    });
    return _shareManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [SpeakManager shareManager];
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return [SpeakManager shareManager];
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    return [SpeakManager shareManager];
}

- (void)speakMessage:(NSString *)message{
    NSString *content = message;
        content = [content stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSString *urlStr = [NSString stringWithFormat:@"https://api.vvhan.com/api/song?txt=%@",content];
        NSURL *url = [[NSURL alloc]initWithString:urlStr];
       [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
           dispatch_async(dispatch_get_main_queue(), ^{
                    NSError *playError = nil;
               self.player = [[AVAudioPlayer alloc] initWithData:data error:&playError];
                if (error != nil) {
                    DDLogVerbose(@"error");
                }
                [self.player play];
           });
       }] resume] ;
}
@end
