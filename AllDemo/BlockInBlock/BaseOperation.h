//
//  BaseOperation.h
//  AllDemo
//
//  Created by LHWen on 2017/10/10.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^EECompletion)(id<NSObject> obj, NSError *error, id stat);

@interface BaseOperation : NSObject

/**
 *  请求完成回调
 */
@property (nonatomic, copy) EECompletion completion;

/**
 *  解析操作队列，用于解析服务端返回的数据
 */
@property (nonatomic, strong, readonly) NSOperationQueue *parseQueue;

- (void)startTaskWithCallBack:(EECompletion)callback;

- (void)sendReqeust:(NSString *)request;

- (void)parseData:(NSString *)data;

@end
