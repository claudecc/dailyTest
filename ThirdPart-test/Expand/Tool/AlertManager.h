//
//  AlertManager.h
//  ThirdPart-test
//
//  Created by caixiaodong on 2017/7/11.
//  Copyright © 2017年 caixiaodong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertManager : NSObject

+ (void)popAlert:(UIView *)view withName:(NSString *)name;
+ (void)insertAlert:(UIView *)view withName:(NSString *)name;
+ (void)removeAlertWithName:(NSString *)name;
@end
