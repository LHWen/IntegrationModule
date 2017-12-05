//
//  QRImageViewController.m
//  AllDemo
//
//  Created by LHWen on 2017/9/4.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "QRImageViewController.h"
#import "CreatQRImage.h"

@interface QRImageViewController ()

@property (nonatomic, strong) UIImageView *dimensionalCodeImage;  // 二维码图片

@end

@implementation QRImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"生成二维码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *qrImage = [CreatQRImage qrImageForString:@"http://www.baidu.com" imageSize:(kSCREENWIDTH / 2.0f) logoImageSize:0.0f];
//    UIImage *qrImage = [CreatQRImage qrCodeString:@"http://www.baidu.com"];
    
//    UIImage *hbImage = [CreatQRImage qrCodeString:@"http://www.baidu.com"];
//    UIImage *qrImage = [CreatQRImage imageBlackToTransparent:hbImage withRed:0.3 andGreen:066 andBlue:0.2];
    
//    UIImage *qrImage = [CreatQRImage colorQrcodeImage];
    
    [self p_setupImageWithImage:qrImage];
}

// 二维码图片设置
- (void)p_setupImageWithImage:(UIImage *)image {
    
    if (!_dimensionalCodeImage) {
        _dimensionalCodeImage = [[UIImageView alloc] init];
        _dimensionalCodeImage.image = image;
        _dimensionalCodeImage.contentMode = UIViewContentModeScaleToFill;
        [self.view addSubview:_dimensionalCodeImage];
        [_dimensionalCodeImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.centerY.equalTo(self.view.mas_centerY);
            make.size.equalTo(@(kSCREENWIDTH / 2.0f));
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
