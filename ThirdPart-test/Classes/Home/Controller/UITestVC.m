//
//  UITestVC.m
//  ThirdPart-test
//
//  Created by caixiaodong on 2017/12/7.
//  Copyright © 2017年 caixiaodong. All rights reserved.
//

#import "UITestVC.h"

@implementation UITestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor whiteColor];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    [button addSubview:label];
    
    NSString *userName1 = @"用户名1";
    NSString *userName2 = @"用户名2";
    NSString *content = @"爱的方式离开的房间是到了快捷方式大立科技发打客服";
    content = [NSString stringWithFormat:@"%@ 回复 %@ : %@",userName1,userName2,content];
    NSRange range1 = [content rangeOfString:userName1];
    NSRange range2 = [content rangeOfString:userName2];
    NSURL *url1 = [NSURL URLWithString:userName1];
    NSURL *url2 = [NSURL URLWithString:userName2];
    
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:content];
    [att addAttribute:NSLinkAttributeName value:url1 range:range1];
    [att addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range1];
    [att addAttribute:NSLinkAttributeName value:url2 range:range2];
    [att addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range2];
    
}

- (void)btnClick:(UIButton *)btn {
    [MyTool showToastWithStr:@"点击-按钮"];
}

@end
