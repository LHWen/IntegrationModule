//
//  CategoryModel.m
//  testTableViewGroup
//
//  Created by yuhui on 16/8/24.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel

+ (NSDictionary *)objectClassInArray
{
    return @{ @"spus": @"FoodModel" };
}

@end

@implementation FoodModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{ @"foodId": @"id" };
}

@end