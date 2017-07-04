//
//  ShufflingTableViewCell.h
//  AllDemo
//
//  Created by yuhui on 17/1/18.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShufflingTableViewCell : UITableViewCell

@property (nonatomic, strong) UICollectionView *pageCollectionView;

/**
 *  设置数据源
 */
- (void)setWithItemArr:(NSArray <UIImage *>*)items;

@property (nonatomic, strong) NSTimer *timer;

@end
