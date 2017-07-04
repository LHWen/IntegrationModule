//
//  ShufflingTableViewCell.m
//  AllDemo
//
//  Created by yuhui on 17/1/18.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "ShufflingTableViewCell.h"
#import "ShufflingCollectionViewCell.h"

//最多显示多少个
#define MAX_COUNT 100

@interface ShufflingTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSMutableArray *newsArr;

@end

@implementation ShufflingTableViewCell {
    
    NSArray <UIImage *>*_items;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self p_setup];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(p_shutDownTimer)
                                                     name:@"shutTimer"
                                                   object:nil];
    }
    return self;
}

- (void)p_setup {
    
    [self p_setupPageCollectionView];
    [self p_setupPageControl];
    [self addTimer];
}

- (void)addTimer {
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(nextPage) userInfo:NULL repeats:YES];
}

// PageCollectionView 初始化
- (void)p_setupPageCollectionView {
    
    if (!_pageCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _pageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, 178) collectionViewLayout:layout];
        _pageCollectionView.backgroundColor = [UIColor clearColor];
        _pageCollectionView.pagingEnabled = YES;
        _pageCollectionView.showsHorizontalScrollIndicator = NO;
        _pageCollectionView.delegate = self;
        _pageCollectionView.dataSource = self;
        [self.pageCollectionView registerClass:[ShufflingCollectionViewCell class] forCellWithReuseIdentifier:@"ShufflingCollectionViewCell"];
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
            make.top.equalTo(_pageCollectionView.mas_bottom).offset(-20);
            make.left.right.bottom.mas_equalTo(0);
        }];
    }
}

- (void)setWithItemArr:(NSArray <UIImage *>*)items {
    _items = items;
    _newsArr = [NSMutableArray array];
    for (int i=0; i<200; i++) {
         NSArray *array = _items;
         [_newsArr addObjectsFromArray:array];
     }
    self.pageControl.numberOfPages = 3;
    if (self.pageControl.numberOfPages == 1) {
        [_pageCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(0);
        }];
    }
    //设置起始位置
    [self.pageCollectionView reloadData];
    [self.pageCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:50] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return MAX_COUNT;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //填充空白
//    NSInteger index = indexPath.section * MAX_COUNT + indexPath.row;
    NSInteger index = 50 + indexPath.row;
    if (index >= _newsArr.count) {
        index =  indexPath.section * MAX_COUNT;
    }
    
    ShufflingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShufflingCollectionViewCell" forIndexPath:indexPath];
    cell.imgView.image = _newsArr[index];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    /** 选择对的按钮，不这样处理会导致选择重复的*/
//    NSInteger index = indexPath.section * MAX_COUNT + indexPath.row;
     NSInteger index = 50 + indexPath.row;
    if (index >= _newsArr.count) {
        NSLog(@"超出");
    }else {
        NSLog(@"click row %ld", index%3);
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = self.contentView.bounds.size.width;
    CGFloat height = self.contentView.bounds.size.height;
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

     NSInteger page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width - 0.5)%3;
    _pageControl.currentPage = page;
    
    // 添加定时器
    [self addTimer];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    // 移除定时器
    [self p_shutDownTimer];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width - 0.5)%3;
    _pageControl.currentPage = page;
}


#pragma mark -- 定时器的内容
- (void)nextPage {
    
    // 获取当前的 indexPath
    NSIndexPath *currentIndexPath = [[_pageCollectionView indexPathsForVisibleItems] lastObject];
    NSIndexPath *currentIndexPathSet = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:50];
    
    [_pageCollectionView scrollToItemAtIndexPath:currentIndexPathSet atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    // 设置下一个滚动的item的indexPath
    NSInteger nextItem = currentIndexPathSet.item + 1;
    NSInteger nextSection = currentIndexPathSet.section;
    if (nextItem == _items.count) {
        // 当item等于轮播图的总个数的时候
        // item等于0, 分区加1
        // 未达到的时候永远在50分区中
        nextItem = 0;
        nextSection++;
    }
    
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    [_pageCollectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

- (void)p_shutDownTimer {
    // 移除定时器
    [self.timer invalidate];
    self.timer = nil;

}

@end
