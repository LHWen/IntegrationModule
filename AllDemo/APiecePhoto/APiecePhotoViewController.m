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
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    // 设置图片
    _imageView.image = image;
    
    
    // 以下对图片进行水印处理并保存到相机
//    UIImage *wImg = [self watermarkImage:info[UIImagePickerControllerOriginalImage] withName:@"20190522"];
//    _imageView.image = wImg;
//    
//    NSString *mediaType = info[@"UIImagePickerControllerMediaType"];
//    NSLog(@"%@",mediaType);
//    if ([mediaType isEqualToString:@"public.image"]) {  //判断是否为图片
//        
//        //通过判断picker的sourceType，如果是拍照则保存到相册去
//        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                UIImageWriteToSavedPhotosAlbum(wImg, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
//            });
//        }
//    }
}


//此方法就在UIImageWriteToSavedPhotosAlbum的上方
// 指定回调方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功";
    }
    NSLog(@"%@", msg);
}

#pragma mark -- 给图片添加水印
- (UIImage *)watermarkImage:(UIImage *)img withName:(NSString *)name {
    
    NSString *mark = name;
    int w = img.size.width;
    int h = img.size.height;
    UIGraphicsBeginImageContext(img.size);
    [img drawInRect:CGRectMake(0, 0, w, h)];
    
    NSDictionary *attr = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:110],   //设置字体
                           NSForegroundColorAttributeName : [[UIColor lightGrayColor] colorWithAlphaComponent:0.8]     //设置字体颜色
                           };
    
//    [mark drawInRect:CGRectMake(0, 10, 280, 32) withAttributes:attr];                 //左上角
//    [mark drawInRect:CGRectMake(w - 80, 10, 80, 32) withAttributes:attr];            //右上角
//    [mark drawInRect:CGRectMake(w - 80, h - 32 - 10, 80, 32) withAttributes:attr];   //右下角
    [mark drawInRect:CGRectMake(10, h - 320, 500, 32) withAttributes:attr];        //左下角
    
    UIImage *aimg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return aimg;
}


@end
