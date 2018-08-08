//
//  SwitchModel.m
//  AllDemo
//
//  Created by LHWen on 2018/8/8.
//  Copyright © 2018年 yuhui. All rights reserved.
//

#import "SwitchModel.h"

@implementation SwitchModel

- (instancetype)initWithTitle:(NSString *)title isOpen:(BOOL)open {
    self = [super init];
    if (self) {
        _title = [title copy];
        _open = open;
    }
    return self;
}

+ (NSArray *)getSwitchArray {
    
    return [@[
              [[SwitchModel alloc] initWithTitle:@"第一项" isOpen:YES],
              [[SwitchModel alloc] initWithTitle:@"第二项" isOpen:YES],
              [[SwitchModel alloc] initWithTitle:@"第三项" isOpen:YES],
              [[SwitchModel alloc] initWithTitle:@"第四项" isOpen:YES],
              [[SwitchModel alloc] initWithTitle:@"第五项" isOpen:YES],
              [[SwitchModel alloc] initWithTitle:@"第六项" isOpen:YES],
              [[SwitchModel alloc] initWithTitle:@"第七项" isOpen:YES],
              [[SwitchModel alloc] initWithTitle:@"第八项" isOpen:YES]
             ] copy];
}

@end
