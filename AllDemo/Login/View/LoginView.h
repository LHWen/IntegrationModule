//
//  LoginView.h
//  AllDemo
//
//  Created by yuhui on 16/12/27.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewDelegate <NSObject>

- (void)changeRootView;

@end

@interface LoginView : UIView

@property (nonatomic, weak) id<LoginViewDelegate> delegate;

@end
