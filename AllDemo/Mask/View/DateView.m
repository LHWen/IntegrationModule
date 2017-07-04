//
//  DateView.m
//  AllDemo
//
//  Created by yuhui on 17/1/17.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "DateView.h"

static NSString *const cancelString = @"取消";
static NSString *const titleString  = @"选择日期";
static NSString *const sureString   = @"确定";
static CGFloat const kTopApart = 5.0f;      // 取消lable相距头部
static CGFloat const kLeftApart = 5.0f;     // 取消lable相距左边
static CGFloat const kLableWidth = 60.0f;   // 取消lable宽度
static CGFloat const kLableHeight = 34.0f;  // 取消lable高度

@interface DateView ()

@property (nonatomic, strong) UILabel *cancelLbl;  // 取消lable
@property (nonatomic, strong) UILabel *titleLbl;   // 标题lable
@property (nonatomic, strong) UILabel *sureLbl;    // 确定lable
@property (nonatomic, strong) UIDatePicker *timePicker; // 日期视图

@end

@implementation DateView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self p_setupViewLayout];
    }
    return self;
}

- (void)p_setupViewLayout {
    
    [self p_setupLableLayout];
    [self p_setupTimePickerLayout];
}

// lable布局
- (void) p_setupLableLayout {
    
    [self p_setupCancelLableLayout];
    [self p_setupTitleLableLayout];
    [self p_setupSureLableLayout];
}

- (void)p_setupCancelLableLayout {
    
    if (!_cancelLbl) {
        _cancelLbl = [CreateViewFactory p_setLableWhiteBGColorOneLineText:cancelString
                                                                 textFont:16
                                                                textColor:[UIColor blackColor]
                                                            textAlignment:NSTextAlignmentCenter];
        _cancelLbl.userInteractionEnabled = YES;
        [_cancelLbl addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelTap:)]];
        [self addSubview:_cancelLbl];
        [_cancelLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kTopApart);
            make.left.mas_equalTo(kLeftApart);
            make.width.mas_equalTo(kLableWidth);
            make.height.mas_equalTo(kLableHeight);
        }];
    }
}

- (void)p_setupTitleLableLayout {
    
    if (!_titleLbl) {
        _titleLbl = [CreateViewFactory p_setLableWhiteBGColorOneLineText:titleString
                                                                textFont:16
                                                               textColor:[UIColor blackColor]
                                                           textAlignment:NSTextAlignmentCenter];
        [self addSubview:_titleLbl];
        [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_cancelLbl);
            make.centerX.equalTo(self);
        }];
    }
}

- (void)p_setupSureLableLayout {
    
    if (!_sureLbl) {
        _sureLbl = [CreateViewFactory p_setLableWhiteBGColorOneLineText:sureString
                                                               textFont:16
                                                              textColor:[UIColor blackColor]
                                                          textAlignment:NSTextAlignmentCenter];
        _sureLbl.userInteractionEnabled = YES;
        [_sureLbl addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sureTap:)]];
        [self addSubview:_sureLbl];
        [_sureLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-kLeftApart);
            make.top.width.height.equalTo(_cancelLbl);
        }];
    }
}

// 时间视图布局
- (void)p_setupTimePickerLayout {
    
    if (!_timePicker) {
        _timePicker = [[UIDatePicker alloc] init];
        _timePicker.minimumDate = [NSDate date];
        _timePicker.backgroundColor = [UIColor whiteColor];
        _timePicker.datePickerMode = UIDatePickerModeDateAndTime;
        _timePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [self addSubview:_timePicker];
        [_timePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_cancelLbl.mas_bottom);
            make.left.right.bottom.equalTo(self);
        }];
    }
}

// 取消手势 响应方法
- (void)cancelTap:(UITapGestureRecognizer *)tap {
    
    if ([self.delegate respondsToSelector:@selector(cancelChoose)]) {
        [self.delegate cancelChoose];
    }
}

// 确定手势 响应方法
- (void)sureTap:(UITapGestureRecognizer *)tap {
    
    if ([self.delegate respondsToSelector:@selector(sureChooseTimeString:)]) {
        
        NSString *dateString = [self chooseTimeOfDateFormatter];
        [self.delegate sureChooseTimeString:dateString];
    }
}

// 选择后的时间样式

- (NSString *)chooseTimeOfDateFormatter {
    
    NSDate *select  = [_timePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:select];
    
    return dateString;
}

@end
