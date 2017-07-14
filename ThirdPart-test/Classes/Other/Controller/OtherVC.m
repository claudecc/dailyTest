//
//  OtherVC.m
//  ThirdPart-test
//
//  Created by caixiaodong on 2017/7/7.
//  Copyright © 2017年 caixiaodong. All rights reserved.
//

#import "OtherVC.h"
#import "ScaleScrollView.h"

@interface OtherVC ()

@end

@implementation OtherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    ScaleScrollView *view = [[ScaleScrollView alloc] init];
    view.dataArray = @[@1,@2,@3,@4,@5];
    [AlertManager popAlert:view withName:@"scaleScrollView"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [AlertManager popAlert:view withName:@"scaleScrollView"];
    });
    ScaleScrollView *view2 = [[ScaleScrollView alloc] init];
    view2.dataArray = @[@1,@2,@3];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [AlertManager insertAlert:view2 withName:@"scaleScrollView2"];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
