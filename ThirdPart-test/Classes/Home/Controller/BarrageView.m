//
//  BarrageView.m
//  ThirdPart-test
//
//  Created by 蔡晓东 on 2017/7/16.
//  Copyright © 2017年 caixiaodong. All rights reserved.
//

#import "BarrageView.h"

@interface BarrageView ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) NSMutableArray *msgArray;

@end

@implementation BarrageView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    CGFloat interfaceX = 40;
    CGFloat interfaceY = self.height - 64 - 100;
    UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectMake(interfaceX, interfaceY, 30, 30)];
    [self addSubview:switchView];
    switchView.on = YES;
    [switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    
    interfaceX = CGRectGetMaxX(switchView.frame) + 20;
    CGFloat textW = self.width - 2*interfaceX;
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(interfaceX, interfaceY, textW, 30)];
    [self addSubview:textField];
    textField.placeholder = @"请输入文字";
//    textField.layer.cornerRadius = 15;
//    textField.layer.borderWidth = 1;
//    textField.layer.borderColor = [UIColor blackColor].CGColor;
    textField.clearsOnBeginEditing = YES;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    
    interfaceX = CGRectGetMaxX(textField.frame) + 20;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(interfaceX, interfaceY, 60, 30)];
    [self addSubview:btn];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor whiteColor];
    btn.layer.cornerRadius = 15;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, interfaceY)];
    [self addSubview:bgView];
    self.bgView = bgView;
    bgView.layer.masksToBounds = YES;
    
    self.maxNum = 20;
}

- (void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        self.bgView.hidden = NO;
    }else {
        self.bgView.hidden = YES;
    }
}

- (void)btnClick:(UIButton *)btn {
    [MyTool showToastWithStr:@"发送"];
}

- (void)receiveMsg:(NSString *)msg {
    if (![msg isKindOfClass:[NSString class]]) {
        return;
    }
    if (self.msgArray.count > self.maxNum) {
        return;
    }
    [self.msgArray addObject:msg];
    
    UIFont *font = [UIFont systemFontOfSize:10];
    
    
    
    
}

- (NSMutableArray *)msgArray {
    if (!_msgArray) {
        _msgArray = [NSMutableArray array];
    }
    return _msgArray;
}

@end
