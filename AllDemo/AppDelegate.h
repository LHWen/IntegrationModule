//
//  AppDelegate.h
//  AllDemo
//
//  Created by yuhui on 16/12/26.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ADelegate ((AppDelegate *) [UIApplication sharedApplication].delegate)

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// 改变根视图
- (void)changeRootViewControllerWithController:(UIViewController *)controller;


@end

