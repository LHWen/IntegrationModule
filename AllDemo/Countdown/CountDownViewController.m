//
//  CountDownViewController.m
//  AllDemo
//
//  Created by yuhui on 16/12/27.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import "CountDownViewController.h"

@interface CountDownViewController ()

/** 测试计时器 */
@property (nonatomic, assign) NSInteger timing;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UILabel *showTimer;

@end

@implementation CountDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"倒计时";
    self.view.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
    
    [self p_setShowTimerLayout];
    
    [self p_testAlertViewOfTiming];
}

#pragma mark -- 测试计时器的alertView
- (void)p_testAlertViewOfTiming
{
    _timing = 9;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(p_theCountdown) userInfo:nil repeats:YES];
}

/**-----------定时器调用方法----------*/
- (void)p_theCountdown
{
    _showTimer.text = [NSString stringWithFormat:@"%ld", --_timing];
    
    if (_timing == 0) {
        
        [_timer invalidate];
        _timer = nil;
        
        [self showAlert:@"定时器测试完成\n提醒信息将会在2s后自动消失"];
    }
}

/**--------创建视图----------*/
- (void)p_setShowTimerLayout {
    
    UILabel *titleLable = [CreateViewFactory p_setLableClearBGColorOneLineText:@"倒计时完成时弹框自动消失"
                                                                      textFont:20
                                                                     textColor:[UIColor blackColor]
                                                                 textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(20);
    }];
    
    _showTimer = [CreateViewFactory p_setLableClearBGColorOneLineText:@"9"
                                                             textFont:25
                                                            textColor:[UIColor redColor]
                                                        textAlignment:NSTextAlignmentCenter];
    
    [self.view addSubview:_showTimer];
    [_showTimer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(titleLable.mas_bottom).offset(15);
    }];
}

#pragma mark - 测试UIAlertView 自动消失
/**--------弹框使用UIAlertView 可以自定义-------*/
- (void)showAlert:(NSString *) _message{ // 时间
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:nil message:_message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:YES];
    
    [promptAlert show];
}

- (void)timerFireMethod:(NSTimer*)theTimer // 弹出框
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert = NULL;
    
    [theTimer invalidate];
    theTimer = nil;
    
    /** 使用延时操作 实现定时操作 */
    [self showAlertMakeDispatchTimeMessage:@"使用GCD中的延时操作\n实现定时自动消失的弹框"];
}


#pragma mark - 使用线程延时操作进行 测试 UIAlertView 自动消失 
// 使用延迟操作 可以起到定时器作用 不用使用定时器来进行延迟操作省去了定时器的释放
- (void)showAlertMakeDispatchTimeMessage:(NSString *)message {
    
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    [promptAlert show];
    
    //延迟操作
    double delayInSeconds;
    if (message.length < 5) {
        delayInSeconds = 2.0;
    }else if (message.length < 10) {
        delayInSeconds = 3.0;
    }else {
        //        delayInSeconds = message.length * 0.1;
        delayInSeconds = 4.0;
    }
    
    dispatch_time_t dismissTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(dismissTime, dispatch_get_main_queue(), ^{
        [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    });
    
    //单例
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /**
         *  执行一次代码
         */
    });
    
    //    后台执行
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // something
    });
    
    //    主线程执行
    dispatch_async(dispatch_get_main_queue(), ^{
        // something
    });
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [_timer invalidate];
    _timer = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
