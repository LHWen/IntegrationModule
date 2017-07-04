//
//  ScrollDisplayViewController.m
//  AllDemo
//
//  Created by yuhui on 17/1/5.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "ScrollDisplayViewController.h"

@interface ScrollDisplayViewController () <UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@end

@implementation ScrollDisplayViewController
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //如果控制器数组为空，或者什么都没有
    if (!_controllers||_controllers.count == 0) {
        return;
    }
    _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:1 navigationOrientation:0 options:nil];
    _pageVC.delegate = self;
    _pageVC.dataSource = self;
    [self addChildViewController:_pageVC];
    [self.view addSubview:_pageVC.view];
    
    [_pageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [_pageVC setViewControllers:@[_controllers.firstObject] direction:0 animated:YES completion:nil];
    
    self.autoCycle = _autoCycle;
    self.showPageControl = _showPageControl;
    self.pageControlOffset = _pageControlOffset;
}


// 传入视图控制器
- (instancetype)initWithControllers:(NSArray *)controllers{
    if (self = [super init]) {
        //为了防止实参是可变的数组，需要复制一份出来以保证属性不会因可变数组在外部被修改，而导致随之修改
        _controllers = [controllers copy];
        //设置滚动视图属性
        _autoCycle = YES;
        _canCycle = YES;
        _showPageControl = YES;
        _duration = 2;
        _pageControlOffset = 0;
    }
    return self;
}

#pragma  mark - UIPageViewController
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = [_controllers indexOfObject:viewController];
    if (index == 0) {
        return _canCycle?_controllers.lastObject:nil;
    }
    return _controllers[index - 1];
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    NSInteger index = [_controllers indexOfObject:viewController];
    if (index == _controllers.count - 1) {
        return _canCycle?_controllers.lastObject:nil;
    }
    return _controllers[index + 1];
}
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    
    if (completed && finished) {
        
        NSInteger index = [_controllers indexOfObject:pageViewController.viewControllers.firstObject];
        
        if ([self.delegate respondsToSelector:@selector(scrollDisplayViewController:currentIndex:)]) {
        
            [self.delegate scrollDisplayViewController:self currentIndex:index];
        }
    }
}

- (void)setShowPageControl:(BOOL)showPageControl {
    _showPageControl = showPageControl;
}

- (void)setDuration:(NSTimeInterval)duration {
    _duration = duration;
    self.autoCycle = _autoCycle;
}

- (void)setPageControlOffset:(CGFloat)pageControlOffset {
    _pageControlOffset = pageControlOffset;
}

- (void)setCurrentPage:(NSInteger)currentPage{
    /*设置新的显示页面，情况有三种
     情况一：新页面和老页面是同一个，什么都不做
     情况二：新页面在老页面的右侧，动画效果应该向右滚动
     情况三：新页面在老页面的左侧，动画效果应该向左滚动
     
     UIPageViewControllerNavigationDirectionForward,向右
     UIPageViewControllerNavigationDirectionReverse,向左
     */
    NSInteger direction = 0;
    if (_currentPage == currentPage) {
        return;
    }else if (_currentPage > currentPage){
        direction = 1;
    }else{
        direction = 0;
    }
    //得到索引值  跳转当前视图
    _currentPage = currentPage;
    UIViewController *vc = _controllers[currentPage];
    [_pageVC setViewControllers:@[vc] direction:direction animated:YES completion:nil];
}

@end
