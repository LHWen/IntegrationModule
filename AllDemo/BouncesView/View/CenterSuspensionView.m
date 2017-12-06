//
//  CenterSuspensionView.m
//  AllDemo
//
//  Created by LHWen on 2017/12/6.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "CenterSuspensionView.h"

@interface CenterSuspensionView ()

@property (nonatomic, strong) UIView *showView;

@end

@implementation CenterSuspensionView

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
    
    [self setupTopView];
}

- (void)setupTopView {
    
    if (!_showView) {
        _showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 240, 116.0f)];
        _showView.center = CGPointMake(self.center.x, - (self.center.y + 58.0f));
        _showView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_showView];
        
        UIView *messageView = [CreateViewFactory p_setViewBGColor:[UIColor whiteColor]];
        [_showView addSubview:messageView];
        [messageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(_showView);
            make.bottom.equalTo(@(-40.0f));
        }];
        
        UILabel *messageLable = [CreateViewFactory p_setLableWhiteBGColorOneLineLeftText:@"提示语视图"
                                                                                textFont:15.0f
                                                                               textColor:[Utility colorWithHexString:@"#333333"]];
        messageLable.textAlignment = NSTextAlignmentCenter;
        messageLable.numberOfLines = 0;
        [messageView addSubview:messageLable];
        [messageLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(messageView);
            make.left.equalTo(@30.0f);
            make.right.equalTo(@(-30.0f));
        }];
        
        UIButton *cancelBtn = [self p_setupButtonTitle:@"取消"];
        [cancelBtn addTarget:self action:@selector(cancelTapView) forControlEvents:UIControlEventTouchUpInside];
        [_showView addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.equalTo(_showView);
            make.top.equalTo(messageView.mas_bottom).offset(0.5f);
            make.width.equalTo(@119.75f);
        }];
        
        UIButton *sureBtn = [self p_setupButtonTitle:@"确定"];
        [sureBtn addTarget:self action:@selector(sureTapView) forControlEvents:UIControlEventTouchUpInside];
        [_showView addSubview:sureBtn];
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.equalTo(_showView);
            make.top.equalTo(messageView.mas_bottom).offset(0.5f);
            make.width.equalTo(@119.75f);
        }];
        
        [self startAnimate];
    }
}

- (UIButton *)p_setupButtonTitle:(NSString *)title {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [btn setBackgroundImage:[Utility createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [btn setBackgroundImage:[Utility createImageWithColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[Utility colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    
    return btn;
}

- (void)cancelTapView {
    
     [self dissmissView];
}

- (void)sureTapView {
    
     [self dissmissView];
}

- (void)startAnimate {
    
    _showView.transform = CGAffineTransformMakeScale(0, 1.0);
    
//    [UIView animateWithDuration:0.3 animations:^{
//        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
//        _showView.transform = CGAffineTransformMakeScale(1.0, 1.0);
//        _showView.center = self.center;
//    }];
    
//    [UIView animateWithDuration:0.3 animations:^{
//        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
//        _showView.center = self.center;
//    } completion:^(BOOL finished) {
//        _showView.transform = CGAffineTransformMakeScale(1.0, 1.0);        
//    }];
    
//    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
//        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
//        _showView.center = self.center;
//        _showView.transform = CGAffineTransformMakeScale(0.1, 1.0);
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.2 animations:^{
//            _showView.transform = CGAffineTransformMakeScale(1.0, 1.0);
//        }];
//    }];
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.7 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
        _showView.center = self.center;
        _showView.transform = CGAffineTransformMakeScale(0.1, 1.0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            _showView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }];
}

- (void)dissmissView {
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _showView.transform = CGAffineTransformMakeRotation(-0.25);
        _showView.center = CGPointMake(self.center.x, self.center.y + 25.0f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
            _showView.center = CGPointMake(self.center.x, self.bounds.size.height + 58.0f);
            _showView.alpha = 0.3f;
        } completion:^(BOOL finished) {
            self.completeAnimate(YES);
        }];
    }];
}

@end
