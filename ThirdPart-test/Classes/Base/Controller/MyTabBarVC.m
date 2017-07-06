//
//  MyTabBarVC.m
//  ThirdPart-test
//
//  Created by caixiaodong on 2017/6/23.
//  Copyright © 2017年 caixiaodong. All rights reserved.
//

#import "MyTabBarVC.h"
#import "BaseNavigationVC.h"
#import "HomeVC.h"
#import "MeVC.h"
#import "OtherVC.h"
#import "UIImage+RenderedImage.h"
@interface MyTabBarVC ()

@end

@implementation MyTabBarVC

- (instancetype)init {
    if (self = [super init]) {
        BaseNavigationVC *homeNav = [[BaseNavigationVC alloc] initWithRootViewController:[HomeVC new]];
        homeNav.title = @"Home";
        homeNav.tabBarItem.title = @"home";
        
        BaseNavigationVC *meNav = [[BaseNavigationVC alloc] initWithRootViewController:[MeVC new]];
        meNav.title = @"Me";
        meNav.tabBarItem.title = @"Me";
        
        BaseNavigationVC *otherNav = [[BaseNavigationVC alloc] initWithRootViewController:[OtherVC new]];
        otherNav.title = @"Other";
        otherNav.tabBarItem.title = @"Other";
        
        self.viewControllers = @[homeNav,meNav,otherNav];
        
        [UITabBar appearance].backgroundImage = [UIImage imageWithRenderColor:[UIColor whiteColor] renderSize:CGSizeMake(10., 10.)];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
        
        UINavigationBar *bar = [UINavigationBar appearance];
        //设置显示的颜色
        [bar setBackgroundImage:[UIImage imageWithRenderColor:THEME_COLOR renderSize:CGSizeMake(10., 10.)] forBarMetrics:UIBarMetricsDefault];
        //设置字体颜色
        [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
