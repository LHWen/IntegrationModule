//
//  CreateViewFactory.m
//  TestCreateView
//
//  Created by yuhui on 16/11/24.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import "CreateViewFactory.h"

@implementation CreateViewFactory

#pragma mark - UILable

+ (UILabel *)p_setLableText:(NSString *)text textFont:(CGFloat)size textColor:(UIColor *)textColor bgColor:(UIColor *)bgColor textAlignment:(NSTextAlignment)textAlignment numberOfLines:(NSInteger)numberOfLines {
    
    UILabel *lable  = [self initLableText:text textFont:size];
    lable.textColor = textColor;
    lable.backgroundColor = bgColor;
    lable.textAlignment = textAlignment;
    lable.numberOfLines = numberOfLines;
    
    return lable;
}

+ (UILabel *)p_setLableText:(NSString *)text textFont:(CGFloat)size textColor:(UIColor *)textColor bgColor:(UIColor *)bgColor Alignment:(NSTextAlignment)textAlignment Lines:(NSInteger)numberOfLines Radius:(CGFloat)radius
{
    
    UILabel *lable  = [self initLableText:text textFont:size];
    lable.textColor = textColor;
    lable.backgroundColor = bgColor;
    lable.textAlignment = textAlignment;
    lable.numberOfLines = numberOfLines;
    lable.layer.cornerRadius = radius;
    lable.layer.masksToBounds = YES;
    
    return lable;
}

+ (UILabel *)p_setLableWhiteBGColorZeroLineText:(NSString *)text textFont:(CGFloat)size textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *lable  = [self initLableText:text textFont:size];
    lable.textColor = textColor;
    lable.backgroundColor = [UIColor whiteColor];
    lable.textAlignment = textAlignment;
    lable.numberOfLines = 0;
   
    return lable;
}

+ (UILabel *)p_setLableWhiteBGColorOneLineText:(NSString *)text textFont:(CGFloat)size textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *lable  = [self initLableText:text textFont:size];
    lable.textColor = textColor;
    lable.backgroundColor = [UIColor whiteColor];
    lable.textAlignment = textAlignment;
    lable.numberOfLines = 1;
   
    return lable;
}

+ (UILabel *)p_setLableWhiteBGColorOneLineLeftText:(NSString *)text textFont:(CGFloat)size textColor:(UIColor *)textColor
{
    UILabel *lable  = [self initLableText:text textFont:size];
    lable.textColor = textColor;
    lable.backgroundColor = [UIColor whiteColor];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.numberOfLines = 1;
   
    return lable;
}

+ (UILabel *)p_setLableClearBGColorOneLineText:(NSString *)text textFont:(CGFloat)size textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *lable  = [self initLableText:text textFont:size];
    lable.textColor = textColor;
    lable.backgroundColor = [UIColor clearColor];
    lable.textAlignment = textAlignment;
    lable.numberOfLines = 1;
   
    return lable;
}

+ (UILabel *)initLableText:(NSString *)text textFont:(CGFloat)size {
    UILabel *lable  = [[UILabel alloc] init];
    lable.text = text;
    lable.font = [UIFont systemFontOfSize:size];
    
    return lable;
}

#pragma mark - UIView

+ (UIView *)p_setViewBGColor:(UIColor *)bgColor
{
    UIView *view = [self initViewBGColor:bgColor];
    view.alpha = 1.0;
    
    return view;
}

+ (UIView *)p_setViewBGColor:(UIColor *)bgColor Alpha:(CGFloat)alpha
{
    UIView *view = [self initViewBGColor:bgColor];
    view.alpha = alpha;

    return view;
}

+ (UIView *)p_setViewBGColor:(UIColor *)bgColor connerRadius:(CGFloat)radius
{
    UIView *view = [self initViewBGColor:bgColor];
    view.alpha = 1.0;
    view.layer.cornerRadius = radius;
    view.layer.masksToBounds = YES;
    
    return view;
}

+ (UIView *)p_setViewBGColor:(UIColor *)bgColor Alpha:(CGFloat)alpha connerRadius:(CGFloat)radius
{
    UIView *view = [self initViewBGColor:bgColor];
    view.alpha = alpha;
    view.layer.cornerRadius = radius;
    view.layer.masksToBounds = YES;
    
    return view;
}

+ (UIView *)initViewBGColor:(UIColor *)bgColor {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = bgColor;
    
    return view;
}

#pragma mark - UIImageView

+ (UIImageView *)p_setImageViewImageName:(NSString *)imageName ContentMode:(UIViewContentMode)model Clips:(BOOL)isClips Radius:(CGFloat)radius
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.contentMode = model;
    imageView.clipsToBounds = isClips;
    imageView.layer.cornerRadius = radius;
    imageView.layer.masksToBounds = YES;
    
    return imageView;
}

+ (UIImageView *)p_setImageViewImageName:(NSString *)imageName
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.contentMode = UIViewContentModeScaleToFill; // 填充满不裁剪
    
    return imageView;
}

+ (UIImageView *)p_setImageViewScaleAspectFitImageName:(NSString *)imageName
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.contentMode = UIViewContentModeScaleAspectFit; // 自适应图片高度
    
    return imageView;
}

+ (UIImageView *)p_setImageViewScaleAspectFillImageName:(NSString *)imageName
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.contentMode = UIViewContentModeScaleAspectFill; // 填充满裁剪
    imageView.clipsToBounds = YES;
    
    return imageView;
}

+ (UITableView *)p_initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:style];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        if ([UIScreen mainScreen].bounds.size.height == 812.0) { // iPhone X
            tableView.contentInset = UIEdgeInsetsMake(0, 0, 34.0f, 0);
        }
    }
    
    return tableView;
}

@end
