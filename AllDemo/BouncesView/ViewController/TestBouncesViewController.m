//
//  TestBouncesViewController.m
//  AllDemo
//
//  Created by LHWen on 2017/12/5.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "TestBouncesViewController.h"
#import "LeftSuspensionView.h"

@interface TestBouncesViewController ()

@property (nonatomic, strong) LeftSuspensionView *leftView;

@end

@implementation TestBouncesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"弹框集合";
    self.view.backgroundColor = [UIColor purpleColor];
    
    [self p_setupBouttonLayout];
    
}

- (void)clickLeftBouncesButton:(UIButton *)sender {
    
    if (!_leftView) {
        
        _leftView = [[LeftSuspensionView alloc] init];
        _leftView.frame = CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT);
        _leftView.completeAnimate = ^(BOOL complete) {
            if (complete) {
                [_leftView removeFromSuperview];
                _leftView = nil;
            }
        };
        [[UIApplication sharedApplication].keyWindow addSubview:_leftView];
    }
}

- (void)clickTopBouncesButton:(UIButton *)sender {
    
}

- (void)clickBottomBouncesButton:(UIButton *)sender {
    
}

- (void)clickCenterBouncesButton:(UIButton *)sender {
    
}

// 按钮视图
- (void)p_setupBouttonLayout {
    
    UIButton *leftBouncesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBouncesBtn setTitle:@"左侧视图" forState:UIControlStateNormal];
    leftBouncesBtn.frame  = CGRectMake(90, 60, 160, 40);
    leftBouncesBtn.backgroundColor = [UIColor greenColor];
    [leftBouncesBtn addTarget:self action:@selector(clickLeftBouncesButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBouncesBtn];
    
    UIButton *topBouncesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [topBouncesBtn setTitle:@"顶部视图" forState:UIControlStateNormal];
    topBouncesBtn.frame  = CGRectMake(90, 140, 160, 40);
    topBouncesBtn.backgroundColor = [UIColor greenColor];
    [topBouncesBtn addTarget:self action:@selector(clickTopBouncesButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topBouncesBtn];
    
    UIButton *bottomBouncesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBouncesBtn setTitle:@"底部视图" forState:UIControlStateNormal];
    bottomBouncesBtn.frame  = CGRectMake(90, 220, 160, 40);
    bottomBouncesBtn.backgroundColor = [UIColor greenColor];
    [bottomBouncesBtn addTarget:self action:@selector(clickBottomBouncesButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBouncesBtn];
    
    UIButton *centerBouncesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [centerBouncesBtn setTitle:@"中部视图" forState:UIControlStateNormal];
    centerBouncesBtn.frame  = CGRectMake(90, 300, 160, 40);
    centerBouncesBtn.backgroundColor = [UIColor greenColor];
    [centerBouncesBtn addTarget:self action:@selector(clickCenterBouncesButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:centerBouncesBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
