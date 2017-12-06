//
//  TestBouncesViewController.m
//  AllDemo
//
//  Created by LHWen on 2017/12/5.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "TestBouncesViewController.h"
#import "LeftSuspensionView.h"
#import "TopSuspensionView.h"
#import "BottomSuspensionView.h"
#import "CenterSuspensionView.h"

@interface TestBouncesViewController ()

@property (nonatomic, strong) LeftSuspensionView *leftView;
@property (nonatomic, strong) TopSuspensionView *topView;
@property (nonatomic, strong) BottomSuspensionView *bottomView;
@property (nonatomic, strong) CenterSuspensionView *centerView;

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
        
        __weak typeof(self) weakSelf = self;
        _leftView = [[LeftSuspensionView alloc] init];
        _leftView.frame = CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT);
        _leftView.completeAnimate = ^(BOOL complete) {
            if (complete) {
                [weakSelf.leftView removeFromSuperview];
                weakSelf.leftView = nil;
            }
        };
        [[UIApplication sharedApplication].keyWindow addSubview:_leftView];
    }
}

- (void)clickTopBouncesButton:(UIButton *)sender {
    
    if (!_topView) {
        
        __weak typeof(self) weakSelf = self;
        _topView = [[TopSuspensionView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT)];
        _topView.completeAnimate = ^(BOOL complete) {
            if (complete) {
                [weakSelf.topView removeFromSuperview];
                weakSelf.topView = nil;
            }
        };
        [[UIApplication sharedApplication].keyWindow addSubview:_topView];
    }
}

- (void)clickBottomBouncesButton:(UIButton *)sender {
    
    if (!_bottomView) {
        
        __weak typeof(self) weakSelf = self;
        
        _bottomView = [[BottomSuspensionView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT)];
        _bottomView.completeAnimate = ^(BOOL complete) {
            
            if (complete) {
                [weakSelf.bottomView removeFromSuperview];
                weakSelf.bottomView = nil;
            }
        };
        [[UIApplication sharedApplication].keyWindow addSubview:_bottomView];
    }
}

- (void)clickCenterBouncesButton:(UIButton *)sender {
    
    if (!_centerView) {
        
        __weak typeof(self) weakSelf = self;
        
        _centerView = [[CenterSuspensionView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT)];
        _centerView.completeAnimate = ^(BOOL complete) {
            
            if (complete) {
                [weakSelf.centerView removeFromSuperview];
                weakSelf.centerView = nil;
            }
        };
        [[UIApplication sharedApplication].keyWindow addSubview:_centerView];
    }
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
