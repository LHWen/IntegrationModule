//
//  AppDelegate.m
//  AllDemo
//
//  Created by yuhui on 16/12/26.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "SolarTermTool.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self p_initLocationNotificationApplication:application];
    
    [self p_initAppearance];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    self.window.rootViewController = loginVC;
    [self.window makeKeyAndVisible];
    
    NSString *solarTerm = [SolarTermTool solarTermDate:[NSDate date]];
    NSLog(@"solar term is %@", solarTerm);
    
    // 价格字符样式 0.20 2.00 10.00 200.00 2,000.00 20,000.00 200,000.00 2,000,000.00 20,000,000.00 200,000,000.00
    NSLog(@"价格：%@", [self formatDecimalNumber:@"0.2"]);
    NSLog(@"价格：%@", [self formatDecimalNumber:@"2"]);
    NSLog(@"价格：%@", [self formatDecimalNumber:@"10"]);
    NSLog(@"价格：%@", [self formatDecimalNumber:@"200"]);
    NSLog(@"价格：%@", [self formatDecimalNumber:@"2000"]);
    NSLog(@"价格：%@", [self formatDecimalNumber:@"20000"]);
    NSLog(@"价格：%@", [self formatDecimalNumber:@"200000"]);
    NSLog(@"价格：%@", [self formatDecimalNumber:@"2000000"]);
    NSLog(@"价格：%@", [self formatDecimalNumber:@"20000000"]);
    NSLog(@"价格：%@", [self formatDecimalNumber:@"200000000"]);
    
    return YES;
}

- (NSString *)formatDecimalNumber:(NSString *)string {
    
    if (!string || string.length == 0) {
        return string;
    }
    
    NSNumber *number = @([string doubleValue]);
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    formatter.positiveFormat = @"###,##0.00";
    
    NSString *amountString = [formatter stringFromNumber:number];
    return amountString;
}

- (void)p_initLocationNotificationApplication:(UIApplication *)application {
    
    /** 本地推送 */
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge categories:nil];
        [application registerUserNotificationSettings:settings];
    } else { // 如App最低版本支持 iOS 8.0 则不需要进行判断，直接使用上方注册本地通知
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge];
    }
    /** 本地推送，一般用于闹钟、行程安排、区域变化提醒等 */
    UILocalNotification *locationNoti = [UILocalNotification new];
    locationNoti.alertTitle = @"消息提醒";
    locationNoti.alertBody = @"测试本地消息推送";
    //    locationNoti.soundName = @""; // 自定义推送消息声音
    locationNoti.fireDate = [NSDate dateWithTimeIntervalSinceNow:10]; // 触发消息通知时间 10秒后触发
    application.applicationIconBadgeNumber++;
    [application scheduleLocalNotification:locationNoti]; // 启动本地通知
}

- (void)p_initAppearance {
    
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
- (void)changeRootViewControllerWithController:(UIViewController *)controller {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIImage *img = [Utility createImageWithColor:[Utility colorWithHexString:@"#00FFFF"]];
        img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(5, 10, 5, 10)];
        
        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:controller];
        [navVC.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
        
        self.window.rootViewController = navVC;
    });
}

// 注册推送成功 获取设备唯一表示 传给服务器 服务器进行消息推送
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
}

// 注册推送失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
}

// 接收到苹果服务器推送消息 触发
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
}

// 接收到本地消息推送 触发
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    NSLog(@"接收到本地推送消息");
    application.applicationIconBadgeNumber--;
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
