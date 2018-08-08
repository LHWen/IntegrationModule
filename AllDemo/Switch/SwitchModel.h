//
//  SwitchModel.h
//  AllDemo
//
//  Created by LHWen on 2018/8/8.
//  Copyright © 2018年 yuhui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SwitchModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign, getter=isOpen) BOOL open;

- (instancetype)initWithTitle:(NSString *)title isOpen:(BOOL)open;

+ (NSArray *)getSwitchArray;

@end
