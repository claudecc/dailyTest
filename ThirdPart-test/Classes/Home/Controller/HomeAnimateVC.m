//
//  HomeAnimateVC.m
//  ThirdPart-test
//
//  Created by caixiaodong on 2017/7/28.
//  Copyright © 2017年 caixiaodong. All rights reserved.
//

#import "HomeAnimateVC.h"

@interface HomeAnimateVC ()

@end

@implementation HomeAnimateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Animate";
    
    [self createSegView];
}

- (void)layerTest {
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    [self.view.layer addSublayer:layer];
//    layer.frame = CGRectMake(110, 100, 150, 100);
//    layer.backgroundColor = [UIColor blackColor].CGColor;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(110, 100, 150, 100) cornerRadius:50];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor yellowColor].CGColor;
    layer.strokeColor = [UIColor blackColor].CGColor;
    
}

- (void)layerTest2 {
    CGPoint startPoint = CGPointMake(50, 300);
    CGPoint endPoint = CGPointMake(300, 300);
    CGPoint controlPoint = CGPointMake(170, 200);
    
    CALayer *layer1 = [[CALayer alloc] init];
    layer1.frame = CGRectMake(startPoint.x, startPoint.y, 5, 5);
    layer1.backgroundColor = [UIColor redColor].CGColor;
    
    CALayer *layer2 = [[CALayer alloc] init];
    layer2.frame = CGRectMake(endPoint.x, endPoint.y, 5, 5);
    layer2.backgroundColor = [UIColor redColor].CGColor;
    
    CALayer *layer3 = [CALayer layer];
    layer3.frame = CGRectMake(controlPoint.x, controlPoint.y, 5, 5);
    layer3.backgroundColor = [UIColor redColor].CGColor;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    [path moveToPoint:startPoint];
    [path addQuadCurveToPoint:endPoint controlPoint:controlPoint];
    
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor yellowColor].CGColor;
    shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    
    [self.view.layer addSublayer:shapeLayer];
    [self.view.layer addSublayer:layer1];
    [self.view.layer addSublayer:layer2];
    [self.view.layer addSublayer:layer3];
}

- (void)createSegView {
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"1",@"2",@"3",@"4"]];
    seg.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    [self.view addSubview:seg];
    [seg addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)segClick:(UISegmentedControl *)seg {
    
}

@end
