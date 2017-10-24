//
//  SchemeHandler.m
//  MasterDuoBao
//
//  Created by 汤丹峰 on 16/3/23.
//  Copyright © 2016年 wenzhan. All rights reserved.
//

#import "SchemeHandler.h"
#import "SchemeDefine.h"
#import "VCManager.h"
#import "MDUrl.h"
#import "WebController.h"
#import "AppDelegate.h"


@interface SchemeHandler ()

@property(nonatomic, strong) UIViewController *topWebController;

@end

@implementation SchemeHandler
//代金券协议 honglu://www.honglu.com/native_new?i_name=ZjwlTicketVC&a_name=ZJQuanActivity&need_xiaoniu_login=1&need_zjwl_login=1
//中金物联充值 honglu://www.honglu.com/native?name=recharge&need_zjwl_login=1&index=0&type_code=ZJWL_AG

static SchemeHandler *m_handler;
+ (id)defaultHandler
{
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        m_handler = [[SchemeHandler alloc] init];
    });
    return m_handler;
}

//对链接进行处理
- (BOOL)handleUrl:(NSString*)urlStr animated:(BOOL)animated
{
    return [self handleUrl:urlStr animated:animated config:@""];
}
- (BOOL)handleUrl:(NSString*)urlStr animated:(BOOL)animated config:(NSString *)config
{
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    //先判断是否是以我们定义的scheme开始
    if (![SchemeHandler isLocalScheme:[NSURL URLWithString:urlStr]])
    {
        return NO;
    }
    //根据url,获取path类型:处理web和native
    HandleType type = [self getHandleType:urlStr];
    
    switch (type)
    {
        case TYPE_OPEN_WEB:
            return [self handleOpenWeb:urlStr animated:animated config:config];
            break;
        case TYPE_OPEN_NATIVE:
            return [self handleOpenNative:urlStr animated:animated config:config];
            break;
        case TYPE_OPEN_SHARE:
            
            break;
        case TYPE_OPEN_CLOSE:
            [self handleOpenClose:urlStr animated:animated config:config];
            break;
        case TYPE_OPEN_NATIVENEW:
            return [self handleOpenNativeNew:urlStr animated:animated config:config];
            break;
        case TYPE_OPEN_WXGUANZHU:
            
            break;
        case TYPE_INVALID:
            return NO;
    }
    return YES;
}

//判断当前链接是否是自定义url
+ (BOOL)isLocalScheme:(NSURL*)urlStr
{
    if ([(NSString *)[urlStr scheme] rangeOfString:URL_SCHEME].location != NSNotFound)
    {
        return YES;
    }
    return NO;
}
//通过path 获取当前操作类型
- (HandleType)getHandleType:(NSString*)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    
    //需要先登入的情况，进入登入界面，登入成功后回调回来
    if (0) {
        return TYPE_INVALID;
    }
    //先判断域名是否是我们定义的域名
    if ([url.host isEqualToString:URL_HOST]) {
        NSString *path = url.path;
        
        //再判断路径
        if ([path isEqualToString:URL_PATH_WEB])
        {
            // /jump
            return TYPE_OPEN_WEB;
        }
        else if ([path isEqualToString:URL_PATH_NATIVE])
        {
            // /native
            return TYPE_OPEN_NATIVE;
        }
        else if ([path isEqualToString:URL_PATH_SHARE])
        {
            // /share
            return TYPE_OPEN_SHARE;
        }
        else if ([path isEqualToString:URL_PATH_CLOSR])
        {
            // /close
            return TYPE_OPEN_CLOSE;
        }
        else if ([path isEqualToString:URL_PATH_NATIVENEW])
        {
            // /native_new
            return TYPE_OPEN_NATIVENEW;
        }
        else if ([path isEqualToString:URL_PATH_WXGUANZHU])
        {
            // /wx_guanzhu
            return TYPE_OPEN_WXGUANZHU;
        }
    }
    return TYPE_INVALID;
}

#pragma mark - 协议处理
//处理jump协议
- (BOOL)handleOpenWeb:(NSString*)urlStr animated:(BOOL)animated config:(NSString *)config
{
    UIViewController *webVC = [self generateWebVC:urlStr config:config];
    webVC.hidesBottomBarWhenPushed = YES;
    self.topWebController = webVC;
    
    UIViewController *currentVC = [[VCManager shareVCManager] getTopViewController];
    if (currentVC.navigationController.navigationBarHidden) {
        currentVC.navigationController.navigationBarHidden = NO;
    }
    
    [currentVC.navigationController pushViewController:webVC animated:animated];
    if (webVC) {
        return YES;
    } else {
        return NO;
    }
}

//处理native协议
- (BOOL)handleOpenNative:(NSString *)urlStr animated:(BOOL)animated config:(NSString *)config
{
    UIViewController *nativeVC = [self generateNativeVC:urlStr config:config];
    if (nativeVC) {
        nativeVC.hidesBottomBarWhenPushed = YES;
        
        UIViewController *currentVC = [[VCManager shareVCManager] getTopViewController];
        
        [currentVC.navigationController pushViewController:nativeVC animated:animated];
        return YES;
    }
    return NO;
}

//处理close协议
- (void)handleOpenClose:(NSString *)urlStr animated:(BOOL)animated config:(NSString *)config
{
    //关闭当前webVC
    if (self.topWebController.presentingViewController) {
        [self.topWebController dismissViewControllerAnimated:YES completion:nil];
    } else {
        NSMutableArray *mArr = [NSMutableArray arrayWithArray:self.topWebController.navigationController.viewControllers];
        for (UIViewController *vc in mArr) {
            if ([vc isKindOfClass:[self.topWebController class]]) {
                [mArr removeObject:vc];
                break;
            }
        }
        self.topWebController.navigationController.viewControllers = mArr;
    }
}

//处理native_new协议
- (BOOL)handleOpenNativeNew:(NSString *)urlStr animated:(BOOL)animated config:(NSString *)config
{
    UIViewController *nativeVC = [self generateNativeNewVC:urlStr config:config];
    if (nativeVC) {
        nativeVC.hidesBottomBarWhenPushed = YES;
        
        UIViewController *currentVC = [[VCManager shareVCManager] getTopViewController];
        
        [currentVC.navigationController pushViewController:nativeVC animated:animated];
        return YES;
    }
    return NO;
}

#pragma mark - 创建ViewController
//生成显示H5页面的ViewController
- (UIViewController *)generateWebVC:(NSString *)urlStr config:(NSString *)config
{
    WebController *vc = nil;
    
    NSURL *url = [NSURL URLWithString:urlStr];
    if ([url.host isEqualToString:URL_HOST]) {
        vc = [[WebController alloc] initWithgotoVC:config];
        
        NSString *value = [url getValueInQueryForKey:URL_QUERY_KEY_URL isCaseSensitive:NO];
        vc.urlStr = value;
        
        value = [url getValueInQueryForKey:URL_QUERY_KEY_TITLE isCaseSensitive:NO];
        value = [value stringByReplacingOccurrencesOfString:@"+" withString:@" "];
//        value = [url getValueInQueryForKey:URL_QUERY_KEY_CALENDAR_TITLE isCaseSensitive:NO];
        if (value && ![value isEqualToString:@""]) {
            vc.titleStr = value;
        }
        
        value = [url getValueInQueryForKey:URL_QUERY_KEY_CANBACK isCaseSensitive:NO];
        vc.canBack = [value isEqualToString:@"1"] ? YES : NO;
        
        value = [url getValueInQueryForKey:URL_QUERY_KEY_RIGHTBTNTITLE isCaseSensitive:NO];
        if (value&&![value isEqualToString:@""]) {
            vc.rightBtnTitle = value;
        }
    }
    return vc;
}
/**
 native协议
 是否需要登录 need_xiaoniu_login=1（需要登录小牛，如圈子）|need_gg_login=1(需要登录广贵)|need_jn_login=1（需要登录吉农）|need_hg_login=1（需要登录哈贵）
 产品选则参数type_code=(XAG1是广贵银，JN_AG吉银，JN_KC咖啡，JN_CO油，HG_AG哈贵银，HG_OIL哈贵油)
 
 首页 name=home 参数 index=1(底部五个tab对应1-5)bottom=1（如果是首页，bottom传1表示显示下方分析师策略）
 买涨买跌 name=buy_product 参数 direction=1（1买跌，2买涨）
 充值 name=recharge 参数 index=0(1-提现，0-充值，2-记录)
 代金券 name=ticket
 登录 name=login
 
 帖子详情 name=topic_detail 参数topic_id=214（帖子id）
 比如广贵充值，协议为honglu://www.honglu.com/native?name=recharge&index=0&need_gg_login=1&type_code=XAG1
 
 jump协议honglu://www.honglu.com/jump?right_btn_title=积分商城&url=http%3a%2f%2fh5.518yin.com%2fh5%2fIntegral%2findex.html，
 具体按钮点击事件在openNativeShareWin()这个方法里面，h5做的时候自己写
 **/
//解析url，获取参数,并将参数传给约定好的native界面
- (UIViewController *)generateNativeVC:(NSString *)urlStr config:(NSString *)config
{
    BaseViewController *vc = nil;
    
    NSURL *url = [NSURL URLWithString:urlStr];
    if ([url.host isEqualToString:URL_HOST]) {
        
        NSString *value = [url getValueInQueryForKey:URL_QUERY_KEY_NAME isCaseSensitive:NO];
        if ([value isEqualToString:@""]) {
            
        }
    }
    return vc;
}
//解析url，获取native界面控制器名称，通过反射生产controller
- (UIViewController *)generateNativeNewVC:(NSString *)urlStr config:(NSString *)config
{
    BaseViewController *vc = nil;
    
    NSURL *url = [NSURL URLWithString:urlStr];
    //ios取的类名参数叫i_name
    NSString *tempClassName = [url getValueInQueryForKey:URL_QUERY_KEY_NAME isCaseSensitive:NO];
    Class tempClass = NSClassFromString(tempClassName);
    vc = [[tempClass alloc] init];
    
    return vc;
}

@end
