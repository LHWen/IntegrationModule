//
//  UIImage+ImageCircle.m
//  AllDemo
//
//  Created by yuhui on 17/2/8.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "UIImage+ImageCircle.h"

@interface view : UIView

@property (nonatomic, retain) UIImage *image;

@end

@implementation view

- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    
    // 修改起始坐标 可以改变剪切位置
    CGContextAddEllipseInRect(ctx, CGRectMake(30, 50, rect.size.width/2, rect.size.height/2));
    CGContextClip(ctx);
    CGContextFillPath(ctx);
    [_image drawAtPoint:CGPointMake(0, 0)];
    
    CGContextRestoreGState(ctx);
}

@end

@implementation UIImage (ImageCircle)

- (UIImage *)imageClipCircle {
    
    CGFloat imageSizeMin = MIN(self.size.width, self.size.height);
    CGSize imageSize = CGSizeMake(imageSizeMin, imageSizeMin);
    
    view *mview = [[view alloc] init];
    mview.image = self;
    
    UIGraphicsBeginImageContext(imageSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    mview.frame = CGRectMake(0, 0, imageSizeMin, imageSizeMin);
    mview.backgroundColor = [UIColor whiteColor];  // 图片周边填充颜色
    [mview.layer renderInContext:context];
    UIImage *imageNew = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageNew;
}

@end
