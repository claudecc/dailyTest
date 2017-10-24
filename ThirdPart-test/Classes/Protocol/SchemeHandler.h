//
//  SchemeHandler.h
//  MasterDuoBao
//
//  Created by 汤丹峰 on 16/3/23.
//  Copyright © 2016年 wenzhan. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 操作类型
 */
typedef enum _HandleType {
    TYPE_INVALID,
    TYPE_OPEN_WEB,
    TYPE_OPEN_NATIVE,
    TYPE_OPEN_SHARE,
    TYPE_OPEN_CLOSE,
    TYPE_OPEN_NATIVENEW,
    TYPE_OPEN_WXGUANZHU
}HandleType;

@interface SchemeHandler : NSObject

/**
 *  单例
 *
 *  @return SchemeHandler
 */
+ (id)defaultHandler;

/**
 *  判断当前链接是否是自定义url
 *
 *  @param urlStr NSURL
 *
 *  @return YES,是自定义url;NO,不是
 */
+ (BOOL)isLocalScheme:(NSURL*)urlStr;

/**
 *  对链接进行处理
 *
 *  @param urlStr   NSString
 *  @param animated BOOL
 */
- (BOOL)handleUrl:(NSString*)urlStr animated:(BOOL)animated;
/**
 *  对链接进行处理
 *
 *  @param urlStr   NSString
 *  @param animated BOOL
 *  @param config   NSString
 */
- (BOOL)handleUrl:(NSString*)urlStr animated:(BOOL)animated config:(NSString *)config;

@end
