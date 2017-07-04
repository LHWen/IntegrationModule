//
//  WaterCollectionViewLayout.h
//  TestCollectionView
//
//  Created by yuhui on 16/11/28.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const W_UICollectionElementKindSectionHeader;
UIKIT_EXTERN NSString *const W_UICollectionElementKindSectionFooter;

@class WaterCollectionViewLayout;

@protocol WaterCollectionViewLayoutDelegate <NSObject>

//代理取cell 的高
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(WaterCollectionViewLayout *)layout heightOfItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth;

//处理移动相关的数据源
//- (void)moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath;

@end

@interface WaterCollectionViewLayout : UICollectionViewLayout

@property (assign, nonatomic) NSInteger numberOfColumns;      // 瀑布流有列
@property (assign, nonatomic) CGFloat cellDistance;           // cell之间的间距
@property (assign, nonatomic) CGFloat topAndBottomDustance;   // cell 到顶部 底部的间距
@property (assign, nonatomic) CGFloat headerViewHeight;       // 头视图的高度
@property (assign, nonatomic) CGFloat footViewHeight;         // 尾视图的高度

@property(nonatomic, weak) id<WaterCollectionViewLayoutDelegate> delegate;

@end
