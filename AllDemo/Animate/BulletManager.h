//
//  BulletManager.h
//  AllDemo
//
//  Created by yuhui on 17/2/3.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BulletView;
@interface BulletManager : NSObject

@property (nonatomic, copy) void(^generateViewBlock)(BulletView *view);

// 弹幕开始
- (void)start;

// 弹幕结束
- (void)stop;

@end
