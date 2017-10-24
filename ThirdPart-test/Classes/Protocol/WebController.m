//
//  WebController.m
//  MasterDuoBao
//
//  Created by 汤丹峰 on 16/3/24.
//  Copyright © 2016年 wenzhan. All rights reserved.
//

#import "WebController.h"
#import "UserAgent.h"
#import "MDUrl.h"

@interface WebController ()<UIWebViewDelegate>
{
    NSDictionary *commentDic;
    NSDictionary *replyDic;
    BOOL isLogin;// 用于判断页面重现是否需要重刷新页面
}
@property(nonatomic, weak) UIWebView *myWebView;

@end

@implementation WebController
- (id)initWithgotoVC:(NSString *)vc{
    self = [super init];
    if(self)
    {

    }
    return self;

}
- (void)viewWillDisappear:(BOOL)animated {
    if (self.isTopUp) {
//        [[UserAgent ShardInstnce] webSetUserAgent];
    } else {
        [self.myWebView reload]; // 在充值的情况下不重刷，防止重新加载充值方法跳到支付宝
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(self) wSelf = self;
//    [self actionCustomLeftBtnWithNrlImage:@"titlebar_icon_goback_rest" htlImage:@"titlebar_icon_goback_pressed" title:@"" action:^{
//        if (wSelf.canBack) {
//            if ([wSelf.myWebView canGoBack]) {
//                [wSelf.myWebView goBack];
//            } else {
//                [wSelf.navigationController popViewControllerAnimated:YES];
//            }
//        } else {
//            [wSelf.navigationController popViewControllerAnimated:YES];
//        }
//    }];
    
    if (self.rightBtnTitle) {
//        [self actionCustomRightBtnWithNrlImage:nil htlImage:nil title:self.rightBtnTitle action:^{
//            [wSelf rightBtnClick];
//        }];
    }
    
    if (self.isTopUp) {
//        NSString *uaStr = [[UserAgent ShardInstnce] getUserAgent];
//        NSString *oriStr = [NSString stringWithFormat:@" %@",[ToolGlobalValue instance].oriUserAgent];
//        uaStr = [uaStr stringByAppendingString:oriStr];
//        [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent":uaStr}];
    } else {
//        [[UserAgent ShardInstnce] webSetUserAgent];
    }
    
    UIWebView *myWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    myWebView.delegate = self;
    myWebView.scalesPageToFit = YES;
    [self.view addSubview:myWebView];
    self.myWebView = myWebView;
    [myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5]];

}

#pragma mark - UIWebViewDelegate 协议方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = request.URL;
    if ([url.absoluteString hasPrefix:[NSString stringWithFormat:@"asdfdsf"]]) {
        
        return NO;
    }
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
//    [self showLoad];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self cancelLoad];
//    });
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    [self cancelLoad];
    if (self.titleStr) {
        self.navigationItem.title = self.titleStr;
        return;
    }
    NSString *theTitle=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = theTitle;
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:( NSError *)error
{
//    [self cancelLoad];
}
#pragma mark - 分享
- (void)rightBtnClick
{
//    NSString *str = [self.myWebView stringByEvaluatingJavaScriptFromString:@"openNativeShareWin();"];
//    DLog(@"share.JS返回值：%@",str);
}
#pragma mark - 刷新
- (void)refresh{
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
}
@end
