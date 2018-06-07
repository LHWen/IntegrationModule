//
//  SocketUtility.h
//  AllDemo
//
//  Created by LHWen on 2018/6/7.
//  Copyright © 2018年 yuhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocketRocket.h"

extern NSString * const kNeedPayOrderNote;
extern NSString * const kWebSocketDidOpenNote;
extern NSString * const kWebSocketDidCloseNote;
extern NSString * const kWebSocketdidReceiveMessageNote;

typedef void(^SocketCompletion)(id<NSObject> obj);

@interface SocketUtility : NSObject

// 获取连接状态
@property (nonatomic,assign,readonly) SRReadyState socketReadyState;

+ (SocketUtility *)instance;

- (void)SRWebSocketOpenWithURLString:(NSString *)urlString;//开启连接
- (void)SRWebSocketClose;//关闭连接
- (void)sendData:(id)data;//发送数据

@property (nonatomic, assign) SocketCompletion completion;

@end
