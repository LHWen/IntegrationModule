//
//  TopSuspensionView.m
//  AllDemo
//
//  Created by LHWen on 2017/12/5.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "TopSuspensionView.h"

@interface TopSuspensionView ()

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *showView;

@end

@implementation TopSuspensionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
        
        return self;
    }
    return nil;
}

- (void)setup {
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    
    [self setupMaskView];
}

- (void)setupMaskView {
    
    if (!_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.frame = self.bounds;
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
        [_maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewTap:)]];
        [self addSubview:_maskView];
        
        [self setupTopView];
    }
}

- (void)maskViewTap:(UITapGestureRecognizer *)tap {
    
    [UIView animateWithDuration:0.3f animations:^{
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
        _showView.frame = CGRectMake(0, -240.0f, self.bounds.size.width, 240.0f);
    } completion:^(BOOL finished) {
        self.completeAnimate(YES);
    }];
}

- (void)setupTopView {
    
    if (!_showView) {
        _showView = [[UIView alloc] initWithFrame:CGRectMake(0, -240.0f, self.bounds.size.width, 240.0f)];
        _showView.backgroundColor = [UIColor orangeColor];
        [self addSubview:_showView];
        
        [self startAnimate];
    }
}

- (void)startAnimate {
    
    [UIView animateWithDuration:0.3 animations:^{
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
        _showView.frame = CGRectMake(0, 0, self.bounds.size.width, 240.0f);
    }];
}

@end
