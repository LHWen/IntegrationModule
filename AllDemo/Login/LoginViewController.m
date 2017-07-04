//
//  LoginViewController.m
//  AllDemo
//
//  Created by yuhui on 16/12/27.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "MainViewController.h"  // 切换到主界面 根视图切换
#import "AppDelegate.h"

@interface LoginViewController () <LoginViewDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    LoginView *loginView = [[LoginView alloc] init];
    loginView.delegate = self;
    loginView.frame = self.view.frame;
    [self.view addSubview:loginView];
}

- (void)changeRootView {
    MainViewController *mainVC = [[MainViewController alloc] init];
    [ADelegate changeRootViewControllerWithController:mainVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
