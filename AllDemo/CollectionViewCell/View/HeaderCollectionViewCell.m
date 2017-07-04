//
//  HeaderCollectionViewCell.m
//  AllDemo
//
//  Created by yuhui on 17/1/17.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "HeaderCollectionViewCell.h"

@implementation HeaderCollectionViewCell 

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupLayout];
    }
    return self;
}

- (void)p_setupLayout {
    [self p_setupImageView];
    [self p_setupTitleLable];
}

- (void)p_setupImageView {
    
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-20);
        }];
    }
}

- (void)p_setupTitleLable {
    
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.font = [UIFont systemFontOfSize:14.0f];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_titleLbl];
        [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.top.equalTo(_imgView.mas_bottom).offset(3);
        }];
    }
}

@end
