//
//  RecordingVideoController.m
//  AllDemo
//
//  Created by yuhui on 17/2/7.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "RecordingVideoController.h"
#import <MobileCoreServices/MobileCoreServices.h>    // 相机使用需要引用的头文件
#import <MediaPlayer/MPMoviePlayerViewController.h>  // 视频需要引用的头文件
#import <MediaPlayer/MPMoviePlayerController.h>      // 视频需要引用的头文件
#import <AssetsLibrary/AssetsLibrary.h>

@interface RecordingVideoController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation RecordingVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.title = @"录制视频";
    self.view.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
    
    /** 
     * 1. 检查相机是否可用
     * 2. 配置UIImagePickerController
     */
    [self configImagePickerController];
    
}

// 配置UIImagePickerController
- (void)configImagePickerController {
    
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    // 类型 media movie
    NSString *requireMediaType = (__bridge NSString *)kUTTypeMovie;
    controller.mediaTypes = [[NSArray alloc] initWithObjects:requireMediaType, nil];
    controller.delegate = self;     // 代理方法
    controller.videoQuality = UIImagePickerControllerQualityTypeHigh; // 视频质量
    controller.videoMaximumDuration = 10.0;  // 最大录制时间
    
    [self.navigationController presentViewController:controller animated:YES completion:nil];
}

#pragma mark -- UIImagePickerControllerDelegate
// info  1.type  2.image/video  3.附加信息
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    MPMoviePlayerViewController *movieController;  // 创建一个视频实例
    // 判断媒体类型 是否是video
    if ([type isEqualToString:(__bridge NSString*)kUTTypeMovie]) {
        NSDictionary *dict = [info objectForKey:UIImagePickerControllerMediaMetadata]; // 附加信息
        NSURL *urlVideo = [info objectForKey:UIImagePickerControllerMediaURL];         // 获取播放地址
        NSLog(@"urlVideo = %@", urlVideo);
        NSLog(@"mediaMetadata dict = %@", dict);
        
        // 保存视频
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library writeVideoAtPathToSavedPhotosAlbum:urlVideo completionBlock:^(NSURL *assetURL, NSError *error) {
            if (error == nil) {
                NSLog(@"视频保存成功");
            }else {
                NSLog(@"视频保存失败 error=%@", error);
            }
        }];
        
        // 播放视频配置
        movieController = [[MPMoviePlayerViewController alloc] initWithContentURL:urlVideo];
        movieController.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;      // 播放模式 类型选择
        movieController.moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
        
        [picker dismissViewControllerAnimated:YES completion:^{
            [self presentMoviePlayerViewControllerAnimated:movieController];
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
