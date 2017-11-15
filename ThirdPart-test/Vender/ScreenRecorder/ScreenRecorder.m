//
//  ScreenRecorder.m
//  CatchDoll
//
//  Created by caixiaodong on 2017/11/13.
//  Copyright © 2017年 tangdanfeng. All rights reserved.
//

#import "ScreenRecorder.h"
#import <ReplayKit/ReplayKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ScreenRecorder()<RPScreenRecorderDelegate,RPPreviewViewControllerDelegate>
{
    BOOL isSave;
}
@property (nonatomic, assign) BOOL isRecording;
@property (nonatomic, strong) RPPreviewViewController *RPPreview;

@end

@implementation ScreenRecorder

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static ScreenRecorder *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        if ([self isHighVersion]) {
            [self highVersionInit];
        } else {
            [self lowVersionInit];
        }
    }
    return self;
}
// AVAssetWriter init
- (void)lowVersionInit {
    
}
// ReplayKit init
- (void)highVersionInit {
    
}

- (void)startRecoder {
    if ([self isHighVersion]) {
        [self replayStartRecoder];
    }
}

#pragma mark - ReplayKit
// replay 待实现 读取相册视频
//开始录屏
- (void)replayStartRecoder
{
    //将开启录屏功能的代码放在主线程执行
    dispatch_async(dispatch_get_main_queue(), ^{
        //这是录屏的类
        RPScreenRecorder* recorder = RPScreenRecorder.sharedRecorder;
        recorder.delegate = self;
        __weak typeof (self)weakSelf = self;
        
        //在此可以设置是否允许麦克风（传YES即是使用麦克风，传NO则不是用麦克风）
        recorder.microphoneEnabled = NO;
        //            recorder.cameraEnabled = YES;
        
        //开起录屏功能
        [recorder startRecordingWithHandler:^(NSError * _Nullable error) {
            
            if (error) {
                DLog(@"录屏失败");
                [MyTool showToastWithStr:@"录屏失败"];
                weakSelf.isRecording = NO;
                NSLog(@"========%@",error.description);
            } else {
                if (recorder.recording) {
                    DLog(@"正在录屏");
                    [MyTool showToastWithStr:@"正在录屏"];
                    weakSelf.isRecording = YES;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [weakSelf replayStopDecoder];
                    });
                }
            }
        }];
    });
    
}

//结束录屏
- (void)replayStopDecoder
{
    __weak typeof (self)weakSelf = self;
    [[RPScreenRecorder sharedRecorder] stopRecordingWithHandler:^(RPPreviewViewController *previewViewController, NSError *  error){
        _RPPreview = previewViewController;
        if (error) {
            NSLog(@"这里关闭有误%@",error.description);
        } else {
            DLog(@"录屏关闭");
            [_RPPreview setPreviewControllerDelegate:self];
            weakSelf.isRecording = NO;
            //在结束录屏时显示预览画面
            [weakSelf showVideoPreviewController:_RPPreview withAnimation:YES];
        }
    }];
}

//显示视频预览页面,animation=是否要动画显示
- (void)showVideoPreviewController:(RPPreviewViewController *)previewController withAnimation:(BOOL)animation {
    UIViewController *curVC = [[VCManager shareVCManager] getTopViewController];
    __weak typeof (UIViewController*) weakVC = curVC;
    //UI需要放到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        CGRect rect = previewController.view.frame;
        if (animation) {
            rect.origin.x += rect.size.width;
            previewController.view.frame = rect;
            rect.origin.x -= rect.size.width;
            [UIView animateWithDuration:0.3 animations:^(){
                previewController.view.frame = rect;
            } completion:^(BOOL finished){
            }];
        } else {
            previewController.view.frame = rect;
        }
        
        [weakVC.view addSubview:previewController.view];
        [weakVC addChildViewController:previewController];
    });
}

//关闭视频预览页面，animation=是否要动画显示
- (void)hideVideoPreviewController:(RPPreviewViewController *)previewController withAnimation:(BOOL)animation {
    //UI需要放到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        CGRect rect = previewController.view.frame;
        if (animation) {
            rect.origin.x += rect.size.width;
            [UIView animateWithDuration:0.3 animations:^(){
                previewController.view.frame = rect;
            } completion:^(BOOL finished){
                
                //移除页面
                [previewController.view removeFromSuperview];
                [previewController removeFromParentViewController];
            }];
        } else {
            //移除页面
            [previewController.view removeFromSuperview];
            [previewController removeFromParentViewController];
        }
    });
}

#pragma mark -RPPreviewViewControllerDelegate
//关闭的回调
- (void)previewControllerDidFinish:(RPPreviewViewController *)previewController {
    if (isSave == 1) {
        //这个地方我添加了一个延时,我发现这样保存不到系统相册的情况好多了
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideVideoPreviewController:_RPPreview withAnimation:YES];
        });
        
        isSave = 0;
    }else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertAction *queding = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self hideVideoPreviewController:_RPPreview withAnimation:YES];
                //                dispatch_async(dispatch_get_main_queue(), ^{
                //                                [weakSelf.RPPreview dismissViewControllerAnimated:YES completion:nil];
                //                            });
                isSave = 0;
            }];
            UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"录制未保存\n确定要取消吗" preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:actionCancel];
            [alert addAction:queding];
            UIViewController *curVC = [[VCManager shareVCManager] getTopViewController];
            [curVC presentViewController:alert animated:NO completion:nil];
        });
    }
}
//选择了某些功能的回调（如分享和保存）
- (void)previewController:(RPPreviewViewController *)previewController didFinishWithActivityTypes:(NSSet <NSString *> *)activityTypes {
    if ([activityTypes containsObject:@"com.apple.UIKit.activity.SaveToCameraRoll"]) {
        isSave = 1;
        NSLog(@"***************************");
        //这个地方我延时执行,等预览画面移除后再显示提示框
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [MyTool showToastWithStr:@"已经保存到系统相册"];
            });
        });
    }
    if ([activityTypes containsObject:@"com.apple.UIKit.activity.CopyToPasteboard"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MyTool showToastWithStr:@"已经复制到粘贴板"];
        });
    }
}

#pragma mark ====RPScreenDelegate===
- (void)screenRecorderDidChangeAvailability:(RPScreenRecorder *)screenRecorder
{
    NSLog(@" delegate ======%@",screenRecorder);
}

- (void)screenRecorder:(RPScreenRecorder *)screenRecorder didStopRecordingWithError:(NSError *)error previewViewController:(nullable RPPreviewViewController *)previewViewController
{
    [_RPPreview setPreviewControllerDelegate:self];
    self.isRecording = NO;
    [self showVideoPreviewController:_RPPreview withAnimation:YES];
}

- (BOOL)isHighVersion {
    // 判断软、硬件是否支持ReplayKit
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0 && [[RPScreenRecorder sharedRecorder] isAvailable]) {
        return YES;
    } else {
        return NO;
    }
}

@end
