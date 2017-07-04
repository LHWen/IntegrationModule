//
//  WaterViewController.m
//  TestCollectionView
//
//  Created by yuhui on 16/11/28.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import "WaterViewController.h"
#import "HeadCollectionReusableView.h"
#import "FootCollectionReusableView.h"
#import "WaterCollectionViewCell.h"
#import "WaterCollectionViewLayout.h"

@interface WaterViewController () <UICollectionViewDelegate, UICollectionViewDataSource, WaterCollectionViewLayoutDelegate>

@property (strong, nonatomic) UICollectionView *waterCollectionView;
@property (strong, nonatomic) WaterCollectionViewLayout *waterLayout;
@property (strong, nonatomic) NSMutableArray *imageArr;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;

@end

@implementation WaterViewController

- (NSMutableArray *)imageArr
{
    if (!_imageArr) {
        _imageArr = [NSMutableArray array];
        for(int i = 1; i <= 100; i++) {
            [_imageArr addObject:[NSString stringWithFormat:@"%d.jpg", i%20]];
        }
    }
    return _imageArr;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.waterLayout = [[WaterCollectionViewLayout alloc] init];
    self.waterLayout.footViewHeight = 60;
    self.waterLayout.headerViewHeight = 30;
    self.waterLayout.delegate = self;
    
    
    self.waterCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.waterLayout];
    self.waterCollectionView.backgroundColor = [UIColor whiteColor];
    self.waterCollectionView.delegate = self;
    self.waterCollectionView.dataSource = self;
    [self.view addSubview:self.waterCollectionView];
    
    [self.waterCollectionView registerClass:[WaterCollectionViewCell class] forCellWithReuseIdentifier:@"waterCell"];
    [self.waterCollectionView registerClass:[HeadCollectionReusableView class] forSupplementaryViewOfKind:W_UICollectionElementKindSectionHeader withReuseIdentifier:@"waterHead"];
    [self.waterCollectionView registerClass:[HeadCollectionReusableView class] forSupplementaryViewOfKind:W_UICollectionElementKindSectionFooter withReuseIdentifier:@"waterFoot"];
    
    
    _imageView = [[UIImageView alloc] init];
    _imageView.hidden = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.backgroundColor = [UIColor blackColor];
    _imageView.userInteractionEnabled = YES;
    [_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick)]];
    [self.view addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];

}


//设置head foot视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:W_UICollectionElementKindSectionHeader]) {
        HeadCollectionReusableView *head = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"waterHead" forIndexPath:indexPath];
        return head;
    }else if([kind isEqualToString:W_UICollectionElementKindSectionFooter]){
        FootCollectionReusableView *foot = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"waterFoot" forIndexPath:indexPath];
        return foot;
    }
    return nil;
}

// 动画显示Cell
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0)
{
    cell.contentView.alpha = 0;
    cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0, 0), 0);
    
    
    [UIView animateKeyframesWithDuration:.5 delay:0.0 options:0 animations:^{
        
        /**
         *  分步动画   第一个参数是该动画开始的百分比时间  第二个参数是该动画持续的百分比时间
         */
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.8 animations:^{
            cell.contentView.alpha = .5;
            cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(1.2, 1.2), 0);
            
        }];
        [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
            cell.contentView.alpha = 1;
            cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(1, 1), 0);
            
        }];
        
    } completion:^(BOOL finished) {
        
    }];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"waterCell" forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:self.imageArr[indexPath.row]];
    cell.titleLable.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    
    return cell;
}

- (UIImage *)imageAtIndexPath:(NSIndexPath *)indexPath {
    return [UIImage imageNamed:[self.imageArr objectAtIndex:indexPath.row]];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(WaterCollectionViewLayout *)layout heightOfItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth
{
    return [self imageAtIndexPath:indexPath].size.height/[self imageAtIndexPath:indexPath].size.width * itemWidth;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

// 选择项
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    _image = [UIImage imageNamed:self.imageArr[indexPath.row]];
    [self setShowImageViewImage:_image];
    
    NSLog(@"%ld", indexPath.row);
}


- (void)setShowImageViewImage:(UIImage *)image {
    
    _imageView.hidden = NO;
    _imageView.image = image;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *valuses = [NSMutableArray array];
    [valuses addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 0.2)]];
    [valuses addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.2, 0.2, 0.2)]];
    [valuses addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.3, 0.3, 0.4)]];
    [valuses addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 0.7)]];
    [valuses addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.7, 0.7, 0.9)]];
    [valuses addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    
    animation.values = valuses;
    [_imageView.layer addAnimation:animation forKey:nil];
}

- (void)imageViewClick {
    
//    _imageView.alpha = 1.0;
////    _imageView.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(1.0, 1.0), 0);
//    
//    [UIView animateKeyframesWithDuration:.5 delay:0.0 options:0 animations:^{
//
//        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.2 animations:^{
//            _imageView.alpha = 0.9;
//            _imageView.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.9, 0.9), 0);
//        }];
//        
//        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.2 animations:^{
//            _imageView.alpha = .5;
//            _imageView.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.7, 0.7), 0);
//        }];
//        
//        [UIView addKeyframeWithRelativeStartTime:0.4 relativeDuration:0.4 animations:^{
//            _imageView.alpha = .7;
//            _imageView.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.4, 0.4), 0);
//            
//        }];
//        
//        [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
//            _imageView.alpha = 1;
//            _imageView.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.1, 0.1), 0);
//            
//        }];
//    } completion:^(BOOL finished) {
//        
//        _imageView.hidden = YES;
//    }];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *valuses = [NSMutableArray array];
    [valuses addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [valuses addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.7, 0.7, 0.6)]];
    [valuses addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 0.5)]];
    [valuses addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.3, 0.3, 0.3)]];
    [valuses addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 0.1)]];
    [valuses addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0)]];
    
    animation.values = valuses;
    [_imageView.layer addAnimation:animation forKey:nil];
    
    //延迟操作
    double delayInSeconds = 0.4;
    dispatch_time_t dismissTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(dismissTime, dispatch_get_main_queue(), ^{
        _imageView.hidden = YES;
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
