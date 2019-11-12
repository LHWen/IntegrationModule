//
//  UserDefaultsHelper.m
//  HZResources
//
//  Created by yuhui on 17/3/22.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "UserDefaultsHelper.h"

@implementation UserDefaultsHelper

+ (NSString *)getStringForKey:(NSString *)key {
    
    NSString* val = @"";
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) val = [standardUserDefaults stringForKey:key];
    if (val == NULL) val = @"";
    return val;
}

+ (NSInteger)getIntForkey:(NSString *)key {
    
    NSInteger val = 0;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) val = [standardUserDefaults integerForKey:key];
    return val;
}

+ (NSDictionary *)getDictForKey:(NSString *)key {
    
    NSDictionary* val = nil;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) val = [standardUserDefaults dictionaryForKey:key];
    return val;
}

+ (NSData *)getDataForKey:(NSString *)key {
    
    NSData* val = nil;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) val = [standardUserDefaults dataForKey:key];
    return val;
}

+ (NSArray *)getArrayForKey:(NSString *)key {
    
    NSArray* val = nil;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) val = [standardUserDefaults arrayForKey:key];
    return val;
}

+ (BOOL)getBoolForKey:(NSString *)key {
    
    BOOL val = FALSE;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) val = [standardUserDefaults boolForKey:key];
    return val;
}

+ (void)setStringForKey:(NSString *)value :(NSString *)key {
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        [standardUserDefaults setObject:value forKey:key];
        [standardUserDefaults synchronize];
    }
}

+ (void)setIntForKey:(NSInteger)value :(NSString *)key {
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        [standardUserDefaults setInteger:value forKey:key];
        [standardUserDefaults synchronize];
    }
}

+ (void)setDictForKey:(NSDictionary *)value :(NSString *)key {
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        [standardUserDefaults setObject:value forKey:key];
        [standardUserDefaults synchronize];
    }
}

+ (void)setDataForKey:(NSData *)value :(NSString *)key {
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        [standardUserDefaults setObject:value forKey:key];
        [standardUserDefaults synchronize];
    }
}

+ (void)setArrayForKey:(NSArray *)value :(NSString *)key {
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        [standardUserDefaults setObject:value forKey:key];
        [standardUserDefaults synchronize];
    }
}

+ (void)setBoolForKey:(BOOL)value :(NSString *)key {
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        
        [standardUserDefaults setBool:value forKey:key];
        [standardUserDefaults synchronize];
    }
}


// 删除本地数据
+ (void)clearObjectForKeys:(NSArray *)keys {
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        for (NSString *key in keys) {
            
            [standardUserDefaults removeObjectForKey:key];
        }
        [standardUserDefaults synchronize];
    }
}


@end
