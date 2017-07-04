//
//  AnimateViewController.m
//  AllDemo
//
//  Created by yuhui on 17/1/20.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "AnimateViewController.h"

@interface AnimateViewController ()

@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation AnimateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"原生动画";
    self.view.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
    
    _iconImageView = [CreateViewFactory p_setImageViewScaleAspectFitImageName:@"icon_center_point"];
    _iconImageView.frame = CGRectMake(10, 10, 24, 24);
    [self.view addSubview:_iconImageView];
    
    [self p_setupAnimateOne];
    
}

// 动画1
- (void)p_setupAnimateOne {
    
    [UIView animateWithDuration:3 animations:^{
        CGRect iconFrame = _iconImageView.frame;
        iconFrame.origin.x = 240;
        _iconImageView.frame = iconFrame;
    }];
    
    [self p_setupAnimateTwo];
}

// 动画2 延时执行
- (void)p_setupAnimateTwo {
    
    /**
     *  delay 3秒后执行动画
     *  1.options 常规动画属性设置（可以同时选择多个进行设置）
     *  UIViewAnimationOptionLayoutSubviews：动画过程中保证子视图跟随运动。
     *  UIViewAnimationOptionAllowUserInteraction：动画过程中允许用户交互。
     *  UIViewAnimationOptionBeginFromCurrentState：所有视图从当前状态开始运行。
     *  UIViewAnimationOptionRepeat：重复运行动画。
     *  UIViewAnimationOptionAutoreverse ：动画运行到结束点后仍然以动画方式回到初始点。
     *  UIViewAnimationOptionOverrideInheritedDuration：忽略嵌套动画时间设置。
     *  UIViewAnimationOptionOverrideInheritedCurve：忽略嵌套动画速度设置。
     *  UIViewAnimationOptionAllowAnimatedContent：动画过程中重绘视图（注意仅仅适用于转场动画）。
     *  UIViewAnimationOptionShowHideTransitionViews：视图切换时直接隐藏旧视图、显示新视图，而不是将旧视图从父视图移除（仅仅适用于转场动画）
     *  UIViewAnimationOptionOverrideInheritedOptions ：不继承父动画设置或动画类型。
     *
     *  2.动画速度控制（可从其中选择一个设置）
     *  UIViewAnimationOptionCurveEaseInOut：动画先缓慢，然后逐渐加速。
     *  UIViewAnimationOptionCurveEaseIn ：动画逐渐变慢。
     *  UIViewAnimationOptionCurveEaseOut：动画逐渐加速。
     *  UIViewAnimationOptionCurveLinear ：动画匀速执行，默认值。
     *
     *  3.转场类型（仅适用于转场动画设置，可以从中选择一个进行设置，基本动画、关键帧动画不需要设置）
     *  UIViewAnimationOptionTransitionNone：没有转场动画效果。
     *  UIViewAnimationOptionTransitionFlipFromLeft ：从左侧翻转效果。
     *  UIViewAnimationOptionTransitionFlipFromRight：从右侧翻转效果。
     *  UIViewAnimationOptionTransitionCurlUp：向后翻页的动画过渡效果。
     *  UIViewAnimationOptionTransitionCurlDown ：向前翻页的动画过渡效果。
     *  UIViewAnimationOptionTransitionCrossDissolve：旧视图溶解消失显示下一个新视图的效果。
     *  UIViewAnimationOptionTransitionFlipFromTop ：从上方翻转效果。
     *  UIViewAnimationOptionTransitionFlipFromBottom：从底部翻转效果。
     */
    
    UIImageView *imgView = [CreateViewFactory p_setImageViewScaleAspectFitImageName:@"icon_center_point"];
    imgView.frame = _iconImageView.frame;
    [self.view addSubview:imgView];
    
    [UIView animateWithDuration:1.5 delay:2.5 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        CGRect iconFrame = imgView.frame;
        iconFrame.origin.y = 140;
        imgView.frame = iconFrame;
    } completion:^(BOOL finished) {
        [self p_setupAnimateThree];
    }];
}

// 动画3
- (void)p_setupAnimateThree {
    
    UIImageView *imgView = [CreateViewFactory p_setImageViewScaleAspectFitImageName:@"icon_center_point"];
    imgView.frame = CGRectMake(240, 140, 24, 24);
    [self.view addSubview:imgView];
    
    [UIView animateWithDuration:2 animations:^{
        CGRect iconFrame = imgView.frame;
        iconFrame.origin.x = 10;
        imgView.frame = iconFrame;
    } completion:^(BOOL finished) {
        [self p_setupAnimateFour];
    }];
}

// 动画4
- (void)p_setupAnimateFour {
    
    UIImageView *imgView = [CreateViewFactory p_setImageViewScaleAspectFitImageName:@"icon_center_point"];
    imgView.frame = CGRectMake(10, 140, 24, 24);
    [self.view addSubview:imgView];
    
    [UIView animateKeyframesWithDuration:1.5 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        CGRect iconFrame = imgView.frame;
        iconFrame.origin.y = 240;
        imgView.frame = iconFrame;
    } completion:^(BOOL finished) {
        [self p_setupAnimateFive];
    }];
}

// 动画5
- (void)p_setupAnimateFive {
    
    UIImageView *imgView = [CreateViewFactory p_setImageViewScaleAspectFitImageName:@"icon_center_point"];
    imgView.frame = CGRectMake(10, 240, 24, 24);
    [self.view addSubview:imgView];
    
    [UIView animateWithDuration:2 delay:0.5 usingSpringWithDamping:0.3 initialSpringVelocity:0.5 options:UIViewAnimationOptionLayoutSubviews animations:^{
        CGRect iconFrame = imgView.frame;
        iconFrame.origin.y = 400;
//        iconFrame.origin.x = 100;
        imgView.frame = iconFrame;
    } completion:^(BOOL finished) {
        
    }];
}


@end
