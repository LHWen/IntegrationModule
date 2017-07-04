//
//  SystemShareHelper.h
//  AllDemo
//
//  Created by LHWen on 2017/7/3.
//  Copyright © 2017年 yuhui. All rights reserved.
//

// 系统 图片分享 工具类

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SystemShareHelperType) {
    SystemShareHelperTypeWeChat = 1000,    // 微信
    SystemShareHelperTypeQQ,               // QQ
    SystemShareHelperTypeSina,             // 新浪微博
    SystemShareHelperTypeOther             // 系统开启所有能分享的
};

@interface SystemShareHelper : NSObject

/** 
 * 分享方法
 * @param type 分享类型
 * @param controller 展示的控制器
 * @return 返回分享结果 如果是No表示没有安装.
 */
+ (BOOL)shareWithType:(SystemShareHelperType)type andController:(UIViewController *)controller andItems:(NSArray *)items;


@end
