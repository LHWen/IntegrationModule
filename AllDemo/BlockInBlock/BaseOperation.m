//
//  BaseOperation.m
//  AllDemo
//
//  Created by LHWen on 2017/10/10.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "BaseOperation.h"

@implementation BaseOperation

- (void)startTaskWithCallBack:(EECompletion)callback {
    // 子类实现
    
}

- (void)sendReqeust:(NSString *)request {
    
    [self parseData:request];
}

- (void)parseData:(NSString *)data {
    // 子类实现
}

@end
