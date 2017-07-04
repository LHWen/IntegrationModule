//
//  SimpleCollectionViewCell.m
//  TestCollectionView
//
//  Created by yuhui on 16/11/25.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import "SimpleCollectionViewCell.h"

@implementation SimpleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
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
            make.top.mas_equalTo(5);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-5);
        }];
    }
}

@end
