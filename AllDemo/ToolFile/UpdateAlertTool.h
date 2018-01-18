//
//  UpdateAlertTool.h
//  AllDemo
//
//  Created by LHWen on 2018/1/18.
//  Copyright © 2018年 yuhui. All rights reserved.
//

#import <Foundation/Foundation.h>

// 用于消息弹框
@interface UpdateAlertTool : NSObject

/**
 * message 提醒信息
 * address 更新地址
 */
+ (void)updateMessage:(NSString *)message updateAddress:(NSString *)address;

@end
