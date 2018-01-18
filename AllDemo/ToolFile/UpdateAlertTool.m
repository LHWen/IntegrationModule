//
//  UpdateAlertTool.m
//  AllDemo
//
//  Created by LHWen on 2018/1/18.
//  Copyright © 2018年 yuhui. All rights reserved.
//

#import "UpdateAlertTool.h"

@interface UpdateAlertTool ()

@property (nonatomic, strong) UIView *bgView;  // 背景View
@property (nonatomic, assign) CGFloat messageHeight; // 消息高度 45 + messageHeight + 40 内容视图总高度
@property (nonatomic, strong) NSString *message;   // 记录消息
@property (nonatomic, strong) UIView *alertView;  // 提醒视图 width = 260.0f
@property (nonatomic, strong) NSString *updateString;  // 更新地址

@end

@implementation UpdateAlertTool

+ (UpdateAlertTool *)updateAlertTool {
    
    static dispatch_once_t once;
    static UpdateAlertTool *updateAlertTool;
    dispatch_once(&once, ^{
        updateAlertTool = [[self alloc] init];
    });
    return updateAlertTool;
}

+ (void)updateMessage:(NSString *)message updateAddress:(NSString *)address {
    
    [self updateAlertTool].messageHeight = [[self updateAlertTool] calculateTextHeightWithText:message withWidth:234.0f andTextSize:12.0f];
    [self updateAlertTool].message = message;
    [self updateAlertTool].updateString = address;
    
    [[self updateAlertTool] p_setup];
}

- (void)p_setup {
    
    [self p_setupBgView];
    [self p_setAlertView];
    [self p_mainView];
    [self p_setBottomUpdataView];
    
    [UIView animateKeyframesWithDuration:0.3 delay:0.0 options:0 animations:^{
        
        //  分步动画   第一个参数是该动画开始的百分比时间  第二个参数是该动画持续的百分比时间
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _alertView.alpha = 1.0f;
        
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.1 animations:^{
            _alertView.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.1, 0.1), 0);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.4 animations:^{
            _alertView.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.5, 0.5), 0);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.4 animations:^{
            _alertView.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.8, 0.8), 0);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.9 relativeDuration:0.1 animations:^{
            _alertView.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(1.0, 1.0), 0);
        }];
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)p_setupBgView {
    
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT)];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        [[UIApplication sharedApplication].keyWindow addSubview:_bgView];
    }
}

- (void)p_setAlertView {
    
    if (!_alertView) {
        _alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 260.0f, 85.0f + _messageHeight)];;
        _alertView.center = CGPointMake(kSCREENWIDTH/2.0, kSCREENHEIGHT/2.0);
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius = 10.0f;
        _alertView.layer.masksToBounds = YES;
        _alertView.alpha = 0.0;
        [_bgView addSubview:_alertView];
    }
}

- (void)p_mainView {
    
    UIView *mainView = [[UIView alloc] init];
    mainView.backgroundColor = [UIColor whiteColor];
    [_alertView addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(_alertView);
        make.bottom.equalTo(_alertView.mas_bottom).offset(-40.0f);
    }];
    
    UILabel *titleLable = [self creatLableText:@"更新提醒"
                                     textColor:[Utility colorWithHexString:@"#000000"]
                                 textAlignment:NSTextAlignmentCenter
                                 numberOfLines:1];
    titleLable.font = [UIFont boldSystemFontOfSize:15.0f];
    [mainView addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(mainView);
        make.top.equalTo(mainView.mas_top).offset(16.0f);
    }];
    
    UILabel *messageLable = [self creatLableText:_message
                                       textColor:[Utility colorWithHexString:@"#000000"]
                                   textAlignment:NSTextAlignmentLeft
                                   numberOfLines:0];
    messageLable.font = [UIFont systemFontOfSize:12.0f];
    [mainView addSubview:messageLable];
    [messageLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainView.mas_left).offset(13.0f);
        make.right.equalTo(mainView.mas_right).offset(-13.0f);
        make.top.equalTo(titleLable.mas_bottom).offset(8.0f);
    }];
}

- (UILabel *)creatLableText:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment numberOfLines:(CGFloat)numberOfLines {
    
    UILabel *lable  = [[UILabel alloc] init];
    lable.text = text;
    lable.textColor = textColor;
    lable.backgroundColor = [UIColor whiteColor];
    lable.textAlignment = textAlignment;
    lable.numberOfLines = numberOfLines;
    
    return lable;
}

- (void)p_setBottomUpdataView {
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [Utility colorWithHexString:@"#dedede"];
    [_alertView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(_alertView);
        make.height.equalTo(@40.0f);
    }];
    
    UIButton *updateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [updateBtn setTitle:@"更新" forState:UIControlStateNormal];
    updateBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [updateBtn setTitleColor:[UIColor colorWithRed:(53/255.0f) green:(131/255.0f) blue:(235/255.0f) alpha:1.0] forState:UIControlStateNormal];
    [updateBtn setBackgroundImage:[Utility createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [updateBtn setBackgroundImage:[Utility createImageWithColor:[Utility colorWithHexString:@"#dedede"]] forState:UIControlStateHighlighted];
    [updateBtn addTarget:self action:@selector(updateApp:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:updateBtn];
    [updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(bottomView);
        make.top.equalTo(bottomView.mas_top).offset(0.5f);
    }];
}

- (void)updateApp:(UIButton *)sender {
    
    NSLog(@"此处更新代码");
    
    [UIView animateKeyframesWithDuration:0.3 delay:0.0 options:0 animations:^{
        
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        _alertView.alpha = 0.0f;
        
        //  分步动画   第一个参数是该动画开始的百分比时间  第二个参数是该动画持续的百分比时间
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.1 animations:^{
            _alertView.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.9, 0.9), 0);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.4 animations:^{
            _alertView.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.5, 0.5), 0);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.4 animations:^{
            _alertView.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.2, 0.2), 0);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.9 relativeDuration:0.1 animations:^{
            _alertView.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.1, 0.1), 0);
        }];
        
    } completion:^(BOOL finished) {
        
        [_alertView removeFromSuperview];
        _alertView = nil;
        [_bgView removeFromSuperview];
        _bgView = nil;
    }];
}

// 获取文字高度
- (CGFloat)calculateTextHeightWithText:(NSString *)text withWidth:(CGFloat)width andTextSize:(CGFloat)size {
    NSRange fullRange = NSMakeRange(0, text.length);
    NSMutableParagraphStyle *pstyle = [[NSMutableParagraphStyle alloc] init];
    pstyle.lineBreakMode = NSLineBreakByCharWrapping;
    pstyle.alignment = NSTextAlignmentLeft;
    
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:text];
    [attriString addAttribute:NSParagraphStyleAttributeName value:pstyle range:fullRange];
    [attriString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size] range:fullRange];
    [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:fullRange];
    
    CGRect r = [attriString boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    return r.size.height += 15;
}

@end
