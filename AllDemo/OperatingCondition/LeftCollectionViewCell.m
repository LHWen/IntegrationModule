//
//  LeftCollectionViewCell.m
//  AllDemo
//
//  Created by yuhui on 17/6/22.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "LeftCollectionViewCell.h"

@implementation LeftCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        UILabel *lable = [[UILabel alloc] init];
        lable.text = @"Left";
        lable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(bgView);
        }];
        
    }
    return self;
}

@end
