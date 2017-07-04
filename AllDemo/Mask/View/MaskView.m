//
//  MaskView.m
//  AllDemo
//
//  Created by yuhui on 16/12/27.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import "MaskView.h"

@implementation MaskView

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    UILabel *alertLable = [CreateViewFactory p_setLableText:@"可自己添加视图在新建的window上\n但是在选择让视图消失的时候\n需将添加的视图与新建的window一起移除"
                                            textFont:15
                                           textColor:[UIColor redColor]
                                             bgColor:[UIColor clearColor]
                                       textAlignment:NSTextAlignmentCenter
                                       numberOfLines:0];
    
    [self addSubview:alertLable];
    [alertLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self);
    }];
}

@end
