//
//  UIImage+ImageCut.m
//  AllDemo
//
//  Created by yuhui on 17/2/8.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "UIImage+ImageCut.h"

@implementation UIImage (ImageCut)

- (UIImage *)imageCutSize:(CGRect)rect {
   
    // 取出剪切(rect)部分
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    // 绘制图片
    CGRect smallRect = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallRect.size); // 开启上下文
    // 绘制上下文
    CGContextRef context = UIGraphicsGetCurrentContext();  // 获取上下文
    CGContextDrawImage(context, smallRect, subImageRef);
    
    UIImage *image = [UIImage imageWithCGImage:subImageRef];
    
    UIGraphicsEndImageContext();   // 结束上下文
    
    return image;
}

@end
