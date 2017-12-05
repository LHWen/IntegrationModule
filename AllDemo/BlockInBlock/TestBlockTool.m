//
//  TestBlockTool.m
//  AllDemo
//
//  Created by LHWen on 2017/10/10.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "TestBlockTool.h"
#import "TestBlockOperation.h"

@implementation TestBlockTool

+ (TestBlockTool *)testBlockTool {
    
    static TestBlockTool *_testBlockTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _testBlockTool = [[self alloc] init];
    });
    
    return _testBlockTool;
}

+ (void)startTaskWithCallBack:(ETECompletion)callback {
    
    [self testBlockTool].completion = callback;
    
    TestBlockOperation *textBlockOperation = [[TestBlockOperation alloc] init];
    [textBlockOperation startTaskWithCallBack:^(id<NSObject> obj, NSError *error, id stat) {
        
        NSLog(@"obj = %@, stat = %@", [NSString stringWithFormat:@"%@", obj], stat);
        
        NSString *eteBlock = [NSString stringWithFormat:@"Success %@", obj];
        [self testBlockTool].completion(eteBlock, nil, stat);
    }];
}

@end
