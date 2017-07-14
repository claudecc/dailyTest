//
//  AlertManager.m
//  ThirdPart-test
//
//  Created by caixiaodong on 2017/7/11.
//  Copyright © 2017年 caixiaodong. All rights reserved.
//

#import "AlertManager.h"

@interface AlertManager ()
@property (nonatomic, strong) NSMutableArray *alertArray;

@end

@implementation AlertManager

+ (instancetype)sharedInstance {
    static id _instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[AlertManager alloc] init];
    });
    return _instance;
}

+ (void)popAlert:(UIView *)view withName:(NSString *)name {
    AlertManager *manager = [self sharedInstance];
    [manager popAlert:view withName:name];
}

+ (void)insertAlert:(UIView *)view withName:(NSString *)name {
    AlertManager *manager = [self sharedInstance];
    [manager insertAlert:view withName:name];
}

+ (void)removeAlertWithName:(NSString *)name {
    AlertManager *manager = [self sharedInstance];
    [manager removeAlertWithName:name];
}

- (void)popAlert:(UIView *)view withName:(NSString *)name {
    
    if (!view || !name) {
        return;
    }
    
    if (self.alertArray.count > 0) {
        return;
    } else {
        [self.alertArray addObject:@{name:view}];
    }
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    view.frame = window.bounds;
    [window addSubview:view];
}

- (void)insertAlert:(UIView *)view withName:(NSString *)name {
    
    if (!view || !name) {
        return;
    }
    
    UIView *lastView = nil;
    if (self.alertArray.count > 0) {
        for (NSDictionary *dict in self.alertArray) {
            NSString *key = dict.allKeys.firstObject;
            if ([key isEqualToString:name]) {
                return;
            }
        }
        NSDictionary *lastDict = self.alertArray.lastObject;
        lastView = lastDict.allValues.firstObject;
    } else {
        [self.alertArray addObject:@{name:view}];
    }
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    view.frame = window.bounds;
    if (lastView) {
        [window insertSubview:view belowSubview:lastView];
    } else {
        [window addSubview:view];
    }
}

- (void)removeAlertWithName:(NSString *)name {
    if (self.alertArray.count > 0) {
        int j = -1;
        for (int i = 0; i < self.alertArray.count; i++) {
            NSDictionary *dict = self.alertArray[i];
            NSString *key = dict.allKeys.firstObject;
            if ([key isEqualToString:name]) {
                j = i;
            }
        }
        if (j >= 0) {
            [self.alertArray removeObjectAtIndex:j];
        }
    }
}

- (NSMutableArray *)alertArray {
    if (!_alertArray) {
        _alertArray = [NSMutableArray array];
    }
    return _alertArray;
}

@end
