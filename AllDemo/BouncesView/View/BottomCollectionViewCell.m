//
//  BottomCollectionViewCell.m
//  AllDemo
//
//  Created by LHWen on 2017/12/5.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "BottomCollectionViewCell.h"

@implementation BottomCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.layer.cornerRadius = frame.size.width / 2;
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor greenColor].CGColor;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor lightGrayColor];
        
        [self setTitleLableLayout];
    }
    return self;
}

- (void)setTitleLableLayout {
    
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.backgroundColor = [UIColor clearColor];
        _titleLable.font = [UIFont systemFontOfSize:20];
        _titleLable.textColor = [UIColor blackColor];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLable];
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(self);
        }];
    }
}

@end
