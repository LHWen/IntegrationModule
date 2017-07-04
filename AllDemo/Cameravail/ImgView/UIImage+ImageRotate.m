//
//  UIImage+ImageRotate.m
//  AllDemo
//
//  Created by yuhui on 17/2/8.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "UIImage+ImageRotate.h"
#import <QuartzCore/QuartzCore.h>  // image 旋转添加的两个类 <QuartzCore/QuartzCore.h> <Accelerate/Accelerate.h>
#import <Accelerate/Accelerate.h>

@implementation UIImage (ImageRotate)

// 图片选择的角度
// 1. image 渲染到 上下文Context中   2. context  3. context 转成图片 UIImage
- (UIImage *)imageRotateIndegree:(float)degree {
    
    // 1 image -> context
    size_t width = (size_t)(self.size.width * self.scale);
    size_t height = (size_t)(self.size.height * self.scale);
    
    size_t bytesPerRow = width * 4;   // 表明每行 图片数据 字节
    CGImageAlphaInfo alphaInfo = kCGImageAlphaPremultipliedFirst;  // alpha
    // 配置上下文参数
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, CGColorSpaceCreateDeviceRGB(), kCGBitmapByteOrderDefault | alphaInfo);
    if (!bmContext) {
        return nil;
    }
    CGContextDrawImage(bmContext, CGRectMake(0, 0, width, height), self.CGImage); // 将图片渲染到上下文中
    
    // 2 旋转
    /**
     *  参数
     *  1. 旋转源 图片  2. 旋转后 图片  3. 忽略
     *  4. 旋转角度   5. 背景颜色   6. 填充颜色
     */
    UInt8 *data = (UInt8 *)CGBitmapContextGetData(bmContext);
    vImage_Buffer src = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {data, height, width, bytesPerRow};
    Pixel_8888 bgColor = {0, 0 , 0, 0};
    vImageRotate_ARGB8888(&src, &dest, NULL, degree, bgColor, kvImageBackgroundColorFill);
    
    // 3 context - > UIImage
    CGImageRef rotateImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage *totateImage = [UIImage imageWithCGImage:rotateImageRef scale:self.scale orientation:self.imageOrientation];  // 旋转后的图片
    
    return totateImage;
}
@end
