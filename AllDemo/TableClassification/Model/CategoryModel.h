//
//  CategoryModel.h
//  testTableViewGroup
//
//  Created by yuhui on 16/8/24.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, strong) NSArray *spus;

@end

@interface FoodModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *foodId;
@property (nonatomic, copy) NSString *picture;
@property (nonatomic, assign) NSInteger praise_content;
@property (nonatomic, assign) NSInteger month_saled;
@property (nonatomic, assign) float min_price;

@end