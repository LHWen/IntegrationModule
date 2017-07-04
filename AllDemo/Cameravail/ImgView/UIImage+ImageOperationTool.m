//
//  UIImage+ImageOperationTool.m
//  AllDemo
//
//  Created by yuhui on 17/2/9.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "UIImage+ImageOperationTool.h"
#import <QuartzCore/QuartzCore.h>  // image 旋转添加的两个类 <QuartzCore/QuartzCore.h> <Accelerate/Accelerate.h>
#import <Accelerate/Accelerate.h>

@implementation UIImage (ImageOperationTool)

// 图片剪切
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

// ------- 图片拉伸 -------
- (UIImage *)imageScaleSize:(CGSize)size {
    
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

// ------ MIN 比例拉伸 -----
- (UIImage *)imageScaleMinProportionSize:(CGSize)size {
    
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    CGFloat scale = MIN(size.width/width, size.height/height);
    
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, scale * width, scale * height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

// -------- MAX 比例拉伸 -------
- (UIImage *)imageScaleMaxProportionSize:(CGSize)size {
    
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    CGFloat scale = MAX(size.width/width, size.height/height);
    
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, scale * width, scale * height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

// ------- 水印 渲染图片 -------
- (UIImage *)imageWater:(UIImage *)imageLogo waterString:(NSString *)waterString {
    
    UIGraphicsBeginImageContext(self.size);
    // 原始图片渲染
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    // 渲染logo
    if (imageLogo) {
        CGFloat waterX = self.size.width - imageLogo.size.width - 5;
        CGFloat waterY = self.size.height - imageLogo.size.height - 5;
        CGFloat waterW = 16;
        CGFloat waterH = 16;
        
        [imageLogo drawInRect:CGRectMake(waterX, waterY, waterW, waterH)];
    }
    // 渲染文字
    if (waterString.length > 0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        // 设置文字的大小颜色属性
        NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:20.0],
                              NSParagraphStyleAttributeName:paragraphStyle,
                              NSForegroundColorAttributeName:[UIColor redColor]};
        [waterString drawInRect:CGRectMake(5, 0, 300, 60) withAttributes:dic];  // 文字位置大小
    }
    UIImage *imageNew = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageNew;
}

@end
