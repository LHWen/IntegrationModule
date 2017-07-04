//
//  ShufflingCollectionViewCell.m
//  AllDemo
//
//  Created by yuhui on 17/1/18.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "ShufflingCollectionViewCell.h"

@implementation ShufflingCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupLayout];
    }
    return self;
}

- (void)p_setupLayout {
    [self p_setupImageView];
}

- (void)p_setupImageView {
    
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(0);
        }];
    }
}

@end
