//
//  SolarTermTool.m
//  AllDemo
//
//  Created by LHWen on 2018/10/9.
//  Copyright © 2018年 yuhui. All rights reserved.
//

#import "SolarTermTool.h"

@implementation SolarTermTool

+ (NSString *)solarTermDate:(NSDate *)sDate {
    
    /** 时间判断逻辑 */
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateAndTime = [dateFormatter stringFromDate:sDate];
    
    // 提前天数
    long advanceDay =  [[dateFormatter dateFromString:dateAndTime] timeIntervalSince1970] + (5 * 24 * 60 * 60);
    // 获取提前天数的时间格式
    NSString *resultStr = [self timeHorizontalLineNoTimeStayle:[NSString stringWithFormat:@"%ld", advanceDay]];
    // 切割提前天数的时间字符串
    NSArray *resultArray = [resultStr componentsSeparatedByString:@"-"];
    
    // 小寒 1-5
    NSArray *solarTerm1 = @[@"01-01", @"01-02", @"01-03", @"01-04", @"01-05", @"01-06", @"01-07", @"01-08", @"01-09", @"01-10", @"01-11", @"01-12", @"01-13", @"01-14"];
    // 大寒 1-20
    NSArray *solarTerm2 = @[@"01-15", @"01-16", @"01-17", @"01-18", @"01-19", @"01-20", @"01-21", @"01-22", @"01-23", @"01-24", @"01-25", @"01-26", @"01-27", @"01-28", @"01-29", @"01-30", @"01-31"];
    // 立春 2-4
    NSArray *solarTerm3 = @[@"02-01", @"02-02", @"02-03", @"02-04", @"02-05", @"02-06", @"02-07", @"02-08", @"02-09", @"02-10", @"02-11", @"02-12", @"02-13", @"02-14"];
    // 雨水 2-19
    NSArray *solarTerm4 = @[@"02-15", @"02-16", @"02-17", @"02-18", @"02-19", @"02-20", @"02-21", @"02-22", @"02-23", @"02-24", @"02-25", @"02-26", @"02-27", @"02-28", @"02-29"];
    // 惊蛰 3-5
    NSArray *solarTerm5 = @[@"03-01", @"03-02", @"03-03", @"03-04", @"03-05", @"03-06", @"03-07", @"03-08", @"03-09", @"03-10", @"03-11", @"03-12", @"03-13", @"03-14"];
    // 春分 3-21
    NSArray *solarTerm6 = @[@"03-15", @"03-16", @"03-17", @"03-18", @"03-19", @"03-20", @"03-21", @"03-22", @"03-23", @"03-24", @"03-25", @"03-26", @"03-27", @"03-28", @"03-29", @"03-30", @"03-31"];
    // 清明 4-5
    NSArray *solarTerm7 = @[@"04-01", @"04-02", @"04-03", @"04-04", @"04-05", @"04-06", @"04-07", @"04-08", @"04-09", @"04-10", @"04-11", @"04-12", @"04-13", @"04-14"];
    // 谷雨 4-20
    NSArray *solarTerm8 = @[@"04-15", @"04-16", @"04-17", @"04-18", @"04-19", @"04-20", @"04-21", @"04-22", @"04-23", @"04-24", @"04-25", @"04-26", @"04-27", @"04-28", @"04-29", @"04-30"];
    // 立夏 5-5
    NSArray *solarTerm9 = @[@"05-01", @"05-02", @"05-03", @"05-04", @"05-05", @"05-06", @"05-07", @"05-08", @"05-09", @"05-10", @"05-11", @"05-12", @"05-13", @"05-14"];
    // 小满 5-21
    NSArray *solarTerm10 = @[@"05-15", @"05-16", @"05-17", @"05-18", @"05-19", @"05-20", @"05-21", @"05-22", @"05-23", @"05-24", @"05-25", @"05-26", @"05-27", @"05-28", @"05-29", @"05-30", @"05-31"];
    // 芒种 6-6
    NSArray *solarTerm11 = @[@"06-01", @"06-02", @"06-03", @"06-04", @"06-05", @"06-06", @"06-07", @"06-08", @"06-09", @"06-10", @"06-11", @"06-12", @"06-13", @"06-14"];
    // 夏至 6-21
    NSArray *solarTerm12 = @[@"06-15", @"06-16", @"06-17", @"06-18", @"06-19", @"06-20", @"06-21", @"06-22", @"06-23", @"06-24", @"06-25", @"06-26", @"06-27", @"06-28", @"06-29", @"06-30"];
    // 小暑 7-7
    NSArray *solarTerm13 = @[@"07-01", @"07-02", @"07-03", @"07-04", @"07-05", @"07-06", @"07-07", @"07-08", @"07-09", @"07-10", @"07-11", @"07-12", @"07-13", @"07-14", @"07-15", @"07-16"];
    // 大暑 7-23
    NSArray *solarTerm14 = @[@"07-17", @"07-18", @"07-19", @"07-20", @"07-21", @"07-22", @"07-23", @"07-24", @"07-25", @"07-26", @"07-27", @"07-28", @"07-29", @"07-30", @"07-31"];
    // 立秋 8-7
    NSArray *solarTerm15 = @[@"08-01", @"08-02", @"08-03", @"08-04", @"08-05", @"08-06", @"08-07", @"08-08", @"08-09", @"08-10", @"08-11", @"08-12", @"08-13", @"08-14", @"08-15", @"08-16"];
    // 处暑 8-23
    NSArray *solarTerm16 = @[@"08-17", @"08-18", @"08-19", @"08-20", @"08-21", @"08-22", @"08-23", @"08-24", @"08-25", @"08-26", @"08-27", @"08-28", @"08-29", @"08-30", @"08-31"];
    // 白露 9-8
    NSArray *solarTerm17 = @[@"09-01", @"09-02", @"09-03", @"09-04", @"09-05", @"09-06", @"09-07", @"09-08", @"09-09", @"09-10", @"09-11", @"09-12", @"09-13", @"09-14", @"09-15", @"09-16"];
    // 秋分 9-23
    NSArray *solarTerm18 = @[@"09-17", @"09-18", @"09-19", @"09-20", @"09-21", @"09-22", @"09-23", @"09-24", @"09-25", @"09-26", @"09-27", @"09-28", @"09-29", @"09-30"];
    // 寒露 10-8
    NSArray *solarTerm19 = @[@"10-01", @"10-02", @"10-03", @"10-04", @"10-05", @"10-06", @"10-07", @"10-08", @"10-09", @"10-10", @"10-11", @"10-12", @"10-13", @"10-14", @"10-15", @"10-16"];
    // 霜降 10-23
    NSArray *solarTerm20 = @[@"10-17", @"10-18", @"10-19", @"10-20", @"10-21", @"10-22", @"10-23", @"10-24", @"10-25", @"10-26", @"10-27", @"10-28", @"10-29", @"10-30", @"10-31"];
    // 立冬 11-7
    NSArray *solarTerm21 = @[@"11-01", @"11-02", @"11-03", @"11-04", @"11-05", @"11-06", @"11-07", @"11-08", @"11-09", @"11-10", @"11-11", @"11-12", @"11-13", @"11-14"];
    // 小雪 11-22
    NSArray *solarTerm22 = @[@"11-15", @"11-16", @"11-17", @"11-18", @"11-19", @"11-20", @"11-21", @"11-22", @"11-23", @"11-24", @"11-25", @"11-26", @"11-27", @"11-28", @"11-29", @"11-30"];
    // 大雪 12-7
    NSArray *solarTerm23 = @[@"12-01", @"12-02", @"12-03", @"12-04", @"12-05", @"12-06", @"12-07", @"12-08", @"12-09", @"12-10", @"12-11", @"12-12", @"12-13", @"12-14"];
    // 冬至 12-22
    NSArray *solarTerm24 = @[@"12-15", @"12-16", @"12-17", @"12-18", @"12-19", @"12-20", @"12-21", @"12-22", @"12-23", @"12-24", @"12-25", @"12-26", @"12-27", @"12-28", @"12-29", @"12-30", @"12-31"];
    
    NSArray *solarTerms = @[solarTerm1, solarTerm2, solarTerm3, solarTerm4, solarTerm5, solarTerm6, solarTerm7, solarTerm8,
                            solarTerm9, solarTerm10, solarTerm11, solarTerm12, solarTerm13, solarTerm14, solarTerm15, solarTerm16,
                            solarTerm17, solarTerm18, solarTerm19, solarTerm20, solarTerm21, solarTerm22, solarTerm23, solarTerm24];
    
    int a = 0;
    
    switch ([resultArray[1] integerValue]) {
        case 1:
            a = 0;
            break;
        case 2:
            a = 2;
            break;
        case 3:
            a = 4;
            break;
        case 4:
            a = 6;
            break;
        case 5:
            a = 8;
            break;
        case 6:
            a = 10;
            break;
        case 7:
            a = 12;
            break;
        case 8:
            a = 14;
            break;
        case 9:
            a = 16;
            break;
        case 10:
            a = 18;
            break;
        case 11:
            a = 20;
            break;
        case 12:
            a = 22;
            break;
            
        default:
            break;
    }
    
    NSArray *solarNames = @[@"小寒", @"大寒", @"立春", @"雨水", @"惊蛰", @"春分", @"清明", @"谷雨", @"立夏", @"小满", @"芒种", @"夏至", @"小暑", @"大暑",
                            @"立秋", @"处暑", @"白露", @"秋分", @"寒露", @"霜降", @"立冬", @"小雪", @"大雪", @"冬至"];
    NSString *nowDateSolar = [NSString stringWithFormat:@"%@-%@", resultArray[1], resultArray[2]];
    __block NSString *solarTermN = @"";
    
    [solarTerms[a] enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([nowDateSolar isEqualToString:obj]) {
            solarTermN = solarNames[a];
        }
    }];
    
    [solarTerms[a + 1] enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([nowDateSolar isEqualToString:obj]) {
            solarTermN = solarNames[a + 1];
        }
    }];
    
    return solarTermN;
}

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

@end
