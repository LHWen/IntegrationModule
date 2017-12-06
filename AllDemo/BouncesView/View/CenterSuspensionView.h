//
//  CenterSuspensionView.h
//  AllDemo
//
//  Created by LHWen on 2017/12/6.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import <UIKit/UIKit.h>

// 中间视图

typedef void (^completeAnimate)(BOOL complete);

@interface CenterSuspensionView : UIView

@property (nonatomic, copy) completeAnimate completeAnimate;

@end
