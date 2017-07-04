//
//  AllViewController.m
//  AllDemo
//
//  Created by yuhui on 17/1/5.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "AllViewController.h"
#import "ScrollDisplayViewController.h"
#import "TestViewController.h"
#import "TitleScrollView.h"

//通过RGB设置颜色
#define kRGBColor(R,G,B)      [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

@interface AllViewController ()<ScrollDisplayViewControllerDelegate, TitleScrollViewDelegate>
/** 加载在容器里，左右分页的 */
@property(nonatomic,strong) ScrollDisplayViewController *sdVC;
/** 放按钮的滚动视图 */
//@property(nonatomic,strong) UIScrollView *scrollView;
///** 可变数组，存放头部按钮 */
//@property(nonatomic,strong) NSMutableArray *btns;
///** 线 */
//@property(nonatomic,strong) UIView *lineView;
///**  用于保存当前选中的按钮  */
//@property(nonatomic,strong) UIButton *currentBtn;
@property (nonatomic, strong) TestViewController *vc;

@property (nonatomic, strong) TitleScrollView *titleScrollView;

@property (nonatomic, strong) NSArray *titlesArray;

@end

@implementation AllViewController

- (TestViewController *)videsViewControllerType:(AllViewControllerType)type {
    self.vc = [[TestViewController alloc] init];
    self.vc.type = type;
    self.vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    return self.vc;
}

/** ------------ 如果添加新的选项需要在下面多添加一个枚举类型，如果枚举类型不够需要增加 ---------------- */
/** ------------ 此处可以优化，直接添加数组，使之自动增加 ------------- */
- (ScrollDisplayViewController *)sdVC {
    if (!_sdVC) {
        NSArray *VCs = @[[self videsViewControllerType:AllViewControllerTypeOne],
                         [self videsViewControllerType:AllViewControllerTypeTwo],
                         [self videsViewControllerType:AllViewControllerTypeThree],
                         [self videsViewControllerType:AllViewControllerTypeFour],
                         [self videsViewControllerType:AllViewControllerTypefive],
                         [self videsViewControllerType:AllViewControllerTypeSix],
                         [self videsViewControllerType:AllViewControllerTypeSeven]];
        
        _sdVC=[[ScrollDisplayViewController alloc] initWithControllers:VCs];
        _sdVC.autoCycle = NO;
        _sdVC.showPageControl = NO;
        //关掉了点击按钮的循环
        _sdVC.canCycle = NO;
        _sdVC.delegate = self;
    }
    return _sdVC;
}

- (TitleScrollView *)titleScrollView {
    
    if (!_titleScrollView) {
        UIColor *normalTitleColor = [UIColor whiteColor];
        UIColor *selectTitleColor = [UIColor greenColor];
        UIColor *lineViewColor = [UIColor redColor];
        _titleScrollView = [[TitleScrollView alloc] initWithTitles:_titlesArray
                                                  NormalTitleColor:normalTitleColor
                                                  SelectTitleColor:selectTitleColor
                                                     LineViewColor:lineViewColor];
        _titleScrollView.delegatet = self;
    }
    return _titleScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _titlesArray = @[@"天枢", @"天璇", @"天玑", @"天权", @"玉衡", @"开阳", @"瑶光"];
    
    [self addChildViewController:self.sdVC];
    [self.view addSubview:self.sdVC.view];
    [self.sdVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.view);
        make.top.mas_equalTo(44.0f);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    [self.view addSubview:self.titleScrollView];
    if (_titlesArray.count > 4) {
        self.titleScrollView.contentSize = CGSizeMake(kSCREENWIDTH / 4 * _titlesArray.count, 0);
    }
    [self.titleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(kSCREENWIDTH);
    }];
    
}

- (void)sendButtonSender:(NSInteger)sender {
    
    _sdVC.currentPage = sender;
    
}

-(void)scrollDisplayViewController:(ScrollDisplayViewController *)scrollDisplayViewController currentIndex:(NSInteger)index{
    self.titleScrollView.currentBtn.selected = NO;
    self.titleScrollView.currentBtn = self.titleScrollView.btns[index];
    self.titleScrollView.currentBtn.selected = YES;
    _sdVC.currentPage = index;
    [self.titleScrollView updateLineViewLayout];
    
//    CGFloat width = self.titleScrollView.frame.size.width;
//    
//    CGPoint titleOffset = self.titleScrollView.contentOffset;
//    NSLog(@"titleOffset = (x:%f, y:%f)", titleOffset.x, titleOffset.y);
//    //计算公式:对应的label的中心X值 - scrollView宽度的一半
//    titleOffset.x = self.titleScrollView.currentBtn.center.x - width * 0.5;
//
//    /** 左边超出处理*/
//    if (titleOffset.x < 0) titleOffset.x = 0;
//    /** 右边超出处理*/
//    CGFloat maxTitleOffsetX = self.titleScrollView.contentSize.width - width;
//    if (titleOffset.x > maxTitleOffsetX) titleOffset.x = maxTitleOffsetX;
//    
//    [self.titleScrollView setContentOffset:titleOffset animated:YES];
    
    [self.titleScrollView updateCenterButton:self.titleScrollView.currentBtn];
}


@end
