//
//  MeVC.m
//  ThirdPart-test
//
//  Created by caixiaodong on 2017/6/23.
//  Copyright © 2017年 caixiaodong. All rights reserved.
//

#import "MeVC.h"
#import <WebKit/WebKit.h>
@interface MeVC ()<WKUIDelegate>
@property (nonatomic, assign) CGRect viewRect;
@property (nonatomic, strong) CALayer *moveLayer;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation MeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)createMyBtn {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(40, 100, 40, 40);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(myBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)myBtnClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    if (btn.selected) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(showRain) userInfo:nil repeats:YES];
    } else {
        for (UIView *view in self.view.subviews) {
            [view removeFromSuperview];
            if ([view isKindOfClass:[UIButton class]]) {
                continue;
            }
        }
    }
}

- (void)showRain {
    UIImageView *icon = [[UIImageView alloc] init];
    icon.image = [self imageWithSize:CGSizeMake(30, 30)];
    int maxX = SCREEN_WIDTH;
    int i = arc4random()%(maxX-30);
    icon.frame = CGRectMake(i, 0, 30, 30);
    [self.view addSubview:icon];
    icon.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconClick:)];
    [icon addGestureRecognizer:tap];
    
    [UIView beginAnimations:@"a" context:(__bridge void * _Nullable)(icon)];
    [UIView setAnimationDuration:2];
    
    int maxY = SCREEN_HEIGHT - 64 - 50;
    int j = arc4random()%maxX;
    icon.frame = CGRectMake(j, maxY, 30, 30);
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView commitAnimations];
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    //    NSLog(@" 动画结束了");
    //    [imageView removeFromSuperview];
    
    //    方法2. 强制类型转换
    UIImageView *imageView = (__bridge UIImageView *)context;
    [imageView removeFromSuperview];
    //    设置透明度
    //    imageView.alpha = 0;
    
}

- (void)iconClick:(UITapGestureRecognizer *)tap {
    UIView *view = tap.view;
    view.backgroundColor = [UIColor blueColor];
}

// demo
- (void)createDemoBtn {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    btn.frame = CGRectMake(40, 100, 40, 40);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (btn.selected) {
        if (self.timer) {
            [self.timer invalidate];
        }
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(createRain) userInfo:@"" repeats:YES];
    } else {
        if (self.timer) {
            [self.timer invalidate];
        }
        for (CALayer *layer in self.view.layer.sublayers) {
            [layer removeAllAnimations];
        }
    }
}

- (void)createRain {
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.view addSubview:view];
    view.image = [self imageWithSize:CGSizeMake(30, 30)];
    
    self.moveLayer = [CALayer new];
    self.moveLayer.bounds = view.frame;
    self.moveLayer.anchorPoint = CGPointMake(0, 0);
    self.moveLayer.position = CGPointMake(0, -40);
    self.moveLayer.contents = (__bridge id _Nullable)(view.image.CGImage);
    [self.view.layer addSublayer:self.moveLayer];
    [self addAnimation];
}

- (void)addAnimation {
    CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnimation.values = @[[NSValue valueWithCGPoint:CGPointMake(arc4random_uniform(320), 10)],[NSValue valueWithCGPoint:CGPointMake(arc4random_uniform(320), 500)]];
    moveAnimation.duration = 5;
    moveAnimation.repeatCount = 1;
    moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:@"linear"];
    [self.moveLayer addAnimation:moveAnimation forKey:@"move"];
    
}

- (UIImage *)imageWithSize:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[UIColor redColor] CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)createWebview {
    WKWebView *web = [[WKWebView alloc] initWithFrame:self.viewRect];
    [self.view addSubview:web];
    web.UIDelegate = self;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"htmlText" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSString *htmlStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [web loadHTMLString:htmlStr baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGRect)viewRect {
    return CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64);
}

@end
