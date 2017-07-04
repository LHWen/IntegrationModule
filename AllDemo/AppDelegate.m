//
//  AppDelegate.m
//  AllDemo
//
//  Created by yuhui on 16/12/26.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self p_initAppearance];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    self.window.rootViewController = loginVC;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)p_initAppearance
{
    // 状态栏
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // 设置导航栏颜色
    [[UINavigationBar appearance] setBarTintColor:[Utility colorWithHexString:@"#E1FFFF"]];
    // 设置导航栏字体颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    // 设置导航栏字体和颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSFontAttributeName: [UIFont systemFontOfSize:18.0f],
                                                           NSForegroundColorAttributeName :[UIColor blackColor]
                                                           }];
}

/**-----------------根视图切换-------------------*/
- (void)changeRootViewControllerWithController:(UIViewController *)controller
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIImage *img = [Utility createImageWithColor:[Utility colorWithHexString:@"#00FFFF"]];
        img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(5, 10, 5, 10)];
        
        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:controller];
        [navVC.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
        
        self.window.rootViewController = navVC;
    });
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
