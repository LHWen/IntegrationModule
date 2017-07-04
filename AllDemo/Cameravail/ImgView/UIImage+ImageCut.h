//
//  UIImage+ImageCut.h
//  AllDemo
//
//  Created by yuhui on 17/2/8.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 图片剪切分类 */
@interface UIImage (ImageCut)
// 传入剪切的范围
- (UIImage *)imageCutSize:(CGRect)rect;

@end
