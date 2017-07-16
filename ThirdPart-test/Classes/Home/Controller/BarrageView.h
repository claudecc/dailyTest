//
//  BarrageView.h
//  ThirdPart-test
//
//  Created by 蔡晓东 on 2017/7/16.
//  Copyright © 2017年 caixiaodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarrageView : UIView

@property (nonatomic, assign) NSInteger maxNum;
- (void)receiveMsg:(NSString *)msg;

@end
