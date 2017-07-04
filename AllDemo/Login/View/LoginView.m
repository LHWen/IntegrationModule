//
//  LoginView.m
//  AllDemo
//
//  Created by yuhui on 16/12/27.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self setupInitView];
    }
    return self;
}

- (void)setupInitView {
    
    [self p_setBGView];
}

- (void)p_setBGView {
    
    UIImageView *backgroundViewImg = [CreateViewFactory p_setImageViewScaleAspectFillImageName:@"mainImage"];
    backgroundViewImg.userInteractionEnabled = YES;
    [backgroundViewImg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoMainViewController:)]];
    [self addSubview:backgroundViewImg];
    [backgroundViewImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
}

- (void)gotoMainViewController:(UITapGestureRecognizer *)tap {
    
    if ([self.delegate respondsToSelector:@selector(changeRootView)]) {

        [self.delegate changeRootView];
    }
}

@end
