//
//  UIImage+ImageScale.h
//  AllDemo
//
//  Created by yuhui on 17/2/8.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import <UIKit/UIKit.h>

// 图片拉伸
@interface UIImage (ImageScale)
// 缩放
- (UIImage *)imageScaleSize:(CGSize)size;
// 等比例缩放 以变化最小的
- (UIImage *)imageScaleEqualProportionSize:(CGSize)size;

@end
