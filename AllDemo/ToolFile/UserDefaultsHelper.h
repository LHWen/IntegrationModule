//
//  UserDefaultsHelper.h
//  HZResources
//
//  Created by yuhui on 17/3/22.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import <Foundation/Foundation.h>

// 数据本地存取工具类
@interface UserDefaultsHelper : NSObject

+ (NSString *)getStringForKey:(NSString *)key;
+ (NSInteger)getIntForkey:(NSString *)key;
+ (NSDictionary *)getDictForKey:(NSString *)key;
+ (NSData *)getDataForKey:(NSString *)key;
+ (NSArray *)getArrayForKey:(NSString *)key;
+ (BOOL)getBoolForKey:(NSString *)key;

+ (void)setStringForKey:(NSString *)value :(NSString*)key;
+ (void)setIntForKey:(NSInteger)value :(NSString *)key;
+ (void)setDictForKey:(NSDictionary *)value :(NSString *)key;
+ (void)setDataForKey:(NSData *)value :(NSString *)key;
+ (void)setArrayForKey:(NSArray *)value :(NSString *)key;
+ (void)setBoolForKey:(BOOL)value :(NSString *)key;

+ (void)clearObjectForKeys:(NSArray *)keys;

@end
