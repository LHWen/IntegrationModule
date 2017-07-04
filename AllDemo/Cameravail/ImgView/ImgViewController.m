//
//  ImgViewController.m
//  AllDemo
//
//  Created by yuhui on 17/2/8.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "ImgViewController.h"
//#import "UIImage+ImageRotate.h"   // 图片旋转
//#import "UIImage+ImageCut.h"      // 图片剪切
//#import "UIImage+ImageScale.h"    // 缩放+等比例缩放
//#import "UIImage+ImageWaterPrint.h" // 水印

#import "UIImage+ImageCircle.h"   // 剪切出一个圆形图
#import "UIImage+ImageOperationTool.h"

#import "UIView+ImageScreenShot.h" // 屏幕拍照 截屏

@interface ImgViewController ()

@property (nonatomic, strong) UIImageView *imgView; // 放原来图片
@property (nonatomic, strong) UIImageView *imgViewRotate; // 旋转后的图片
@property (nonatomic, strong) UIImageView *imgViewCut;    // 剪切后的图片
@property (nonatomic, strong) UIImageView *imgViewCircle; // 圆形图

@end

@implementation ImgViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Image";
    self.view.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
    
    [self p_setupImageViewOfPhoto];
    [self imageTestRotate];     // 旋转
    [self imageTestCut];        // 剪切
    [self imageTestCircle];     // 剪切圆形图
//    [self imageTestScale];      // 正常放缩 和 等比例放缩 图片保存到相册
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor greenColor];
    [button setTitle:@"截屏按钮" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(screenShot) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(26);
    }];
}

// 测试图片旋转 + 水印
- (void)imageTestRotate {
    UIImage *image = [UIImage imageNamed:@"radial_tracers.jpg"];
    UIImage *imageNew = [image imageRotateIndegree:45 * 0.01745];  // 3.14/180

    UIImage *imageWarte = [image imageWater:nil waterString:@"L_HWen"];  // 水印
    
//    UIImageWriteToSavedPhotosAlbum(imageNew, nil, nil, nil);  // 图片保存到相册
    _imgView.image = imageWarte;
    _imgViewRotate.image = imageNew;
}

// 测试图片剪切
- (void)imageTestCut {
    
    UIImage *image = [UIImage imageNamed:@"radial_tracers.jpg"];
    UIImage *newImage = [image imageCutSize:CGRectMake(220, 60, 600, 300)];
    
    _imgViewCut.image = newImage;
}

// 测试剪切一个圆形图
- (void)imageTestCircle {
    UIImage *image = [UIImage imageNamed:@"radial_tracers.jpg"];
    UIImage *newImage = [image imageClipCircle];
    
//     UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil);
    _imgViewCircle.image = newImage;
}

// 测试放缩
- (void)imageTestScale {
    UIImage *image = [UIImage imageNamed:@"radial_tracers.jpg"];
    UIImage *scaleImage = [image imageScaleSize:CGSizeMake(200, 300)];
//    UIImage *equalImage = [image imageScaleMinProportionSize:CGSizeMake(700, 300)];

    UIImageWriteToSavedPhotosAlbum(scaleImage, nil, nil, nil);
//    UIImageWriteToSavedPhotosAlbum(equalImage, nil, nil, nil);
}

// 截屏
- (void)screenShot {
    UIImage *newImage = [self.view imageScreenShot];
    UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil);
}

- (void)p_setupImageViewOfPhoto {
    
    _imgView = [[UIImageView alloc] init];
    _imgView.backgroundColor = [UIColor orangeColor];
    _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(160);
    }];
    
    _imgViewRotate = [[UIImageView alloc] init];
    _imgViewRotate.backgroundColor = [UIColor greenColor];
    _imgViewRotate.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:_imgViewRotate];
    [_imgViewRotate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imgView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_offset(-(kSCREENWIDTH/2));
        make.bottom.mas_equalTo(-140);
    }];
    
    _imgViewCut = [[UIImageView alloc] init];
    _imgViewCut.backgroundColor = [UIColor blueColor];
    _imgViewCut.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imgViewCut];
    [_imgViewCut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imgView.mas_bottom);
        make.left.equalTo(_imgViewRotate.mas_right).offset(10);
        make.right.mas_offset(-10);
        make.height.mas_equalTo(140);
    }];
    
    _imgViewCircle = [[UIImageView alloc] init];
    _imgViewCircle.backgroundColor = [UIColor orangeColor];
    _imgViewCircle.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_imgViewCircle];
    [_imgViewCircle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imgViewRotate.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.equalTo(_imgViewRotate.mas_right);
        make.bottom.mas_equalTo(0);
    }];

    
    
}
@end
