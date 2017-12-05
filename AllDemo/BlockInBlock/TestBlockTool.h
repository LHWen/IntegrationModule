//
//  TestBlockTool.h
//  AllDemo
//
//  Created by LHWen on 2017/10/10.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ETECompletion)(id<NSObject> obj, NSError *error, id stat);

@interface TestBlockTool : NSObject

@property (nonatomic, copy) ETECompletion completion;

+ (void)startTaskWithCallBack:(ETECompletion)callback;

@end
