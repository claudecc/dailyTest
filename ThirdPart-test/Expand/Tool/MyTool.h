//
//  MyTool.h
//  ThirdPart-test
//
//  Created by caixiaodong on 2017/6/23.
//  Copyright © 2017年 caixiaodong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MyTool : NSObject
+ (float)getWidthWithStr:(NSString *)str font:(UIFont *)font;
+ (void)showToastWithStr:(NSString *)str;
+ (void)removeValueforKey:(NSString *)str;
+ (void)writeValue:(id)value forKey:(NSString *)str;
+ (id)readValueForKey:(NSString *)str;
+ (NSString *)getStringFromObj:(id)obj;
+ (NSString*)jsonStrFromObj:(id)object;
//获取系统当前日期 格式-yyyy-MM-DD
+ (NSString *)getMyCurYYYY_MM_DDtime;
+ (CGSize)stringText:(NSString *)text sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
+ (UIFont *)lightFontWithSize:(CGFloat)size;
+ (NSString *)filterHTML:(NSString *)html;


@end
