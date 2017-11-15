//
//  ScreenRecorder.h
//  CatchDoll
//
//  Created by caixiaodong on 2017/11/13.
//  Copyright © 2017年 tangdanfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScreenRecorder : NSObject

+ (instancetype)sharedInstance;
- (void)startRecoder;

@end
