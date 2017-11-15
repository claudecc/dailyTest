//
//  MyTool.m
//  ThirdPart-test
//
//  Created by caixiaodong on 2017/6/23.
//  Copyright © 2017年 caixiaodong. All rights reserved.
//

#import "MyTool.h"
#import <AdSupport/AdSupport.h>

#define showtoast_view_tag 201710300

@implementation MyTool

+ (float)getWidthWithStr:(NSString *)str font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 9999, font.lineHeight)];
    label.text = str;
    label.font = font;
    [label sizeToFit];
    return label.size.width;
}
+ (void)showToastWithStr:(NSString *)str{
    if (!str || [MyTool getStringFromObj:str].length <= 0) {
        return;
    }
    for (UIView *subview in [[UIApplication sharedApplication] keyWindow].subviews) {
        if (subview.tag == showtoast_view_tag) {
            [subview removeFromSuperview];
        }
    }
    
    UIFont *font = [UIFont systemFontOfSize:13];
    CGSize strSize = [MyTool stringText:str sizeWithFont:font maxW:SCREEN_WIDTH-40];
    
    UILabel *toastVeiw = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, strSize.width+20, strSize.height+20)];
    toastVeiw.tag = showtoast_view_tag;
    toastVeiw.textAlignment = NSTextAlignmentCenter;
    toastVeiw.clipsToBounds = YES;
    toastVeiw.numberOfLines = 0;
    toastVeiw.text = str;
    toastVeiw.font = font;
    toastVeiw.textColor = [UIColor whiteColor];
    toastVeiw.center = CGPointMake(SCREEN_WIDTH*0.5, SCREEN_HEIGHT*0.5);
    toastVeiw.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    toastVeiw.layer.cornerRadius = 5;
    [[[UIApplication sharedApplication] keyWindow] addSubview:toastVeiw];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [toastVeiw removeFromSuperview];
    });
}
+ (CGSize)stringText:(NSString *)text sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, maxW, font.lineHeight)];
    label.text = text;
    label.numberOfLines = 0;
    label.font = font;
    [label sizeToFit];
    return label.size;
}
+ (void)removeValueforKey:(NSString *)str{
    if ([MyTool readValueForKey:str]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:str];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (void)writeValue:(id)value forKey:(NSString *)str{
    [[NSUserDefaults standardUserDefaults]  setObject:[NSKeyedArchiver archivedDataWithRootObject:value] forKey:str];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)readValueForKey:(NSString *)str{
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:str];
    if (!obj) {
        return nil;
    }
    return [NSKeyedUnarchiver unarchiveObjectWithData:obj];
}
+ (NSString *)idfa{
    NSString *idfaStr;
    Class theClass=NSClassFromString(@"ASIdentifierManager");
    if (theClass)
    {
        idfaStr = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }else{
        idfaStr = @"";
    }
    return idfaStr;
}
+ (NSString *)getStringFromObj:(id)obj{
    return obj?[NSString stringWithFormat:@"%@",obj]:@"";
}

+(NSString*)jsonStrFromObj:(id)object
{
    if (!object) {
        return @"";
    }
    NSString *jsonString = @"";
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
+ (NSString *)getMyCurYYYY_MM_DDtime
{
    NSDate *curDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:curDate];
}
+ (UIFont *)lightFontWithSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Light" size:size];
    if (!font) {
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}
// 过滤HTML标签
+ (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}


@end
