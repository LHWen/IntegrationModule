//
//  EditorVideoController.m
//  AllDemo
//
//  Created by yuhui on 17/2/7.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "EditorVideoController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>

/**
 *  对视频进行编辑保存
 */

@interface EditorVideoController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIVideoEditorControllerDelegate>

@end

@implementation EditorVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.title = @"编辑视频";
    self.view.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
    
    // 将本地视频保存到相册的方法
//    NSURL *url = [[NSBundle mainBundle]URLForResource:@"video1" withExtension:@"mp4"];
//    // 将视频保存到相册中
//    ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];
//    [lib writeVideoAtPathToSavedPhotosAlbum:url completionBlock:^(NSURL *assetURL, NSError *error) {
//        if (error != nil) {
//            NSLog(@"error = %@", error);
//        }else {
//            NSLog(@"save success!");
//        }
//    }];
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    NSArray *mediaTypes = [[NSArray alloc] initWithObjects:(__bridge NSString *)kUTTypeMovie, nil];
    imagePicker.mediaTypes = mediaTypes;
    imagePicker.delegate = self;
    [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark -- UIImagePickerControllerDelegate
// info  1.type  2.image/video  3.附加信息
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    __block NSURL *urlVideo = nil;
    if ([mediaType isEqualToString:(__bridge NSString *)kUTTypeMovie]) {
        urlVideo = [info objectForKey:UIImagePickerControllerMediaURL];
    }
    
    // 隐藏原来的界面
    [picker dismissViewControllerAnimated:YES completion:^{
        // progress Video  处理视频
        if (urlVideo != nil) {
            NSString *videoString = [urlVideo path];
            if ([UIVideoEditorController canEditVideoAtPath:videoString]) {
                UIVideoEditorController *videoEditor = [[UIVideoEditorController alloc] init];
                videoEditor.delegate = self;
                videoEditor.videoPath = videoString;
                [self.navigationController presentViewController:videoEditor animated:YES completion:^{
                    // 编辑完成
                }];
                videoString = nil;
            }
        }else {
            NSLog(@"当前路径下的资源不可编辑!");
        }

    }];

}


#pragma mark -- UIVideoEditorControllerDelegate
// 编辑成功
- (void)videoEditorController:(UIVideoEditorController *)editor didSaveEditedVideoToPath:(NSString *)editedVideoPath {
    
    NSLog(@"editedVideoPath=%@", editedVideoPath);
    [editor dismissViewControllerAnimated:YES completion:nil];
}

// 编辑失败
- (void)videoEditorController:(UIVideoEditorController *)editor didFailWithError:(NSError *)error {
    
}

// 放弃编辑
- (void)videoEditorControllerDidCancel:(UIVideoEditorController *)editor {
    
    [editor dismissViewControllerAnimated:YES completion:nil];
}

@end
