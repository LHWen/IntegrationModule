//
//  MaskViewController.m
//  AllDemo
//
//  Created by yuhui on 16/12/27.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import "MaskViewController.h"
#import "MaskView.h"
#import "DateView.h"

@interface MaskViewController () <DateViewDelegate>

@property (nonatomic, strong) UIWindow *uiWindow;

@property (nonatomic, strong) MaskView *maskView;
// 选择日期视图
@property (nonatomic, strong) DateView *timeView;

@property (nonatomic, strong) UILabel *showTimeLable;

@end

@implementation MaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"遮挡层";
    self.view.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
    
    UIButton *button = ({
        UIButton *button       = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"弹出遮挡层" forState:UIControlStateNormal];
        button.frame           = CGRectMake(50, 50, 120, 50);
        button.backgroundColor = [UIColor greenColor];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        button;
    });
    [self.view addSubview:button];
    
    _showTimeLable = [CreateViewFactory p_setLableText:@"显示选择的日期"
                                              textFont:20
                                             textColor:[UIColor redColor]
                                               bgColor:[UIColor greenColor]
                                         textAlignment:NSTextAlignmentCenter
                                         numberOfLines:1];
    [self.view addSubview:_showTimeLable];
    [_showTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(120);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];

}

- (void)btnClick:(UIButton *)button {
    
    [self p_setWindowView];
    [self p_setMaskView];
    [self p_setupTimeView];
}

- (void)p_setWindowView {
    
    if (!_uiWindow) {
        _uiWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _uiWindow.windowLevel = UIWindowLevelNormal;
        
        /**
         * self.view.backgroundColor = [UIColor clearColor];
         * self.view.alpha = 0.5;
         * 这样的做法虽然改变了透明度，同样也改变了视图上所有子视图的透明度
         * 下面的做法只是改变背景的透明度，姿势图透明度不随父视图改变
         */
        // 设置透明度
        _uiWindow.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
        _uiWindow.hidden = NO;
        
        [_uiWindow addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissUIWindowView)]];
    }
}

- (void)dismissUIWindowView
{
    _maskView.hidden = YES;
    [_maskView removeFromSuperview];
    _maskView = nil;
    _timeView.hidden = YES;
    [_timeView removeFromSuperview];
    _timeView = nil;
    _uiWindow.hidden = YES;
    _uiWindow = nil;
}

- (void)p_setMaskView {
    
    if (!_maskView) {
        _maskView = [[MaskView alloc] init];
        _maskView.backgroundColor = [UIColor greenColor];
        [_uiWindow addSubview:_maskView];
        [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(100);
            make.centerX.equalTo(_uiWindow.mas_centerX);
            make.centerY.equalTo(_uiWindow.mas_centerY).offset(-60);
            make.left.right.equalTo(_uiWindow);
        }];
    }
}

- (void)p_setupTimeView {
    
    if (!_timeView) {
        _timeView = [[DateView alloc] init];
        _timeView.delegate = self;
        _timeView.backgroundColor = [UIColor whiteColor];
        [_uiWindow addSubview:_timeView];
        [_timeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(_uiWindow);
            make.height.mas_equalTo(230);
        }];
    }
}

#pragma mark - DateViewDelegate

- (void)cancelChoose {
    
    [self dismissUIWindowView];
}

- (void)sureChooseTimeString:(NSString *)timeString {
    
    _showTimeLable.text = timeString;
    [self dismissUIWindowView];
}

@end
