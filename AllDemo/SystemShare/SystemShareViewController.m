//
//  SystemShareViewController.m
//  AllDemo
//
//  Created by LHWen on 2017/7/3.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "SystemShareViewController.h"
#import "SystemShareHelper.h"
#import "Masonry.h"

@interface SystemShareViewController ()

@property (nonatomic, strong) NSArray<UIImage*> *shareImageArr;

@end

@implementation SystemShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"系统分享图片";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *img0 = [UIImage imageNamed:@"share1"];
    UIImage *img1 = [UIImage imageNamed:@"share3"];
    UIImage *img2 = [UIImage imageNamed:@"share2"];
    
    _shareImageArr = @[img0, img1, img2];
    
    UIButton *weChartShare = [UIButton buttonWithType:UIButtonTypeCustom];
    [weChartShare setTitle:@"微信分享" forState:UIControlStateNormal];
    weChartShare.frame  = CGRectMake(20, 60, 100, 40);
    weChartShare.backgroundColor = [UIColor greenColor];
    [weChartShare addTarget:self action:@selector(weChartShare:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weChartShare];
    
    UIButton *qqShare = [UIButton buttonWithType:UIButtonTypeCustom];
    [qqShare setTitle:@"QQ分享" forState:UIControlStateNormal];
    qqShare.frame  = CGRectMake(140, 60, 100, 40);
    qqShare.backgroundColor = [UIColor greenColor];
    [qqShare addTarget:self action:@selector(qqShare:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qqShare];
    
    UIButton *sinaShare = [UIButton buttonWithType:UIButtonTypeCustom];
    [sinaShare setTitle:@"微博分享" forState:UIControlStateNormal];
    sinaShare.frame  = CGRectMake(20, 120, 100, 40);
    sinaShare.backgroundColor = [UIColor greenColor];
    [sinaShare addTarget:self action:@selector(sinaShare:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sinaShare];
    
    UIButton *otherShare = [UIButton buttonWithType:UIButtonTypeCustom];
    [otherShare setTitle:@"系统分享" forState:UIControlStateNormal];
    otherShare.frame  = CGRectMake(140, 120, 100, 40);
    otherShare.backgroundColor = [UIColor greenColor];
    [otherShare addTarget:self action:@selector(otherShare:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:otherShare];
}

- (void)weChartShare:(UIButton *)sender {
    
    NSURL *url = [[NSURL alloc] initWithString:@"https://my.oschina.net/u/2360054/blog/717203"];
    
    [SystemShareHelper shareWithType:SystemShareHelperTypeWeChat andController:self andItems:@[url]];
}

- (void)qqShare:(UIButton *)sender {
    
    [SystemShareHelper shareWithType:SystemShareHelperTypeQQ andController:self andItems:_shareImageArr];
}

- (void)sinaShare:(UIButton *)sender {
    
    [SystemShareHelper shareWithType:SystemShareHelperTypeSina andController:self andItems:_shareImageArr];
}

- (void)otherShare:(UIButton *)sender {
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"TestPDF" ofType:@"pdf"];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Testtxt" ofType:@"txt"];
    
//    word docx Excel xlsx 文件无法使用地址分享
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"TestExcel" ofType:@"xlsx"];
    
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    NSArray *fileArr = @[fileURL];
    
    [SystemShareHelper shareWithType:SystemShareHelperTypeOther andController:self andItems:fileArr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
