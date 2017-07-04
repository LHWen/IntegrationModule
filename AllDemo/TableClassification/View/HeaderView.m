//
//  HeaderView.m
//  testTableViewGroup
//
//  Created by yuhui on 16/8/24.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:244/255.0 alpha:0.9];
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 20)];
        self.name.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.name];
    }
    return self;
}

@end
