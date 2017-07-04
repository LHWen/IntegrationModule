//
//  BulletView.h
//  AllDemo
//
//  Created by yuhui on 17/2/3.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MoveStatusType) {
    MoveStatusStart,
    MoveStatusEnter,
    MoveStatusEnd
};

@interface BulletView : UIView

@property (nonatomic, assign) int trajectory;  // 弹道
@property (nonatomic, copy) void(^moveStatusBlock)(MoveStatusType status);  // 弹幕状态回调

// 初始化弹幕
- (instancetype)initWithComment:(NSString *)comment;

// 开始动画
- (void)startAnimation;

// 结束动画
- (void)stopAnimation;

@end
