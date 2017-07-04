//
//  TitleScrollView.h
//  AllDemo
//
//  Created by yuhui on 17/1/5.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TitleScrollViewDelegate <NSObject>

- (void)sendButtonSender:(NSInteger)sender;

@end

@interface TitleScrollView : UIScrollView

/**
*  初始化视图
*
*  @param titles           头部分类数组
*  @param normalTitleColor 标题正常颜色
*  @param selectTitleColor 标题选择颜色
*  @param lineViewColor    线条颜色
*/
- (instancetype)initWithTitles:(NSArray *)titles
              NormalTitleColor:(UIColor *)normalTitleColor
              SelectTitleColor:(UIColor *)selectTitleColor
                 LineViewColor:(UIColor *)lineViewColor;

/** 可变数组，存放头部按钮 */
@property(nonatomic,strong) NSMutableArray *btns;

/**  用于保存当前选中的按钮  */
@property(nonatomic,strong) UIButton *currentBtn;

@property (nonatomic, weak) id<TitleScrollViewDelegate> delegatet;

// 界面切换修改线条位置
- (void)updateLineViewLayout;
// 选中按钮显示中心
- (void)updateCenterButton:(UIButton *)button;

@end
