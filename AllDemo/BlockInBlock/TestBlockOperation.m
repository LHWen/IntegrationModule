//
//  TestBlockOperation.m
//  AllDemo
//
//  Created by LHWen on 2017/10/10.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "TestBlockOperation.h"

@implementation TestBlockOperation

- (void)startTaskWithCallBack:(EECompletion)callback {
    
    self.completion = callback;
    
    [self sendReqeust:@"TestBlock"];
}

- (void)parseData:(NSString *)data {
    
    NSString *tBlock = data;
    NSString *stat = @"0";
    
    self.completion(tBlock, nil, stat);
}

@end
