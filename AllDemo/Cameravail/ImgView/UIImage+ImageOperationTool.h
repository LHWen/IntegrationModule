//
//  UIImage+ImageOperationTool.h
//  AllDemo
//
//  Created by yuhui on 17/2/9.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageOperationTool)

/**
 *  剪切图片
 *  @param rect 剪切图片的范围 基于图片尺寸
 *  @return 剪切后的新图片
 */
- (UIImage *)imageCutSize:(CGRect)rect;

/**
 *  旋转图片
 *  @param degree 旋转图片的角度  45*0.01745 |（0.01745 = 3.14/180）
 *  @return 旋转后的新图片
 */
- (UIImage *)imageRotateIndegree:(float)degree;

//----------- 图片的拉伸 -------------
/**
 *  图片根据所给尺寸拉伸
 *  @param size 传入拉伸的 宽 和 高
 *  @return 拉伸后的图片
 */
- (UIImage *)imageScaleSize:(CGSize)size;

/**
 *  等比例拉伸 （根据传入的宽、高与原尺寸比较 选择 最小 变化的比例拉伸）
 *  @param size 拉伸的尺寸
 *  @return  Min 最小比例拉伸后的图
 */
- (UIImage *)imageScaleMinProportionSize:(CGSize)size;

/**
 *  等比例拉伸 （根据传入的宽、高与原尺寸比较 选择 最大 变化的比例拉伸）
 *  @param size 拉伸的尺寸
 *  @return Max 最大比例拉伸后的图
 */
- (UIImage *)imageScaleMaxProportionSize:(CGSize)size;

/**
 *  给图片添加文字水印 和 logo图
 *  坐标尺寸大小 字体设置 需要在 .m 文件修改
 *  @param imageLogo   传入的logo图
 *  @param waterString 设置水印文字
 *  @return 添加好水印的图
 */
- (UIImage *)imageWater:(UIImage *)imageLogo waterString:(NSString *)waterString;

@end
