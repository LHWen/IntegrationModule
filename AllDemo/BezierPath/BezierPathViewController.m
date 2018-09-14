//
//  BezierPathViewController.m
//  AllDemo
//
//  Created by LHWen on 2018/9/14.
//  Copyright © 2018年 yuhui. All rights reserved.
//

#import "BezierPathViewController.h"
#import "BMessageView.h"
#import "LeftBMessageView.h"
#import "ImageTextView.h"
#import "PieCharView.h"
#import "PieItemModel.h"

@interface BezierPathViewController ()

@end

@implementation BezierPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"BezierPath";
    self.view.backgroundColor = [UIColor whiteColor];
    
    LeftBMessageView *lBView = [[LeftBMessageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    lBView.backgroundColor = [UIColor whiteColor];
    lBView.message = @"在吗？";
    [self.view addSubview:lBView];
    
    BMessageView *bView = [[BMessageView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 100)];
    bView.backgroundColor = [UIColor whiteColor];
    bView.message = @"嗯，在的。有什么事吗？";
    [self.view addSubview:bView];
    
    ImageTextView *imgView = [[ImageTextView alloc] initWithFrame:CGRectMake(100, 220, 200, 200)];
    imgView.backgroundColor = [UIColor orangeColor];
    imgView.infoRect = CGRectMake(20, 20, 160, 160);
    imgView.imgView = [CreateViewFactory p_setImageViewScaleAspectFitImageName:@"3DRotate1"];
    imgView.infoStr = @"the is image";
    [self.view addSubview:imgView];
    
    PieCharView *pieView = [[PieCharView alloc] initWithFrame:CGRectMake(0, 430, self.view.bounds.size.width, 200)];
    pieView.backgroundColor = [UIColor grayColor];
    pieView.data = [PieItemModel modelData];
    pieView.radius = 50.0f;
    [self.view addSubview:pieView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
