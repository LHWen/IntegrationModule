//
//  HWTimeStyleTool.h
//  HW_Liu
//
//  Created by HW_Liu on 17/5/17.
//  Copyright © 2017年 HW_Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWTimeStyleTool : NSObject

/** yyyy-MM-dd HH:mm:ss 样式 毫秒时间戳 */
+ (NSString *)timeHorizontalLineStyle:(NSString *)mSecondStr;

/** yyyy-MM-dd HH:mm 样式 毫秒时间戳 */
+ (NSString *)timeHorizontalLineNoSecondsStayle:(NSString *)mSecondStr;

/** yyyy-MM-dd 样式 毫秒时间戳 */
+ (NSString *)timeHorizontalLineNoTimeStayle:(NSString *)mSecondStr;

/** yyyy年MM月dd日 HH:mm:ss 样式 毫秒时间戳 */
+ (NSString *)timeYearMonthDataStyle:(NSString *)mSecondStr;

/** yyyy年MM月dd日 HH:mm 样式 毫秒时间戳 */
+ (NSString *)timeYearMonthDataNoSecondeStyle:(NSString *)mSecondStr;

/** yyyy年MM月dd日 样式 毫秒时间戳 */
+ (NSString *)timeYearMonthDataNoTimeStyle:(NSString *)mSecondStr;

@end
