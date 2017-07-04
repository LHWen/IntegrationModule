//
//  UIImage+ImageScale.m
//  AllDemo
//
//  Created by yuhui on 17/2/8.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "UIImage+ImageScale.h"

@implementation UIImage (ImageScale)

- (UIImage *)imageScaleSize:(CGSize)size {
    
    UIGraphicsBeginImageContext(size);
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)imageScaleEqualProportionSize:(CGSize)size {
    
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    
    CGFloat scale = MIN(size.width/width, size.height/height);
    
    UIGraphicsBeginImageContext(size);
    
    [self drawInRect:CGRectMake(0, 0, scale * width, scale * height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
