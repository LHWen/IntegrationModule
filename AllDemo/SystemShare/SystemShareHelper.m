//
//  SystemShareHelper.m
//  AllDemo
//
//  Created by LHWen on 2017/7/3.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "SystemShareHelper.h"
#import <Social/Social.h>

@interface SystemShareHelper ()

- (BOOL)shareWithType:(SystemShareHelperType)type andController:(UIViewController *)controller andItems:(NSArray *)items;

@end

@implementation SystemShareHelper

static SystemShareHelper * shareHelper;

#pragma mark - 单例
+ (instancetype)shareHelper {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareHelper = [[SystemShareHelper alloc] init];
    });
    return shareHelper;
}

#pragma mark - Public
+ (BOOL)shareWithType:(SystemShareHelperType)type andController:(UIViewController *)controller andItems:(NSArray *)items {
    return [[SystemShareHelper shareHelper] shareWithType:type andController:controller andItems:items];
}

- (BOOL)shareWithType:(SystemShareHelperType)type andController:(UIViewController *)controller andItems:(NSArray *)items {

    //分享对象  判断分享类型
    if(type == SystemShareHelperTypeOther) {
        UIActivityViewController * activityCtl = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
        // 不出现活动项目
        activityCtl.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
        [controller presentViewController:activityCtl animated:YES completion:nil];
        activityCtl.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError){
            if (completed) {
                NSLog(@"分享成功");
            }else {
                NSLog(@"分享失败");
            }
        };
        return YES;
    }
    
    NSString *serviceType = [self serviceTypeWithType:type];
    SLComposeViewController *composeVC = [SLComposeViewController composeViewControllerForServiceType:serviceType];
    // 添加要分享的图片
    
    for (id obj in items) {
        if ([obj isKindOfClass:[UIImage class]]) {
            
            [composeVC addImage:(UIImage *)obj];
        }else if ([obj isKindOfClass:[NSURL class]]) {
         
            [composeVC addURL:(NSURL *)obj];
        }
    }
    
    // 添加要分享的文字
    [composeVC setInitialText:@"测试系统分享功能"];
    
    // 弹出分享控制器
    composeVC.completionHandler = ^(SLComposeViewControllerResult result){
        if (result == SLComposeViewControllerResultDone) {
            
            NSLog(@"点击了发送");
        }else if (result == SLComposeViewControllerResultCancelled) {
            
            NSLog(@"点击了取消");
        }
    };
    
    @try {
        [controller presentViewController:composeVC animated:YES completion:nil];
        return YES;
        
    } @catch (NSException *exception) {
        NSLog(@"没有安装");
        return NO;
        
    } @finally {
        
    }
    return YES;
}


#pragma mark - Private
- (NSString *)serviceTypeWithType:(SystemShareHelperType)type {
    
    NSString * serviceType;
    if (type != SystemShareHelperTypeOther) {
        switch (type) {
            case SystemShareHelperTypeWeChat:
                serviceType = @"com.tencent.xin.sharetimeline";
                break;
            case SystemShareHelperTypeQQ:
                serviceType = @"com.tencent.mqq.ShareExtension";
                break;
            case SystemShareHelperTypeSina:
                serviceType = @"com.apple.share.SinaWeibo.post";
                break;
                
            default:
                break;
        }
    }
    return serviceType;
}

/*
 "<NSExtension: 0x1741735c0> {id = com.apple.share.Flickr.post}",
 "<NSExtension: 0x174173740> {id = com.taobao.taobao4iphone.ShareExtension}",
 "<NSExtension: 0x174173a40> {id = com.apple.reminders.RemindersEditorExtension}",
 "<NSExtension: 0x174173bc0> {id = com.apple.share.Vimeo.post}",
 "<NSExtension: 0x174173ec0> {id = com.apple.share.Twitter.post}",
 "<NSExtension: 0x174174040> {id = com.apple.mobileslideshow.StreamShareService}",
 "<NSExtension: 0x1741741c0> {id = com.apple.Health.HealthShareExtension}",
 "<NSExtension: 0x1741744c0> {id = com.apple.mobilenotes.SharingExtension}",
 "<NSExtension: 0x174174640> {id = com.alipay.iphoneclient.ExtensionSchemeShare}",
 "<NSExtension: 0x174174880> {id = com.apple.share.Facebook.post}",
 "<NSExtension: 0x174174a00> {id = com.apple.share.TencentWeibo.post}
 */

/*
 "<NSExtension: 0x174174340> {id = com.tencent.xin.sharetimeline}",  // 微信
 "<NSExtension: 0x174173d40> {id = com.tencent.mqq.ShareExtension}", // QQ
 "<NSExtension: 0x1741738c0> {id = com.apple.share.SinaWeibo.post}", // 新浪微博
 */


@end
