//
//  ImageTextView.m
//  AllDemo
//
//  Created by LHWen on 2018/9/14.
//  Copyright © 2018年 yuhui. All rights reserved.
//

#import "ImageTextView.h"

@implementation ImageTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    
    /** 生成字符串属性字典 */
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:14.0f];
    attributes[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    [self.imgView drawRect:self.bounds];
    
    [self.infoStr drawInRect:self.infoRect withAttributes:attributes];
}

@end
