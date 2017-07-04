//
//  HWTimeStyleTool.m
//  testDemo
//
//  Created by yuhui on 17/5/17.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "HWTimeStyleTool.h"

@implementation HWTimeStyleTool

/** yyyy-MM-dd HH:mm:ss 样式 毫秒时间戳 */
+ (NSString *)timeHorizontalLineStyle:(NSString *)mSecondStr {
    
    NSDate *dateTime;
    if (mSecondStr.length > 10) {
        dateTime = [NSDate dateWithTimeIntervalSince1970:([mSecondStr longLongValue]/1000)];
    }else {
        dateTime = [NSDate dateWithTimeIntervalSince1970:[mSecondStr longLongValue]];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:dateTime];
    
    return dateStr;
}

/** yyyy-MM-dd HH:mm 样式 毫秒时间戳 */
+ (NSString *)timeHorizontalLineNoSecondsStayle:(NSString *)mSecondStr {
    
    NSDate *dateTime;
    if (mSecondStr.length > 10) {
        dateTime = [NSDate dateWithTimeIntervalSince1970:([mSecondStr longLongValue]/1000)];
    }else {
        dateTime = [NSDate dateWithTimeIntervalSince1970:[mSecondStr longLongValue]];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateStr = [dateFormatter stringFromDate:dateTime];
    
    return dateStr;
}

/** yyyy-MM-dd 样式 毫秒时间戳 */
+ (NSString *)timeHorizontalLineNoTimeStayle:(NSString *)mSecondStr {
    
    NSDate *dateTime;
    if (mSecondStr.length > 10) {
        dateTime = [NSDate dateWithTimeIntervalSince1970:([mSecondStr longLongValue]/1000)];
    }else {
        dateTime = [NSDate dateWithTimeIntervalSince1970:[mSecondStr longLongValue]];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:dateTime];
    
    return dateStr;
}

/** yyyy年MM月dd日 HH:mm:ss 样式 毫秒时间戳 */
+ (NSString *)timeYearMonthDataStyle:(NSString *)mSecondStr {
 
    NSDate *dateTime;
    if (mSecondStr.length > 10) {
        dateTime = [NSDate dateWithTimeIntervalSince1970:([mSecondStr longLongValue]/1000)];
    }else {
        dateTime = [NSDate dateWithTimeIntervalSince1970:[mSecondStr longLongValue]];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:dateTime];
    
    return dateStr;
}

/** yyyy年MM月dd日 HH:mm 样式 毫秒时间戳 */
+ (NSString *)timeYearMonthDataNoSecondeStyle:(NSString *)mSecondStr {
    
    NSDate *dateTime;
    if (mSecondStr.length > 10) {
        dateTime = [NSDate dateWithTimeIntervalSince1970:([mSecondStr longLongValue]/1000)];
    }else {
        dateTime = [NSDate dateWithTimeIntervalSince1970:[mSecondStr longLongValue]];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    NSString *dateStr = [dateFormatter stringFromDate:dateTime];
    
    return dateStr;
}

/** yyyy年MM月dd日 样式 毫秒时间戳 */
+ (NSString *)timeYearMonthDataNoTimeStyle:(NSString *)mSecondStr {
 
    NSDate *dateTime;
    if (mSecondStr.length > 10) {
        dateTime = [NSDate dateWithTimeIntervalSince1970:([mSecondStr longLongValue]/1000)];
    }else {
        dateTime = [NSDate dateWithTimeIntervalSince1970:[mSecondStr longLongValue]];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *dateStr = [dateFormatter stringFromDate:dateTime];
    
    return dateStr;
}

@end
