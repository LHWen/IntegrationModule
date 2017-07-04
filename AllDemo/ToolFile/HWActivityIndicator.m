//
//  HWActivityIndicator.m
//  testDemo
//
//  Created by yuhui on 16/11/17.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import "HWActivityIndicator.h"

@interface HWActivityIndicator () {
    UIView *_loadingBackgroundView;        // 背景View
    UIActivityIndicatorView *_activityView;    // 加载动画View
    BOOL _isShowing;                           // 开启加载
}

/**
 *  创建单利 通过单利调用实例方法
 */
+ (HWActivityIndicator *)shareView;

/**
 *  创建加载视图 类方法通过单利调用该方法 进行创建视图
 */
- (void)hw_showAvtivityIndicatorViewController:(UIViewController *)controller;

/**
 *  移除加载视图 类方法通过单利调用该方法 进行删除视图
 */
- (void)hw_dismissAvtivityIndicatorViewController:(UIViewController *)controller;


@end

@implementation HWActivityIndicator

// 创建单例
+ (HWActivityIndicator *)shareView {
    
    static dispatch_once_t once;
    static HWActivityIndicator *shareView;
    dispatch_once(&once, ^{
        shareView = [[self alloc] init];
    });
    return shareView;
}

+ (void)hw_showLoadingViewController:(UIViewController *)controller {
    
    [[self shareView] hw_showAvtivityIndicatorViewController:controller];
}

+ (void)hw_dismissLoadingViewController:(UIViewController *)controller {
    
    [[self shareView] hw_dismissAvtivityIndicatorViewController:controller];
}

- (void)hw_showAvtivityIndicatorViewController:(UIViewController *)controller {
    
    if (!_isShowing) {
        
        _isShowing = YES;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _loadingBackgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            _loadingBackgroundView.backgroundColor = [UIColor clearColor];
            
            _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            _activityView.backgroundColor = nil;
            _activityView.color = [UIColor colorWithRed:178.0/255.0 green:178.0/255.0 blue:178.0/255.0 alpha:1.0];
            [_activityView startAnimating];
            
            [_loadingBackgroundView addSubview:_activityView];
            _activityView.center = CGPointMake(_loadingBackgroundView.center.x, _loadingBackgroundView.center.y-64.0f);
            
            [controller.view addSubview:_loadingBackgroundView];
            [controller.view bringSubviewToFront:_loadingBackgroundView];
            
            controller.parentViewController.view.userInteractionEnabled = NO;
        });
    }
}

- (void)hw_dismissAvtivityIndicatorViewController:(UIViewController *)controller {
    
    _isShowing = NO;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [_activityView removeFromSuperview];
        [_loadingBackgroundView removeFromSuperview];
        
        _activityView = nil;
        _loadingBackgroundView = nil;
        
        controller.parentViewController.view.userInteractionEnabled = YES;
    });
}


@end
