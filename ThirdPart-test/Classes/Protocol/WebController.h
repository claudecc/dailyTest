//
//  WebController.h
//  MasterDuoBao
//
//  Created by 汤丹峰 on 16/3/24.
//  Copyright © 2016年 wenzhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface WebController : BaseViewController

/**
 *  webURL
 */
@property (nonatomic , copy) NSString *urlStr;
/**
 *  是否存在title
 */
@property (nonatomic, copy) NSString *titleStr;
/**
 *  是否存在分享按钮
 */
@property (nonatomic , strong) NSString *rightBtnTitle;
/**
 *  是否可以后退
 */
@property (nonatomic, assign) BOOL canBack;
/**
 *  是否是充值页面
 */
@property (nonatomic, assign) BOOL isTopUp;
- (id)initWithgotoVC:(NSString *)vc;//注册调用协议接口进来返回首页的初始化方法
@end
