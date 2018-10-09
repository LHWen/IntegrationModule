//
//  SolarTermTool.h
//  AllDemo
//
//  Created by LHWen on 2018/10/9.
//  Copyright © 2018年 yuhui. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SolarTermTool : NSObject

/**
 节气返回
 以2018年节气时间为基础，往节气日前五天推算为改节气
 */
+ (NSString *)solarTermDate:(NSDate *)sDate;

@end

NS_ASSUME_NONNULL_END
