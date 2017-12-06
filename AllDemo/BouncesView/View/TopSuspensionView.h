//
//  TopSuspensionView.h
//  AllDemo
//
//  Created by LHWen on 2017/12/5.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import <UIKit/UIKit.h>

// 顶部弹框 顶部视图内容未填充
typedef void (^completeAnimate)(BOOL complete);

@interface TopSuspensionView : UIView

@property (nonatomic, copy) completeAnimate completeAnimate;

@end
