//
//  UIImage+ImageWaterPrint.h
//  AllDemo
//
//  Created by yuhui on 17/2/8.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *   给图片添加水印
 */
@interface UIImage (ImageWaterPrint)

- (UIImage *)imageWater:(UIImage *)imageLogo waterString:(NSString *)waterString;

@end