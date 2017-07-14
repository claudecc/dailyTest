//
//  ScaleScrollView.m
//  ThirdPart-test
//
//  Created by caixiaodong on 2017/7/7.
//  Copyright © 2017年 caixiaodong. All rights reserved.
//

#import "ScaleScrollView.h"

#define maxOffset  SCREEN_WIDTH

@interface CellView : UIView
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) int index;
@end

@implementation CellView



@end

@interface ScaleScrollView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scroll;
@end

@implementation ScaleScrollView

//- (instancetype)initWithFrame:(CGRect)frame {
//    if (self = [super initWithFrame:frame]) {
//        [self setupUI];
//    }
//    return self;
//}

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 160, SCREEN_WIDTH, 300)];
    [self addSubview:scroll];
    self.scroll = scroll;
    scroll.delegate = self;
    scroll.backgroundColor = [UIColor lightGrayColor];
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.bounces = NO;
    scroll.decelerationRate = 0.1;
    
    CGFloat wh = 50;
    CGFloat y = CGRectGetMaxY(scroll.frame) + 50;
    CGFloat x = (SCREEN_WIDTH - wh)*0.5;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeInfoDark];
    btn.frame = CGRectMake(x, y, wh, wh);
    [btn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

- (void)reloadUI {
    if (!self.dataArray) {
        return;
    }
    NSMutableArray *viewArr = [NSMutableArray array];
    UIView *preView = nil;
    CGFloat wh = self.scroll.height/1.2;
    CGFloat x = (self.scroll.width - wh)*0.5;
    CGFloat y = 0;
    for (int i = 0; i < self.dataArray.count; i++) {
        if (preView) {
            x = CGRectGetMaxX(preView.frame) + 50;
        }
        CellView *view = [[CellView alloc] initWithFrame:CGRectMake(x, y, wh, wh)];
        view.backgroundColor = [UIColor redColor];
        view.tag = i+1;
        view.index = i;
        [self.scroll addSubview:view];
        view.centerY = self.scroll.height*0.5;
        [viewArr addObject:view];
        if (!i) {
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            animation.fromValue = @(1.2);
            animation.toValue = @(1.2);
            animation.removedOnCompletion = NO;
            animation.fillMode = @"forwards";
            [view.layer addAnimation:animation forKey:@"scale_key"];
            view.scale = 1.2;
        } else {
            view.scale = 1;
        }
        preView = view;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellClick:)];
        [view addGestureRecognizer:tap];
    }
    CGFloat maxX = CGRectGetMaxX(preView.frame) + (self.scroll.width - wh)*0.5;
    [self.scroll setContentSize:CGSizeMake(maxX, self.scroll.height)];
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    if (dataArray.count > 0) {
        [self reloadUI];
    }
//    [AlertManager popAlert:self withName:@"scaleScrollView"];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    for (UIView *view in self.scroll.subviews) {
        if ([view isKindOfClass:[CellView class]]) {
            CellView *cell = (CellView *)view;
            CGRect rect = [self.scroll convertRect:cell.frame toView:self];
            CGFloat viewCenX = rect.origin.x+rect.size.width*0.5;
            
            CGFloat offset = ABS(viewCenX - self.scroll.width*0.5);
            
            if (offset > maxOffset) {
                continue;
            }
            CGFloat scale = 1 + (0.2 - 0.2/(maxOffset) * offset);
            [cell.layer removeAllAnimations];
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            animation.fromValue = @(cell.scale);
            animation.toValue = @(scale);
            animation.removedOnCompletion = NO;
            animation.fillMode = @"forwards";
            [cell.layer addAnimation:animation forKey:@"scale_key"];
            cell.scale = scale;
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    for (UIView *view in self.scroll.subviews) {
        if ([view isKindOfClass:[CellView class]]) {
            CellView *cell = (CellView *)view;
            CGRect rect = [self.scroll convertRect:cell.frame toView:self];
            CGFloat viewCenX = rect.origin.x+rect.size.width*0.5;
            
            CGFloat offset = ABS(viewCenX - self.scroll.width*0.5);
            
            if (offset > maxOffset) {
                continue;
            }
            
            
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}

- (void)cellClick:(UITapGestureRecognizer *)tap {
    CellView *cell = (CellView *)tap.view;
    NSLog(@"%d",cell.index);
}

- (void)closeClick {
    [self removeFromSuperview];
}

@end
