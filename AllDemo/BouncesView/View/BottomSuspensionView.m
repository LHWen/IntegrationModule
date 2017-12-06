//
//  BottomSuspensionView.m
//  AllDemo
//
//  Created by LHWen on 2017/12/5.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "BottomSuspensionView.h"
#import "BottomCollectionViewCell.h"

static NSString *const kContentCell = @"BottomCollectionViewCell";

@interface BottomSuspensionView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;

@end

@implementation BottomSuspensionView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
        
        return self;
    }
    return nil;
}

- (void)setup {
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    
    [self setupMaskView];
}

- (void)setupMaskView {
    
    if (!_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.frame = self.bounds;
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
        [_maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewTap:)]];
        [self addSubview:_maskView];
        
        [self p_setupCollectionView];
    }
}

- (void)maskViewTap:(UITapGestureRecognizer *)tap {
    
    [UIView animateWithDuration:0.3f animations:^{
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
        _collectionView.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, ((self.bounds.size.width - 25) / 2 + 15));
    } completion:^(BOOL finished) {
        self.completeAnimate(YES);
    }];
}

- (void)p_setupCollectionView {
    
    if (!_collectionView) {
        
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumInteritemSpacing = 5;  // 左右中间间隔距离
        _flowLayout.minimumLineSpacing = 15;       // 选项间上下距离间距
        
        CGRect rect = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, (self.bounds.size.width - 25) / 2 + 15);
        _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[BottomCollectionViewCell class] forCellWithReuseIdentifier:kContentCell];
        [self addSubview:_collectionView];
        
        [self startAnimate];
    }
}

- (void)startAnimate {
    
    [UIView animateWithDuration:0.3 animations:^{
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
        _collectionView.frame = CGRectMake(0, self.bounds.size.height - ((self.bounds.size.width - 25) / 2 + 15), self.bounds.size.width, (self.bounds.size.width - 25) / 2 + 15);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BottomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kContentCell forIndexPath:indexPath];
    
    cell.titleLable.text = [NSString stringWithFormat:@"第%ld项", indexPath.row];
    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.bounds.size.width - 100) / 4, (self.bounds.size.width - 100) / 4);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 20, 15, 20);
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
    cell.contentView.backgroundColor = [UIColor lightGrayColor];
}

// 选择项
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", indexPath.row);
}

// Cell显示动画
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) {
    
//    cell.transform = CGAffineTransformMakeTranslation(-20, 40);
//    
//    [UIView animateKeyframesWithDuration:1.6 delay:0.0 options:0 animations:^{
//        
//        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.2 animations:^{
//            cell.transform = CGAffineTransformMakeTranslation(-10, 20);
//        }];
//        
//        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.2 animations:^{
//            cell.transform = CGAffineTransformMakeTranslation(10, 0);
//        }];
//        
//        [UIView addKeyframeWithRelativeStartTime:0.4 relativeDuration:0.4 animations:^{
//            cell.transform = CGAffineTransformMakeTranslation(5, -10);
//        }];
//        
//        [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
//            cell.transform = CGAffineTransformMakeTranslation(0, 0);
//            
//        }];
//        
//    } completion:^(BOOL finished) {
//        
//    }];
    
    cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0, 0), 0);
    
    [UIView animateKeyframesWithDuration:.6 delay:0.0 options:0 animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.2 animations:^{
            cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.2, 0.2), 0);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.2 animations:^{
            cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.5, 0.5), 0);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.4 relativeDuration:0.4 animations:^{
            cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(1.2, 1.2), 0);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
            cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(1, 1), 0);
        }];
        
    } completion:^(BOOL finished) {
        
    }];
}

@end
