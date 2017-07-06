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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
