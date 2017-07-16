//
//  HomeVC.m
//  ThirdPart-test
//
//  Created by caixiaodong on 2017/6/23.
//  Copyright © 2017年 caixiaodong. All rights reserved.
//

#import "HomeVC.h"
#import "UIImage+GIF.h"

@interface HomeVC ()<YYTextViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self setup];
}

- (void)setup {
    self.tableView.backgroundColor = [UIColor whiteColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"home_cell_id"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"home_cell_id"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    Class class = NSClassFromString(self.dataArray[indexPath.row]);
    if (!class) {
        return;
    }
    UIViewController *vc = [[class alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"BarrageVC"];
    }
    return _dataArray;
}

- (void)setupAnimation {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(40, 40, 40, 40)];
    view.layer.cornerRadius = 20;
    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(80, 200, 40, 40)];
    view2.layer.cornerRadius = 20;
    view2.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view2];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 40, 40, 40);
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(animationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)animationBtnClick:(UIButton *)btn {
    
}

- (void)createYYLabel {
    
    NSAttributedString *text = @"熟练度空间发了多少就是快递费进口水果看了几个绿山咖啡绿色会计法离开的就是疯狂倒计时就死定了收割机手机都是看风景多少了房间打扫房间都是看风景都是看风景绿色减肥都市客积分代理商积分独立思考积分的快速减肥代理商看风景路上风景独立思考积分";
    CGSize size = CGSizeMake(100, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:text];
    
    YYLabel *label2 = [YYLabel new];
    [self.view addSubview:label2];
    label2.backgroundColor = [UIColor lightGrayColor];
    label2.numberOfLines = 0;
    
    
                   
}

- (void)createYYTextView {
    NSMutableDictionary *mapper = [NSMutableDictionary new];
    mapper[@":boy:"] = [self imageWithName:@"little_boy"];
    YYTextSimpleEmoticonParser *parser = [YYTextSimpleEmoticonParser new];
    parser.emoticonMapper = mapper;
    
    YYTextLinePositionSimpleModifier *mod = [YYTextLinePositionSimpleModifier new];
    mod.fixedLineHeight = 22;
    
    YYTextView *textView = [YYTextView new];
    textView.text = @":boy: hahaha : + boy + : ";
    textView.font = [UIFont systemFontOfSize:17];
    textView.textParser = parser;
    textView.frame = self.view.frame;
    textView.linePositionModifier = mod;
    textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    textView.delegate = self;
    textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    textView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    textView.scrollIndicatorInsets = textView.contentInset;
    [self.view addSubview:textView];
}

- (UIImage *)imageWithName:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    YYImage *image = [YYImage imageWithData:data scale:2];
    return image;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    int x = point.x;
    int y = point.y;
    //    UITouch *touch = [touches anyObject];
    //    CGPoint touchPoint = [touch locationInView:self.view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
