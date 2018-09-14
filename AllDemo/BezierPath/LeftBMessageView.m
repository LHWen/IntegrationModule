//
//  LeftBMessageView.m
//  AllDemo
//
//  Created by LHWen on 2018/9/14.
//  Copyright © 2018年 yuhui. All rights reserved.
//

#import "LeftBMessageView.h"

static CGFloat const kPadding = 10.0f;
static CGFloat const kTextWMax = 200.0f;

@implementation LeftBMessageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    
    /** 生成字符串属性字典 */
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:14.0f];
    attributes[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    /** 计算字符串的size */
    CGSize textSize = [self.message boundingRectWithSize:CGSizeMake(kTextWMax, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    /** 计算气泡左顶点高度 */
    CGFloat popX = 2 * kPadding;
    CGFloat popY = kPadding;
    CGFloat popWidth = textSize.width + 2 * kPadding;
    CGFloat popHeight = textSize.height + 2 * kPadding;
    
    /** 绘制消息气泡 */
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(popX, popY, popWidth, popHeight) cornerRadius:kPadding];
    [[UIColor lightGrayColor] setFill];
    path.lineWidth = 0.5f;
    [path fill];
    
    /** 绘制三角形 */
    CGFloat topY = 3 * kPadding;
    CGFloat topX = 2 * kPadding;
    
    UIBezierPath *trianglePath = [UIBezierPath bezierPath];
    [trianglePath moveToPoint:CGPointMake(topX, topY)];
    [trianglePath addLineToPoint:CGPointMake(topX - kPadding, topY + kPadding/2)];
    [trianglePath addLineToPoint:CGPointMake(topX + kPadding , topY + kPadding)];
    [trianglePath closePath];
    [trianglePath fill];
    
    /** 计算文本的矩形位置 */
    CGRect textRect = CGRectZero;
    textRect.size = textSize;
    textRect.origin.x = popX + kPadding;
    textRect.origin.y = popY + kPadding;
    
    [self.message drawInRect:textRect withAttributes:attributes];
}

@end
