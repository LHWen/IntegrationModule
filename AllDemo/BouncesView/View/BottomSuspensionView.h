//
//  BottomSuspensionView.h
//  AllDemo
//
//  Created by LHWen on 2017/12/5.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import <UIKit/UIKit.h>

// 底部视图

typedef void (^completeAnimate)(BOOL complete);

@interface BottomSuspensionView : UIView

@property (nonatomic, copy) completeAnimate completeAnimate;

@end
