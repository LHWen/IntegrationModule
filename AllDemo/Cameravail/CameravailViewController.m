//
//  CameravailViewController.m
//  AllDemo
//
//  Created by yuhui on 17/2/6.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "CameravailViewController.h"

@interface CameravailViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImageView *imagePhoto;

@end

@implementation CameravailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"相机使用";
    self.view.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
    
    // 检测相机的基本属性
//    [self checkCameravailBaseAttribute];
    
    // 检测当前相机是否可用
    
    // 配置UIImagePickerController
    [self configImagePickerController];
    [self p_setupImageViewOfPhoto];
    
}

- (void)p_setupImageViewOfPhoto {
    
    _imagePhoto = [[UIImageView alloc] init];
    _imagePhoto.backgroundColor = [UIColor clearColor];
    _imagePhoto.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_imagePhoto];
    [_imagePhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(210);
    }];
}

- (void)configImagePickerController {
    
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    // 配置媒体类型
    NSString *requireMediaType = (__bridge NSString *)kUTTypeImage;
    controller.mediaTypes = [[NSArray alloc] initWithObjects:requireMediaType, nil];
    controller.delegate = self;
    controller.allowsEditing = NO;  // 是否可以编辑
    controller.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn; // 闪光灯配置  打开闪光灯模式
    
    [self.navigationController presentViewController:controller animated:YES completion:nil];
    
    /** **************************  选择照片 功能 ******************************
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;     // 选择照片
    // 配置媒体类型
    NSString *requireMediaType = (__bridge NSString *)kUTTypeImage;
    controller.mediaTypes = [[NSArray alloc] initWithObjects:requireMediaType, nil];
    controller.delegate = self;
    
    [self.navigationController presentViewController:controller animated:YES completion:nil];
     *********************** 选择照片 与拍摄照片 配置类似 代理方法一致 *************/
}

#pragma mark - PickerControllerDelegate 
// 拍照完成后的回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    // 判断媒体类型 是否是照片
    if ([mediaType isEqualToString:(__bridge NSString*)kUTTypeImage]) {
        // 获得拍照图片
        UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
        _imagePhoto.image = img;
        
        // 保存图片
        SEL saveImage = @selector(imageWasSaveSuccessfully:didFinishSavingWithError:contextInfo:);
        UIImageWriteToSavedPhotosAlbum(img, self, saveImage, nil);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// 保存图片是否成功方法
- (void)imageWasSaveSuccessfully:(UIImage *)paraImage didFinishSavingWithError:(NSError *)paraError contextInfo:(void *)paraInfo {
    
    if (paraError == nil) {
        NSLog(@"图片保存成功");
    }else {
        NSLog(@"图片保存不成功");
    }
}

// -------------------- 检测相机的基本属性 start -------------------------
#pragma mark -- 对相机的基本属性检查
- (void)checkCameravailBaseAttribute {
    
    // 检查当前相机可用
    if ([self isCameravail]) {
        NSLog(@"相机可用");
    }else {
        NSLog(@"相机不可用");
    }
    
    // 检查当前 前置闪光灯是否可用
    if ([self isCameraFlashavailFront]) {
        NSLog(@"前置闪光灯可用");
    }else {
        NSLog(@"前置闪光灯不可用");
    }
    
    // 检查当前 后置闪光灯是否可用
    if ([self isCameraFlashavailRear]) {
        NSLog(@"后置闪光灯可用");
    }else {
        NSLog(@"后置闪光灯不可用");
    }
    
    // 检查 前置摄像头是否可用
    if ([self isCameravailFront]) {
        NSLog(@"前置摄像头可用");
    }else {
        NSLog(@"前置摄像头不可用");
    }
    
    // 检查 后置摄像头是否可用
    if ([self isCameravailRear]) {
        NSLog(@"后置摄像头可用");
    }else {
        NSLog(@"后置摄像头不可用");
    }
    
    // 检查当前camera支持的媒体类型 ： iamge video
    if ([self cameraSupportMedia:(__bridge NSString *)kUTTypeImage]) {
        NSLog(@"支持 拍照");
    }else {
        NSLog(@"不支持 拍照");
    }
    
    if ([self cameraSupportMedia:(__bridge NSString *)kUTTypeMovie]) {
        NSLog(@"支持 录像");
    }else {
        NSLog(@"不支持 录像");
    }

}

// 检测相机是否可用
- (BOOL)isCameravail {
    
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

// 检测前置 闪光灯是否可用
- (BOOL)isCameraFlashavailFront {
    
    return [UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceFront];
}

// 检测后置摄像头是否可用
- (BOOL)isCameraFlashavailRear {
    
    return [UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceRear];
}

// 检测前置摄像头是否可用
- (BOOL)isCameravailFront {
    
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

// 检测后置摄像头是否可用
- (BOOL)isCameravailRear {
    
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

// 检查是否支持拍照录像功能
- (BOOL)cameraSupportMedia:(NSString *)paraMediaType {
    
    NSArray *avaiableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    
    for (NSString *item in avaiableMedia) {
        if ([item isEqualToString:paraMediaType]) {
            return YES;
        }
    }
    return NO;
}
// -------------------- 检测相机的基本属性 End -------------------------

@end
