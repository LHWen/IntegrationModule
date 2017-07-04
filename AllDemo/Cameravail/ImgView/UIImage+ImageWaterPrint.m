//
//  UIImage+ImageWaterPrint.m
//  AllDemo
//
//  Created by yuhui on 17/2/8.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "UIImage+ImageWaterPrint.h"

@implementation UIImage (ImageWaterPrint)

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
        NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:20.0],
                              NSParagraphStyleAttributeName:paragraphStyle,
                              NSForegroundColorAttributeName:[UIColor redColor]};
        [waterString drawInRect:CGRectMake(5, 0, 300, 60) withAttributes:dic];
    }
    UIImage *imageNew = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageNew;
    
}

@end
