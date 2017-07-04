//
//  HeaderTableViewCell.m
//  AllDemo
//
//  Created by yuhui on 17/1/17.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "HeaderTableViewCell.h"
#import "HeaderCollectionViewCell.h"

//最多显示多少个
#define MAX_MENU_COUNT 5

@interface HeaderTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation HeaderTableViewCell
{
    NSArray <UIImage *>*_items;
    NSArray <NSString *>*_itemStr;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self p_setup];
    }
    return self;
}

- (void)p_setup {
    
    [self p_setupPageCollectionView];
    [self p_setupPageControl];
}

// PageCollectionView 初始化
- (void)p_setupPageCollectionView {
    
    if (!_pageCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _pageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, self.contentView.bounds.size.width, 80) collectionViewLayout:layout];
        _pageCollectionView.backgroundColor = [UIColor clearColor];
        _pageCollectionView.pagingEnabled = YES;
        _pageCollectionView.showsHorizontalScrollIndicator = NO;
        _pageCollectionView.delegate = self;
        _pageCollectionView.dataSource = self;
        [self.pageCollectionView registerClass:[HeaderCollectionViewCell class] forCellWithReuseIdentifier:@"HeaderCollectionViewCell"];
        [self.pageCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"BlankCell"];
        [self.contentView addSubview:_pageCollectionView];
    }
}

// PageControl 初始化
- (void)p_setupPageControl {
    
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.currentPage = 0; //当前页
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];  // 常规颜色
        _pageControl.currentPageIndicatorTintColor = [UIColor greenColor]; // 选择颜色
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.userInteractionEnabled = NO;
        [self.contentView addSubview:_pageControl];
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_pageCollectionView.mas_bottom);
            make.left.right.bottom.mas_equalTo(0);
        }];
    }
}

- (void)setWithItemArr:(NSArray <UIImage *>*)items {
    _items = items;
    self.pageControl.numberOfPages = [self sectionCount];
    if (self.pageControl.numberOfPages == 1) {
        [_pageCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-20);
        }];
    }
    [self.pageCollectionView reloadData];
}

- (void)setWithItemArrStr:(NSArray <NSString *>*)itemStr {
    _itemStr = itemStr;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return MAX_MENU_COUNT;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self sectionCount];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //填充空白
    NSInteger index = indexPath.section * MAX_MENU_COUNT + indexPath.row;
    if (index >= _items.count) {
        return [collectionView dequeueReusableCellWithReuseIdentifier:@"BlankCell" forIndexPath:indexPath];
    }
    
    HeaderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HeaderCollectionViewCell" forIndexPath:indexPath];
    cell.imgView.image = _items[index];
    cell.titleLbl.text = _itemStr[index];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    /** 选择对的按钮，不这样处理会导致选择重复的*/
    NSInteger index = indexPath.section * MAX_MENU_COUNT + indexPath.row;
    if (index >= _items.count) {
        NSLog(@"超出");
    }else {
        NSLog(@"click row %ld", index);
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = 48;
    CGFloat height = 71;
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 14, 0, 14);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return (collectionView.bounds.size.width - (48 * 5 + 28))/4;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    _pageControl.currentPage = page;
}


#pragma mark - 私有方法
/**
 *  计算分区数
 *
 *  @return 分区数
 */
- (NSUInteger)sectionCount {
    NSUInteger value = _items.count % MAX_MENU_COUNT;
    return _items.count / MAX_MENU_COUNT + (value != 0 || _items.count <= 0);
}

@end
