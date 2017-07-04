//
//  BulletManager.m
//  AllDemo
//
//  Created by yuhui on 17/2/3.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "BulletManager.h"
#import "BulletView.h"

@interface BulletManager ()

// 弹幕数据来源
@property (nonatomic, strong) NSMutableArray *datasource;
// 弹幕使用过程中的数组变量
@property (nonatomic, strong) NSMutableArray *bulletComment;
// 存储弹幕View的数组变量
@property (nonatomic, strong) NSMutableArray *bulletViews;

// 是否结束弹幕
@property (nonatomic, assign) BOOL isStopAnimation;

@end

@implementation BulletManager

- (instancetype)init {
    if (self = [super init]) {
        self.isStopAnimation = YES;
    }
    return self;
}

- (NSMutableArray *)datasource {
    if (!_datasource) {
        _datasource = [NSMutableArray arrayWithArray:@[@"大吉大利，恭喜发财",
                                                       @"万事如意，16号私厨房",
                                                       @"发起弹幕，让子弹飞一会",
                                                       @"三体，白夜行，鬼吹灯，天才在左疯子在右",
                                                       @"活着，解忧杂货店，一个人的朝圣",
                                                       @"签订🍋",
                                                       @"千斤顶柠檬",
                                                       @"困死宝宝了，好困啊，困呀困或",
                                                       @"时间饶过了谁",
                                                       @"搞个今年计划"]];
    }
    return _datasource;
}

- (NSMutableArray *)bulletComment {
    if (!_bulletComment) {
        _bulletComment = [NSMutableArray array];
    }
    return _bulletComment;
}

- (NSMutableArray *)bulletViews {
    if (!_bulletViews) {
        _bulletViews = [NSMutableArray array];
    }
    return _bulletViews;
}

// 开始
- (void)start {
    if (!self.isStopAnimation) {
        return;
    }
    self.isStopAnimation = NO;
    [self.bulletComment removeAllObjects];
    [self.bulletComment addObjectsFromArray:self.datasource];
    
    [self initBulletComment];
}

// 结束
- (void)stop {
    
    if (self.isStopAnimation) {
        return;
    }
    self.isStopAnimation = YES;
    
    [self.bulletViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BulletView *view = obj;
        [view stopAnimation];
        [view removeFromSuperview];
        view = nil;
    }];
    [self.bulletViews removeAllObjects];
}

// 初始化弹幕 随机分配弹道
- (void)initBulletComment {
    
    NSMutableArray *tragectorys = [NSMutableArray arrayWithArray:@[@(0), @(1), @(2)]];
    for (int i = 0; i < 3; i++) {
        
        if (self.bulletComment.count > 0) {            
            // 通过随机数获取到弹道的轨迹
            NSInteger index = arc4random()%tragectorys.count;
            int trajectoty = [[tragectorys objectAtIndex:index] intValue];
            [tragectorys removeObjectAtIndex:index];
            
            // 从弹幕数组中逐一取出弹幕数据
            NSString *commentStr = [self.bulletComment firstObject];
            [self.bulletComment removeObjectAtIndex:0];
            
            // 创建弹幕View
            [self createBulletView:commentStr trajectoty:trajectoty];
        }
    }
}

// 创建弹幕
- (void)createBulletView:(NSString *)commentString trajectoty:(int)trajectoty {
    
    if (self.isStopAnimation) {
        return;
    }
    
    BulletView *bulletView = [[BulletView alloc] initWithComment:commentString];
    bulletView.trajectory = trajectoty;
    [self.bulletViews addObject:bulletView];
    
    __weak typeof(bulletView) weakView = bulletView;
    __weak typeof(self) mySelf = self;
    bulletView.moveStatusBlock = ^(MoveStatusType status) {
        
        if (self.isStopAnimation) {
            return;
        }
        
        switch (status) {
            case MoveStatusStart:{
                // 开始进入弹幕, 将创建的View加入到弹幕管理中
                [self.bulletViews addObject:weakView];
                break;
            }
            case MoveStatusEnter:{
                // 弹幕完全进入弹幕,判断是否还有其他内容，如果有则在改弹幕轨迹中创建一个弹幕
                NSString *comment = [mySelf nextComment];
                if (comment) {
                    [mySelf createBulletView:comment trajectoty:trajectoty];
                }
                break;
            }
            case MoveStatusEnd:{
                // 弹幕完全飞出屏幕
                if ([mySelf.bulletViews containsObject:weakView]) {
                    [weakView stopAnimation];
                    [mySelf.bulletViews removeObject:weakView];
                }
                if (mySelf.bulletViews.count == 0) {
                    // 说明弹幕播放完，重新开始播放
                    self.isStopAnimation = YES;
                    [mySelf start];
                }
                break;
            }
                
            default:
                break;
        }
    };
    
    if (self.generateViewBlock) {
        self.generateViewBlock(bulletView);
    }
    
}

// 下一条
- (NSString *)nextComment {
    if (self.bulletComment.count == 0) {
        return nil;
    }
    NSString *comment = [self.bulletComment firstObject];
    if (comment) {
        [self.bulletComment removeObjectAtIndex:0];
    }
    return comment;
}

@end
