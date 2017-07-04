//
//  WaterCollectionViewCell.m
//  TestCollectionView
//
//  Created by yuhui on 16/11/28.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import "WaterCollectionViewCell.h"

@implementation WaterCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setImageViewLayout];
        [self setTitleLableLayout];
    }
    return self;
}

- (void)setImageViewLayout {
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-20);
        }];

    }
}

- (void)setTitleLableLayout {
    
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.backgroundColor = [UIColor greenColor];
        _titleLable.font = [UIFont systemFontOfSize:17];
        _titleLable.textColor = [UIColor redColor];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLable];
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imageView.mas_bottom);
            make.left.right.bottom.mas_equalTo(0);
        }];
    }
}

@end
