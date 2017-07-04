//
//  WaterCollectionViewLayout.m
//  TestCollectionView
//
//  Created by yuhui on 16/11/28.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import "WaterCollectionViewLayout.h"

NSString *const W_UICollectionElementKindSectionHeader = @"W_HeadView";
NSString *const W_UICollectionElementKindSectionFooter = @"W_FootView";

@interface WaterCollectionViewLayout ()

@property (strong, nonatomic) NSMutableDictionary *cellLayoutInfo; // 保存cell的布局
@property (strong, nonatomic) NSMutableDictionary *headLayoutInfo; // 保存头视图的布局
@property (strong, nonatomic) NSMutableDictionary *footLayoutInfo; // 保存尾视图的布局

@property (assign, nonatomic) CGFloat startY;                      // 记录开始的Y
@property (strong, nonatomic) NSMutableDictionary *maxYForColumn;  // 记录瀑布流每列最下面那个cell的底部y值
@property (strong, nonatomic) NSMutableArray *shouldanimationArr;  // 记录需要添加动画的NSIndexPath

@end

@implementation WaterCollectionViewLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.numberOfColumns = 3;
        self.topAndBottomDustance = 10;
        self.cellDistance = 10;
        _headerViewHeight = 0;
        _footViewHeight = 0;
        self.startY = 0;
        self.maxYForColumn = [NSMutableDictionary dictionary];
        self.shouldanimationArr = [NSMutableArray array];
        self.cellLayoutInfo = [NSMutableDictionary dictionary];
        self.headLayoutInfo = [NSMutableDictionary dictionary];
        self.footLayoutInfo = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    //重新布局需要清空
    [self.cellLayoutInfo removeAllObjects];
    [self.headLayoutInfo removeAllObjects];
    [self.footLayoutInfo removeAllObjects];
    [self.maxYForColumn removeAllObjects];
    self.startY = 0;
    
    
    CGFloat viewWidth = self.collectionView.frame.size.width;
    //代理里面只取了高度，所以cell的宽度有列数还有cell的间距计算出来
    CGFloat itemWidth = (viewWidth - self.cellDistance*(self.numberOfColumns + 1))/self.numberOfColumns;
    
    //取有多少个section
    NSInteger sectionsCount = [self.collectionView numberOfSections];
    
    for (NSInteger section = 0; section < sectionsCount; section++) {
        //存储headerView属性
        NSIndexPath *supplementaryViewIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
        //头视图的高度不为0并且根据代理方法能取到对应的头视图的时候，添加对应头视图的布局对象
        if (_headerViewHeight>0 && [self.collectionView.dataSource respondsToSelector:@selector(collectionView: viewForSupplementaryElementOfKind: atIndexPath:)]) {
            
            UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:W_UICollectionElementKindSectionHeader withIndexPath:supplementaryViewIndexPath];
            //设置frame
            attribute.frame = CGRectMake(0, self.startY, self.collectionView.frame.size.width, _headerViewHeight);
            //保存布局对象
            self.headLayoutInfo[supplementaryViewIndexPath] = attribute;
            //设置下个布局对象的开始Y值
            self.startY = self.startY + _headerViewHeight + _topAndBottomDustance;
        }else{
            //没有头视图的时候，也要设置section的第一排cell到顶部的距离
            self.startY += _topAndBottomDustance;
        }
        
        //将Section第一排cell的frame的Y值进行设置
        for (int i = 0; i < _numberOfColumns; i++) {
            self.maxYForColumn[@(i)] = @(self.startY);
        }
        
        
        //计算cell的布局
        //取出section有多少个row
        NSInteger rowsCount = [self.collectionView numberOfItemsInSection:section];
        //分别计算设置每个cell的布局对象
        for (NSInteger row = 0; row < rowsCount; row++) {
            NSIndexPath *cellIndePath =[NSIndexPath indexPathForItem:row inSection:section];
            UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:cellIndePath];
            
            //计算当前的cell加到哪一列（瀑布流是加载到最短的一列）
            CGFloat y = [self.maxYForColumn[@(0)] floatValue];
            NSInteger currentRow = 0;
            for (int i = 1; i < _numberOfColumns; i++) {
                if ([self.maxYForColumn[@(i)] floatValue] < y) {
                    y = [self.maxYForColumn[@(i)] floatValue];
                    currentRow = i;
                }
            }
            //计算x值
            CGFloat x = self.cellDistance + (self.cellDistance + itemWidth)*currentRow;
            //根据代理去当前cell的高度  因为当前是采用通过列数计算的宽度，高度根据图片的原始宽高比进行设置的
            CGFloat height = [(id<WaterCollectionViewLayoutDelegate>)self.delegate collectionView:self.collectionView layout:self heightOfItemAtIndexPath:cellIndePath itemWidth:itemWidth];
            //设置当前cell布局对象的frame
            attribute.frame = CGRectMake(x, y, itemWidth, height);
            //重新设置当前列的Y值
            y = y + self.cellDistance + height;
            self.maxYForColumn[@(currentRow)] = @(y);
            //保留cell的布局对象
            self.cellLayoutInfo[cellIndePath] = attribute;
            
            //当是section的最后一个cell是，取出最后一排cell的底部Y值   设置startY 决定下个视图对象的起始Y值
            if (row == rowsCount -1) {
                CGFloat maxY = [self.maxYForColumn[@(0)] floatValue];
                for (int i = 1; i < _numberOfColumns; i++) {
                    if ([self.maxYForColumn[@(i)] floatValue] > maxY) {
                        NSLog(@"%f", [self.maxYForColumn[@(i)] floatValue]);
                        maxY = [self.maxYForColumn[@(i)] floatValue];
                    }
                }
                self.startY = maxY - self.cellDistance + self.topAndBottomDustance;
            }
        }
        
        
        //存储footView属性
        //尾视图的高度不为0并且根据代理方法能取到对应的尾视图的时候，添加对应尾视图的布局对象
        if (_footViewHeight>0 && [self.collectionView.dataSource respondsToSelector:@selector(collectionView: viewForSupplementaryElementOfKind: atIndexPath:)]) {
            
            UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:W_UICollectionElementKindSectionFooter withIndexPath:supplementaryViewIndexPath];
            
            attribute.frame = CGRectMake(0, self.startY, self.collectionView.frame.size.width, _footViewHeight);
            self.footLayoutInfo[supplementaryViewIndexPath] = attribute;
            self.startY = self.startY + _footViewHeight;
        }
        
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray array];
    
    //添加当前屏幕可见的cell的布局
    [self.cellLayoutInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attribute, BOOL *stop) {
        if (CGRectIntersectsRect(rect, attribute.frame)) {
            [allAttributes addObject:attribute];
        }
    }];
    
    //添加当前屏幕可见的头视图的布局
    [self.headLayoutInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attribute, BOOL *stop) {
        if (CGRectIntersectsRect(rect, attribute.frame)) {
            [allAttributes addObject:attribute];
        }
    }];
    
    //添加当前屏幕可见的尾部的布局
    [self.footLayoutInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attribute, BOOL *stop) {
        if (CGRectIntersectsRect(rect, attribute.frame)) {
            [allAttributes addObject:attribute];
        }
    }];
    
    return allAttributes;
}

//插入cell的时候系统会调用改方法
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribute = self.cellLayoutInfo[indexPath];
    return attribute;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribute = nil;
    if ([elementKind isEqualToString:W_UICollectionElementKindSectionHeader]) {
        attribute = self.headLayoutInfo[indexPath];
    }else if ([elementKind isEqualToString:W_UICollectionElementKindSectionFooter]){
        attribute = self.footLayoutInfo[indexPath];
    }
    return attribute;
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.collectionView.frame.size.width, MAX(self.startY, self.collectionView.frame.size.height));
}

- (void)prepareForCollectionViewUpdates:(NSArray *)updateItems
{
    [super prepareForCollectionViewUpdates:updateItems];
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (UICollectionViewUpdateItem *updateItem in updateItems) {
        switch (updateItem.updateAction) {
            case UICollectionUpdateActionInsert:
                [indexPaths addObject:updateItem.indexPathAfterUpdate];
                break;
            case UICollectionUpdateActionDelete:
                [indexPaths addObject:updateItem.indexPathBeforeUpdate];
                break;
            case UICollectionUpdateActionMove:
                //                [indexPaths addObject:updateItem.indexPathBeforeUpdate];
                //                [indexPaths addObject:updateItem.indexPathAfterUpdate];
                break;
            default:
                NSLog(@"unhandled case: %@", updateItem);
                break;
        }
    }
    self.shouldanimationArr = indexPaths;
}

//对应UICollectionViewUpdateItem 的indexPathBeforeUpdate 设置调用
- (UICollectionViewLayoutAttributes*)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    
    if ([self.shouldanimationArr containsObject:itemIndexPath]) {
        UICollectionViewLayoutAttributes *attr = self.cellLayoutInfo[itemIndexPath];
        
        attr.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.2, 0.2), M_PI);
        attr.center = CGPointMake(CGRectGetMidX(self.collectionView.bounds), CGRectGetMaxY(self.collectionView.bounds));
        attr.alpha = 1;
        [self.shouldanimationArr removeObject:itemIndexPath];
        return attr;
    }
    return nil;
}

//对应UICollectionViewUpdateItem 的indexPathAfterUpdate 设置调用
- (nullable UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    if ([self.shouldanimationArr containsObject:itemIndexPath]) {
        UICollectionViewLayoutAttributes *attr = self.cellLayoutInfo[itemIndexPath];
        
        attr.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(2, 2), 0);
        //        attr.center = CGPointMake(CGRectGetMidX(self.collectionView.bounds), CGRectGetMaxY(self.collectionView.bounds));
        attr.alpha = 0;
        [self.shouldanimationArr removeObject:itemIndexPath];
        return attr;
    }
    return nil;
}

- (void)finalizeCollectionViewUpdates
{
    self.shouldanimationArr = nil;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    
    CGRect oldBounds = self.collectionView.bounds;
    if (!CGSizeEqualToSize(oldBounds.size, newBounds.size)) {
        return YES;
    }
    return NO;
    
    //
    //    return YES;
}

//移动相关
//- (UICollectionViewLayoutInvalidationContext *)invalidationContextForInteractivelyMovingItems:(NSArray<NSIndexPath *> *)targetIndexPaths withTargetPosition:(CGPoint)targetPosition previousIndexPaths:(NSArray<NSIndexPath *> *)previousIndexPaths previousPosition:(CGPoint)previousPosition NS_AVAILABLE_IOS(9_0)
//{
//    UICollectionViewLayoutInvalidationContext *context = [super invalidationContextForInteractivelyMovingItems:targetIndexPaths withTargetPosition:targetPosition previousIndexPaths:previousIndexPaths previousPosition:previousPosition];
//    
//    if([self.delegate respondsToSelector:@selector(moveItemAtIndexPath: toIndexPath:)]){
//        [self.delegate moveItemAtIndexPath:previousIndexPaths[0] toIndexPath:targetIndexPaths[0]];
//    }
//    return context;
//}
//
//- (UICollectionViewLayoutInvalidationContext *)invalidationContextForEndingInteractiveMovementOfItemsToFinalIndexPaths:(NSArray<NSIndexPath *> *)indexPaths previousIndexPaths:(NSArray<NSIndexPath *> *)previousIndexPaths movementCancelled:(BOOL)movementCancelled NS_AVAILABLE_IOS(9_0)
//{
//    UICollectionViewLayoutInvalidationContext *context = [super invalidationContextForEndingInteractiveMovementOfItemsToFinalIndexPaths:indexPaths previousIndexPaths:previousIndexPaths movementCancelled:movementCancelled];
//    
//    if(!movementCancelled){
//        
//    }
//    return context;
//}

@end
