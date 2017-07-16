//
//  RERankingView.m
//  ThirdPart-test
//
//  Created by 蔡晓东 on 2017/7/17.
//  Copyright © 2017年 caixiaodong. All rights reserved.
//

#import "RERankingView.h"

@implementation RERankingView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    CGFloat x = 50*ScaleNum;
    CGFloat w = SCREEN_WIDTH - 2*x;
    CGFloat h = w * (400/276.0);
    CGFloat y = (SCREEN_HEIGHT - h)/2.0 + 30;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor redColor];
    
    CGFloat btnWH = 40;
    CGFloat btnX = CGRectGetMaxX(bgView.frame)-btnWH;
    CGFloat btnY = y - 50 - btnWH;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeInfoLight];
    btn.frame = CGRectMake(btnX, btnY, btnWH, btnWH);
    [self addSubview:btn];
    [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, w, 20)];
    [bgView addSubview:titleLabel];
    titleLabel.text = @"抢牛币排行榜";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
}

- (void)close {
    [self removeFromSuperview];
}

- (void)show {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    self.frame = window.bounds;
    [window addSubview:self];
}

@end
