//
//  PieItemModel.h
//  AllDemo
//
//  Created by LHWen on 2018/9/14.
//  Copyright © 2018年 yuhui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PieItemModel : NSObject

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGFloat value;

+ (NSArray *)modelData;

@end
