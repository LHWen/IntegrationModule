//
//  WaveToolViewController.m
//  AllDemo
//
//  Created by LHWen on 2017/9/29.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "WaveToolViewController.h"
#import "WaveToolView.h"

@interface WaveToolViewController ()

@property (nonatomic,weak) WaveToolView *waveView;
////停止按钮的最大y值
//@property (nonatomic,assign) CGFloat stopWaveViewMaxY;
//储存颜色的数组
@property (nonatomic,strong) NSArray<UIColor *>*colorArray;
//@property (nonatomic,assign) NSInteger colorCount;

@end

@implementation WaveToolViewController

- (NSArray<UIColor *> *)colorArray{
   
    if (!_colorArray) {
        UIColor *color1 = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.3f];
        UIColor *color2 = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0f];
        _colorArray = @[color1, color2];
    }
    return _colorArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"波浪视图";
    self.view.backgroundColor = [UIColor greenColor];
    
    [self setupWaceView];
}

//MARK: 设置冲浪视图
- (void)setupWaceView {
    //波浪
    WaveToolView *waveView = [[WaveToolView alloc] init];
    self.waveView = waveView;
    waveView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 70);
    [self.view addSubview:waveView];
    
    // waveView的形状
    waveView.pathType = WaveViewPathType_RECT;
    // 进度（从下到上占得self.Height的比例）
    waveView.progress = 0.6;
    // 颜色数组
    waveView.colorMutableArray = [NSMutableArray arrayWithArray:self.colorArray];
    // 背景颜色数组
    waveView.waveViewBackgroundColor = [UIColor clearColor];
    // 色块之间横向的距离
    waveView.distanceH = 80;
    // 色块之间纵向的距离
    waveView.distanceV = 4;
    // 水波的振幅
    waveView.amplitude = 24;
    // 水波的速率（别太大，会很快的，zz）
    waveView.waveScale = 0.2;
    // 添加View
//    [self.view addSubview:waveView];
    
    //MARK: 这个类一定要调用个方法才会开始冲浪
    waveView.isWaveStart = true;
    
//    waveView.transform = CGAffineTransformMakeRotation (2 * M_PI_2);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.waveView.isWaveStart = NO;
}

@end
