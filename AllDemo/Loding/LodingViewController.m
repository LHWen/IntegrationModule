//
//  LodingViewController.m
//  AllDemo
//
//  Created by yuhui on 16/12/28.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import "LodingViewController.h"


//--------加载视图动画------------

@interface LodingViewController ()

@end

@implementation LodingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"加载视图";
    self.view.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
    
    UIButton *btnLoding = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLoding.frame = CGRectMake(60, 130, 120, 40);
    btnLoding.backgroundColor = [UIColor greenColor];
    [btnLoding setTitle:@"Loding..." forState:UIControlStateNormal];
    [btnLoding setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnLoding addTarget:self action:@selector(showLoding) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLoding];
    
}

- (void)showLoding {
    
    [HWActivityIndicator hw_showLoadingViewController:self];
    
    //延迟操作
    double delayInSeconds = 3.0f;
    
    dispatch_time_t dismissTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(dismissTime, dispatch_get_main_queue(), ^{
        // 模拟请求成功后 加载视图消失
        [HWActivityIndicator hw_dismissLoadingViewController:self];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
