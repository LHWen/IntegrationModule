//
//  PieCharView.m
//  AllDemo
//
//  Created by LHWen on 2018/9/14.
//  Copyright © 2018年 yuhui. All rights reserved.
//

#import "PieCharView.h"
#import "PieItemModel.h"

@implementation PieCharView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGFloat start = M_PI_2 * 3;  // 起始位置
    CGFloat end = 0;
    
    // 遍历数组
    for (PieItemModel *model in self.data) {
        // 数据对应的结束位置
        end = start + model.value * 2 * M_PI;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:self.radius startAngle:start endAngle:end clockwise:YES];
        // 添加到圆心的线，形成闭区间
        [path addLineToPoint:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)];
        [model.color setFill];
        [path fill];
        
        start = end;
    }
}

@end
