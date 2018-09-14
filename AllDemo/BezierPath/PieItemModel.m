//
//  PieItemModel.m
//  AllDemo
//
//  Created by LHWen on 2018/9/14.
//  Copyright © 2018年 yuhui. All rights reserved.
//

#import "PieItemModel.h"

@implementation PieItemModel

+ (NSArray *)modelData {
    
    PieItemModel *item1 = [[PieItemModel alloc]init];
    item1.color = [UIColor redColor];
    item1.value = 0.17;
    
    PieItemModel *item2 = [[PieItemModel alloc]init];
    item2.color = [UIColor greenColor];
    item2.value = 0.19;
    
    PieItemModel *item3 = [[PieItemModel alloc]init];
    item3.color = [UIColor blueColor];
    item3.value = 0.14;
    
    PieItemModel *item4 = [[PieItemModel alloc]init];
    item4.color = [UIColor purpleColor];
    item4.value = 0.1;
    
    PieItemModel *item5 = [[PieItemModel alloc]init];
    item5.color = [UIColor yellowColor];
    item5.value = 0.4;
    
    return @[item1,item2,item3,item4,item5];
}

@end
