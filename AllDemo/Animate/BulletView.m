//
//  BulletView.m
//  AllDemo
//
//  Created by yuhui on 17/2/3.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "BulletView.h"

@interface BulletView ()

@property (nonatomic, strong) UILabel *lbComment;

@property (nonatomic, strong) UIImageView *headerImg;

@end

@implementation BulletView

// 初始化弹幕
- (instancetype)initWithComment:(NSString *)comment {
    self = [super init];
    
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
        self.layer.cornerRadius = 15;
        
        // 计算弹幕实际宽度
        NSDictionary *arr = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0]};
        CGFloat width = [comment sizeWithAttributes:arr].width;
        
        self.bounds = CGRectMake(0, 0, width + 20 + 40, 30);
        
        self.lbComment.text = comment;
        self.lbComment.frame = CGRectMake(10 + 30, 0, width, 30);
        
        self.headerImg.frame = CGRectMake(-10 , -10, 40, 40);
        self.headerImg.layer.cornerRadius = 20;
        self.headerImg.layer.borderColor = [UIColor greenColor].CGColor;
        self.headerImg.layer.borderWidth = 2;
        
    }
    return self;
}

// 开始动画
- (void)startAnimation {
    
    // 根据弹幕长度执行动画效果
    // 动画 🈶 v = l/t t一样 l 越长速度越快
    CGFloat durationTime = 4.0f;
    CGFloat wholeWidth = CGRectGetWidth(self.bounds) + kSCREENWIDTH;
    
    // 弹幕开始
    if (self.moveStatusBlock) {
        self.moveStatusBlock(MoveStatusStart);
    }
    
    // t = s / v;
    CGFloat speed = wholeWidth / durationTime;
    CGFloat enterDuration = CGRectGetWidth(self.bounds) / speed;
    
    // 延迟方法 可取消
    [self performSelector:@selector(enterScreen) withObject:nil afterDelay:enterDuration];
    
    __block CGRect selfFrame = self.frame;
    [UIView animateWithDuration:durationTime delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        selfFrame.origin.x -= wholeWidth;
        self.frame = selfFrame;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        // 滑出屏幕进行回调
        if (self.moveStatusBlock) {
            self.moveStatusBlock(MoveStatusEnd);
        }
    }];
}

- (void)enterScreen {
    
    if (self.moveStatusBlock) {
        self.moveStatusBlock(MoveStatusEnter);
    }
}

// 结束动画
- (void)stopAnimation {
    
    // 取消延迟方法
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    // 移除所有动画
    [self.layer removeAllAnimations];
    // 移除视图
    [self removeFromSuperview];
    
}

- (UILabel *)lbComment {
    if (!_lbComment) {
        _lbComment = [[UILabel alloc] initWithFrame:CGRectZero];
        _lbComment.font = [UIFont systemFontOfSize:14.0];
        _lbComment.textColor = [UIColor whiteColor];
        _lbComment.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbComment];
    }
    return _lbComment;
}

- (UIImageView *)headerImg {
    if (!_headerImg) {
        _headerImg = [CreateViewFactory p_setImageViewScaleAspectFillImageName:@"233"];
        [self addSubview:_headerImg];
    }
    return _headerImg;
}

@end
