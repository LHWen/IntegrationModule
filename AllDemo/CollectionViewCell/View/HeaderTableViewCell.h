//
//  HeaderTableViewCell.h
//  AllDemo
//
//  Created by yuhui on 17/1/17.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderTableViewCell : UITableViewCell

@property (nonatomic, strong) UICollectionView *pageCollectionView;

/**
 *  设置数据源
 */
- (void)setWithItemArr:(NSArray <UIImage *>*)items;

/**
 *  设置文字
 */
- (void)setWithItemArrStr:(NSArray <NSString *>*)itemStr;

@end
