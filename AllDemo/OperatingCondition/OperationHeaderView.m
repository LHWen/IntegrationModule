//
//  OperationHeaderView.m
//  AllDemo
//
//  Created by yuhui on 17/6/22.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "OperationHeaderView.h"
#import "LeftCollectionViewCell.h"
#import "RightCollectionViewCell.h"

static NSString *const kLeftCollectionViewCell = @"LeftCollectionViewCell";
static NSString *const kRightCollectionViewCell = @"RightCollectionViewCell";

@interface OperationHeaderView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;

@end

@implementation OperationHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
        self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.flowLayout.minimumInteritemSpacing = 13;  // 左右中间间隔距离
        self.flowLayout.minimumLineSpacing = 5;       // 选项间上下距离间距
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) collectionViewLayout:self.flowLayout];
        self.collectionView.backgroundColor = [UIColor blueColor];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        
        [self.collectionView registerClass:[LeftCollectionViewCell class] forCellWithReuseIdentifier:kLeftCollectionViewCell];
        [self.collectionView registerClass:[RightCollectionViewCell class] forCellWithReuseIdentifier:kRightCollectionViewCell];
        
        [self addSubview:self.collectionView];
        
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    
    if (indexPath.row == 0) {
        
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kLeftCollectionViewCell forIndexPath:indexPath];
    }else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRightCollectionViewCell forIndexPath:indexPath];
    }
    
    
    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.frame.size.width - 20), 160);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

// 设置是否可以选择cell
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

// 设置是否支持高亮
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

// 设置高亮 颜色
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor grayColor];
}

// 取消高亮后 颜色
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor greenColor];
}

// 选择项
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", indexPath.row);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % 2;
    NSLog(@"pageA = %ld", page);
    
    if (page == 0) {
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    }else {
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    NSInteger page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % 2;
//    NSLog(@"pageB = %ld", page);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    NSInteger page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % 2;
    NSLog(@"pageC = %ld", page);
    
    if (page == 0) {
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    }else {
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
}


@end
