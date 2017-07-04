//
//  HWActivityIndicator.h
//  testDemo
//
//  Created by yuhui on 16/11/17.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * 使用原生控件UIActivityIndicatorView
 * 实现在网络请求时候显示加载视图
 * 实现在网络请求结束时候关闭加载视图
 */

@interface HWActivityIndicator : NSObject

/**
 *  显示加载视图
 *
 *  @param controller 自身的controller 一般传 self
 */
+ (void)hw_showLoadingViewController:(UIViewController *)controller;

/**
 *  关闭加载视图
 *
 *  @param controller 传入的controller 显示的方法传什么这里就传什么
 */
+ (void)hw_dismissLoadingViewController:(UIViewController *)controller;

@end
