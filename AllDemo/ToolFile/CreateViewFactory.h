//
//  CreateViewFactory.h
//  TestCreateView
//
//  Created by yuhui on 16/11/24.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  快速创建视图类工厂方法
 */

@interface CreateViewFactory : NSObject

#pragma mark - UILable
/**
 *  创建UILable 直角
 *
 *  @param text          lable展示内容
 *  @param size          lable的字体尺寸
 *  @param textColor     字体颜色
 *  @param bgColor       背景颜色
 *  @param textAlignment 对齐方式
 *  @param numberOfLines 行数
 */
+ (UILabel *)p_setLableText:(NSString *)text
                   textFont:(CGFloat)size
                  textColor:(UIColor *)textColor
                    bgColor:(UIColor *)bgColor
              textAlignment:(NSTextAlignment)textAlignment
              numberOfLines:(NSInteger)numberOfLines;

/**
 *  创建UILable 圆角
 *
 *  @param text          lable展示内容
 *  @param size          字体大小
 *  @param textColor     字体颜色
 *  @param bgColor       背景颜色
 *  @param textAlignment 对齐方式
 *  @param numberOfLines 行数
 *  @param radius        圆角半径 CGFloat
 */
+ (UILabel *)p_setLableText:(NSString *)text
                   textFont:(CGFloat)size
                  textColor:(UIColor *)textColor
                    bgColor:(UIColor *)bgColor
                  Alignment:(NSTextAlignment)textAlignment
                      Lines:(NSInteger)numberOfLines
                     Radius:(CGFloat)radius;

/**
 *  创建背景颜色为白色 显示行数为0的Lable
 *
 *  @param text          lable展示内容
 *  @param size          字体大小
 *  @param textColor     字体颜色
 *  @param textAlignment 对齐方式
 */
+ (UILabel *)p_setLableWhiteBGColorZeroLineText:(NSString *)text
                                       textFont:(CGFloat)size
                                      textColor:(UIColor *)textColor
                                  textAlignment:(NSTextAlignment)textAlignment;

/**
 *  创建背景颜色为白色 显示行数 1行 的Lable
 *
 *  @param text          lable展示内容
 *  @param size          字体大小
 *  @param textColor     字体颜色
 *  @param textAlignment 对齐方式
 */
+ (UILabel *)p_setLableWhiteBGColorOneLineText:(NSString *)text
                                      textFont:(CGFloat)size
                                     textColor:(UIColor *)textColor
                                 textAlignment:(NSTextAlignment)textAlignment;

/**
 *  创建背景颜色为透明 显示行数 1行 的Lable
 *
 *  @param text          lable展示内容
 *  @param size          字体大小
 *  @param textColor     字体颜色
 *  @param textAlignment 对齐方式
 */
+ (UILabel *)p_setLableClearBGColorOneLineText:(NSString *)text
                                      textFont:(CGFloat)size
                                     textColor:(UIColor *)textColor
                                 textAlignment:(NSTextAlignment)textAlignment;

/**
 *  创建背景颜色为白色 显示行数 1行 左对齐 的Lable
 *
 *  @param text      lable展示内容
 *  @param size      字体大小
 *  @param textColor 字体颜色
 */
+ (UILabel *)p_setLableWhiteBGColorOneLineLeftText:(NSString *)text
                                          textFont:(CGFloat)size
                                         textColor:(UIColor *)textColor;


#pragma mark - UIView
/**
 *  创建一个 透明度 = 1.0 直角 View
 *
 *  @param bgColor View背景颜色
 */
+ (UIView *)p_setViewBGColor:(UIColor *)bgColor;

/**
 *  创建一个 透明度 < 1.0 直角 View
 *
 *  @param bgColor 背景颜色
 *  @param alpha   透明度 0.0 ~ 1.0
 */
+ (UIView *)p_setViewBGColor:(UIColor *)bgColor Alpha:(CGFloat)alpha;

/**
 *  创建一个 透明度 = 1.0 圆角 View
 *
 *  @param bgColor 背景颜色
 *  @param radius  圆角半径 CGFloat
 */
+ (UIView *)p_setViewBGColor:(UIColor *)bgColor connerRadius:(CGFloat)radius;

/**
 *  创建一个 透明度 < 1.0 圆角 View
 *
 *  @param bgColor 背景颜色
 *  @param alpha   透明度 0.0 ~ 1.0
 *  @param radius  圆角半径 CGFloat
 */
+ (UIView *)p_setViewBGColor:(UIColor *)bgColor Alpha:(CGFloat)alpha connerRadius:(CGFloat)radius;


#pragma mark - UIImageView
/**
 *  创建一个包含图片的 UIImageView
 *
 *  @param imageName 需要传入的图片名称
 *  @param model     填充样式
 *  @param isClips   是否裁剪 用于 AspectFill类型（YES）其余传（NO）
 *  @param radius    圆角半径
 */
+ (UIImageView *)p_setImageViewImageName:(NSString *)imageName ContentMode:(UIViewContentMode)model Clips:(BOOL)isClips Radius:(CGFloat)radius;

/**
 *  创建一个默认类型UIImageView 填充满不裁剪
 *
 *  @param imageName 图片名称
 */
+ (UIImageView *)p_setImageViewImageName:(NSString *)imageName;

/**
 *  创建一个默认类型UIImageView 保持图片原有大小
 *
 *  @param imageName 图片名称
 */
+ (UIImageView *)p_setImageViewScaleAspectFitImageName:(NSString *)imageName;

/**
 *  创建一个默认类型UIImageView 比例填充满 裁剪多余的边缘
 *
 *  @param imageName 图片名称
 */
+ (UIImageView *)p_setImageViewScaleAspectFillImageName:(NSString *)imageName;

+ (UITableView *)p_initWithFrame:(CGRect)frame style:(UITableViewStyle)style;


@end
