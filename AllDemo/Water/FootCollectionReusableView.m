//
//  FootCollectionReusableView.m
//  TestCollectionView
//
//  Created by yuhui on 16/11/28.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import "FootCollectionReusableView.h"

@implementation FootCollectionReusableView

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        UILabel *lable = [[UILabel alloc] init];
        lable.text = @"foot";
        lable.font = [UIFont systemFontOfSize:17];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = [UIColor blackColor];
        lable.backgroundColor = [UIColor blueColor];
        [self addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

@end
