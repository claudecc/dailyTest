//
//  BarrageVC.m
//  ThirdPart-test
//
//  Created by 蔡晓东 on 2017/7/16.
//  Copyright © 2017年 caixiaodong. All rights reserved.
//

#import "BarrageVC.h"
#import "BarrageView.h"


@interface BarrageVC ()

@end

@implementation BarrageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"弹幕VC";
    
    BarrageView *view = [[BarrageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
