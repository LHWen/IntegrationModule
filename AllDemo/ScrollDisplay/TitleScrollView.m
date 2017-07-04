//
//  TitleScrollView.m
//  AllDemo
//
//  Created by yuhui on 17/1/5.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "TitleScrollView.h"

#define kRGBColor(R,G,B)      [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

@interface TitleScrollView ()

/** 线 */
@property(nonatomic,strong) UIView *lineView;

@property (nonatomic, strong) NSArray *titlesArray;

@property (nonatomic, strong) UIColor *normalTitleColor;   // 正常颜色
@property (nonatomic, strong) UIColor *selectTitleColor;   // 选中颜色
@property (nonatomic, strong) UIColor *lineViewColor;      // 线条颜色

@end

@implementation TitleScrollView

- (instancetype)initWithTitles:(NSArray *)titles
              NormalTitleColor:(UIColor *)normalTitleColor
              SelectTitleColor:(UIColor *)selectTitleColor
                 LineViewColor:(UIColor *)lineViewColor {
    
    if (self = [super init]) {
        _titlesArray = [titles copy];
        _normalTitleColor = normalTitleColor;
        _selectTitleColor = selectTitleColor;
        _lineViewColor = lineViewColor;
        
        //隐藏滚动视图中的滚动条
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = kRGBColor(59, 59, 59);
        [self setButton];
    }
    return self;
}

- (void)setButton {
    
    //指向最新添加的按钮
    UIView *latestView = nil;
    //通过for循环添加按钮
    for (int i = 0; i < _titlesArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:0];
        [btn setTitle:_titlesArray[i] forState:0];
        
        if (_normalTitleColor) {
            [btn setTitleColor:_normalTitleColor forState:UIControlStateNormal];
        }else {
            [btn setTitleColor:kRGBColor(185, 199, 224) forState:UIControlStateNormal];
        }
        
        if (_selectTitleColor) {
            [btn setTitleColor:_selectTitleColor forState:UIControlStateSelected];
        }else {
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        }
        // 选中 按钮背景颜色
        [btn setBackgroundImage:[Utility createImageWithColor:[UIColor yellowColor]] forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            _currentBtn = btn;
            btn.selected = YES;
        }
        
        [self addSubview:btn];
        
        //开始按钮布局
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (_titlesArray.count < 4) {
                make.size.mas_equalTo(CGSizeMake(kSCREENWIDTH/_titlesArray.count, 44));
            }else {
                make.size.mas_equalTo(CGSizeMake(kSCREENWIDTH/4, 44));
            }
            make.centerY.mas_equalTo(self);
            if (latestView) { //表示已经添加过按钮
                make.left.mas_equalTo(latestView.mas_right).mas_equalTo(0);
            }else{
                make.left.mas_equalTo(0);
            }
        }];
        latestView = btn;
        //将创建的按钮添加到数组
        [self.btns addObject:btn];
    }
    //lastView肯定是最后一个按钮，最后一个按钮的x轴 肯定是固定的，当我们设置按钮的右边缘距离父视图ContentView的右边缘 0像素
    //那么滚动视图的内容区域就会被锁定了
    [latestView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
    }];
    
    //如果有线存在，就添加线的约束
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kSCREENWIDTH/6);
        make.height.mas_equalTo(2);
        UIButton *btn=_btns[0];
        make.centerX.mas_equalTo(btn);
        make.top.mas_equalTo(btn.mas_bottom).mas_equalTo(-2);
    }];
    
}

- (void)selectButton:(UIButton *)sender {
    if (_currentBtn != sender) {
        _currentBtn.selected = NO;
        sender.selected = YES;
        _currentBtn = sender;

        if ([self.delegatet respondsToSelector:@selector(sendButtonSender:)]) {
            [self.delegatet sendButtonSender:[_btns indexOfObject:sender]];
        }
       
        [self updateLineViewLayout];
        [self updateCenterButton:_currentBtn];
    }
}

// 改变线条布局
- (void)updateLineViewLayout {
    
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kSCREENWIDTH/6);
        make.height.mas_equalTo(2);
        make.centerX.mas_equalTo(_currentBtn);
        make.top.equalTo(_currentBtn.mas_bottom).offset(-2);
    }];

}

// 选中按钮或者视图滑动蒋能滑动到中间的按钮滑动到中间显示
- (void)updateCenterButton:(UIButton *)button {
    CGFloat width = self.frame.size.width;
    
    CGPoint titleOffset = self.contentOffset;
    //计算公式:对应的label的中心X值 - scrollView宽度的一半
    titleOffset.x = button.center.x - width * 0.5;
    
    /** 左边超出处理*/
    if (titleOffset.x < 0) titleOffset.x = 0;
    
    /** 右边超出处理*/
    CGFloat maxTitleOffsetX = self.contentSize.width - width;
    if (titleOffset.x > maxTitleOffsetX) titleOffset.x = maxTitleOffsetX;
    
    [self setContentOffset:titleOffset animated:YES];
}

#pragma mark - 可变数组的懒加载btns
- (NSMutableArray *)btns{
    if (!_btns) {
        _btns=[NSMutableArray new];
    }
    return _btns;
}

// 线条
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        
        if (_lineViewColor) {
           _lineView.backgroundColor = _lineViewColor;
        }else {
            _lineView.backgroundColor = kRGBColor(72, 134, 246);
        }
    }
    return _lineView;
}


@end
