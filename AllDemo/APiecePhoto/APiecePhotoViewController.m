//
//  APiecePhotoViewController.m
//  AllDemo
//
//  Created by yuhui on 16/12/27.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import "APiecePhotoViewController.h"

@interface APiecePhotoViewController () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation APiecePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"单张";
    self.view.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
    
    UIButton *button = ({
        UIButton *button       = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame           = CGRectMake(20, 30, 100, 40);
        button.backgroundColor = [UIColor greenColor];
        [button setTitle:@"选择照片" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(choosePhoto:) forControlEvents:UIControlEventTouchUpInside];
        
        button;
    });
    
    [self.view addSubview:button];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 90, kSCREENWIDTH-40, kSCREENHEIGHT - 64 - 100)];
    [self.view addSubview:_imageView];
}

- (void)choosePhoto:(UIButton *)button {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择上传照片方式"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"相册", @"相机", nil];
    
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:{
//            NSLog(@"相册");
            [self setImageFromIpckerControllerType:UIImagePickerControllerSourceTypePhotoLibrary];
            break;
        }
        case 1:{
//            NSLog(@"相机");
            [self setImageFromIpckerControllerType:UIImagePickerControllerSourceTypeCamera];
            break;
        }

            
        default:
            break;
    }
}

- (void)setImageFromIpckerControllerType:(UIImagePickerControllerSourceType)type{
    // 1.判断相册是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        return;
    }
    
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    /**
     typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
     UIImagePickerControllerSourceTypePhotoLibrary, // 相册
     UIImagePickerControllerSourceTypeCamera, // 用相机拍摄获取
     UIImagePickerControllerSourceTypeSavedPhotosAlbum // 相簿
     }
     */
    // 3. 设置打开照片相册类型(显示所有相簿)
    imgPicker.sourceType = type;
    // 4.设置代理
    imgPicker.delegate = self;
    // 5.modal出这个控制器
    [self presentViewController:imgPicker animated:YES completion:nil];
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- <UIImagePickerControllerDelegate>--
// 获取图片后的操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    // 设置图片
    _imageView.image = info[UIImagePickerControllerOriginalImage];
}





@end
