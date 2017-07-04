//
//  RightTableViewCell.h
//  testTableViewGroup
//
//  Created by yuhui on 16/8/24.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FoodModel;
//#define kCellIdentifier_Left @"LeftTableViewCell"
#define kCellIdentifier_Right @"RightTableViewCell"

@interface RightTableViewCell : UITableViewCell

@property (nonatomic, strong) FoodModel *model;

@end
