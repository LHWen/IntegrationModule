//
//  FuViewController.m
//  AllDemo
//
//  Created by yuhui on 17/1/20.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "FuViewController.h"
#import "BulletView.h"
#import "BulletManager.h"

@interface FuViewController ()

@property (nonatomic, strong) BulletManager *bulletManager;

@property (nonatomic, strong) UILabel *testLable;
@property (nonatomic, strong) UIScrollView *showView;

@end

@implementation FuViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self startAnimationIfNeeded];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"弹幕";
    self.view.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
    
    self.bulletManager = [[BulletManager alloc] init];
    __weak typeof(self) weakSelf = self;
    self.bulletManager.generateViewBlock = ^(BulletView *view){
        [weakSelf addBulletView:view];
    };
    
    UIButton *button = ({
        UIButton *button       = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame           = CGRectMake(20, 40, 100, 40);
        button.backgroundColor = [UIColor greenColor];
        [button setTitle:@"开始" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
        
        button;
    });
    
    UIButton *button1 = ({
        UIButton *button       = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame           = CGRectMake(140, 40, 100, 40);
        button.backgroundColor = [UIColor greenColor];
        [button setTitle:@"Stop" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickButtonStop) forControlEvents:UIControlEventTouchUpInside];
        
        button;
    });

    
    [self.view addSubview:button];
    [self.view addSubview:button1];
    
    NSString *str = @"测试一段动画很长很长很长的字段信息语音来测试来回滚动lable效果";
    _testLable = [CreateViewFactory p_setLableWhiteBGColorOneLineLeftText:str textFont:20.0f textColor:[UIColor blackColor]];
    // 计算尺寸
    CGSize size = [_testLable.text sizeWithFont:_testLable.font];
    if (size.width > kSCREENWIDTH-140) {
        _testLable.frame = (CGRect){CGPointZero, size};
        
        _testLable.text = [NSString stringWithFormat:@"    %@    ", str];
        _testLable.backgroundColor = [UIColor clearColor];
        // 初始化ScrollView
        _showView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 100, kSCREENWIDTH-140, size.height)];
        CGFloat width = size.width + 20;
        _showView.contentSize = CGSizeMake(width, size.height);
        _showView.showsHorizontalScrollIndicator = NO;
        _showView.backgroundColor = [UIColor clearColor];
        [_showView addSubview:_testLable];
        _showView.center = self.navigationItem.titleView.center;
        //    [self.view addSubview:_showView];
        self.navigationItem.titleView = _showView;
    }else {
        self.navigationItem.title = str;
    }
}

// 开始弹幕
- (void)clickButton {
    
    [self.bulletManager start];
}

// 添加弹幕视图
- (void)addBulletView:(BulletView *)view {
    
    view.frame = CGRectMake(kSCREENWIDTH, 300 + view.trajectory * 50, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
    [self.view addSubview:view];
    
    [view startAnimation];
}

// stop弹幕
- (void)clickButtonStop {
    
    [self.bulletManager stop];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.bulletManager stop];
}


-(void)startAnimationIfNeeded{
    //取消、停止所有的动画
    [_showView.layer removeAllAnimations];
    CGSize textSize = [_testLable.text sizeWithFont:_testLable.font];
    CGRect lframe = _testLable.frame;
    lframe.size.width = textSize.width;
    _testLable.frame = lframe;
    const float oriWidth = kSCREENWIDTH - 140;
    if (textSize.width > oriWidth) {
        float offset = textSize.width - oriWidth;
        [UIView animateWithDuration:5.0
                              delay:0
                            options:UIViewAnimationOptionRepeat //动画重复的主开关
         |UIViewAnimationOptionAutoreverse //动画重复自动反向，需要和上面这个一起用
         |UIViewAnimationOptionCurveLinear //动画的时间曲线，滚动字幕线性比较合理
                         animations:^{
//                             _showView.transform = CGAffineTransformMakeTranslation(-offset, 0);
                             CGPoint point = _showView.contentOffset;
                             point.x = offset;
                             _showView.contentOffset = point;
                         }
                         completion:^(BOOL finished) {
                             
                         }
         ];
    }
}
@end
