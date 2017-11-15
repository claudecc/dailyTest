//
//  OSSTool.h
//  ThirdPart-test
//
//  Created by caixiaodong on 2017/11/15.
//  Copyright © 2017年 caixiaodong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSSTool : NSObject

+ (instancetype)sharedInstance;

- (void)uploadObjectWithUrl:(NSURL *)url;

@end
