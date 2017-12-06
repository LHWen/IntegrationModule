//
//  UIconllectionViewSimpleVC.m
//  TestCollectionView
//
//  Created by yuhui on 16/11/25.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import "UIconllectionViewSimpleVC.h"
#import "SimpleCollectionViewCell.h"

static NSString *const collectionViewCell = @"SimpleCollectionViewCell";

@interface UIconllectionViewSimpleVC ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation UIconllectionViewSimpleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.flowLayout.minimumInteritemSpacing = 5;  // 左右中间间隔距离
    self.flowLayout.minimumLineSpacing = 5;       // 选项间上下距离间距
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[SimpleCollectionViewCell class] forCellWithReuseIdentifier:collectionViewCell];
    [self.view addSubview:self.collectionView];
    
    self.dataArray = [NSMutableArray array];
    
    for (int i = 0; i < 50; i++) {
        CGSize size = CGSizeMake((arc4random() % 20) + 20, (arc4random() % 20) + 30);
        NSValue *value = [NSValue valueWithCGSize:size];
        
        [self.dataArray addObject:value];
    }
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SimpleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    cell.layer.borderWidth = 0.5;
    cell.layer.borderColor = [UIColor grayColor].CGColor;
    
    cell.titleLable.text = [NSString stringWithFormat:@"第%ld项", indexPath.row];
    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.frame.size.width - 20) / 3, 60);
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

// Cell显示动画
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) {
    
    cell.contentView.alpha = 0;
    cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0, 0), 0);
    
    
    [UIView animateKeyframesWithDuration:.6 delay:0.0 options:0 animations:^{
        
        /**
         *  分步动画   第一个参数是该动画开始的百分比时间  第二个参数是该动画持续的百分比时间
         */
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.2 animations:^{
            cell.contentView.alpha = .2;
            cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.2, 0.2), 0);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.2 animations:^{
            cell.contentView.alpha = .5;
            cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.5, 0.5), 0);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.4 relativeDuration:0.4 animations:^{
            cell.contentView.alpha = .7;
            cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(1.2, 1.2), 0);
            
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
            cell.contentView.alpha = 1;
            cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(1, 1), 0);
            
        }];
        
    } completion:^(BOOL finished) {
        
    }];
}


@end
