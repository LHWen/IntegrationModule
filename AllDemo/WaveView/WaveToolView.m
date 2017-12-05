//
//  WaveToolView.m
//  AllDemo
//
//  Created by LHWen on 2017/9/29.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "WaveToolView.h"

@interface WaveToolView()

@property (nonatomic, strong) CADisplayLink *displayLink; // 定时器
@property (nonatomic, assign) CGFloat offsetyScale; // 上升的速度
@property (nonatomic, assign) CGFloat moveWidth; // 移动的距离，配合速率设置
@property (nonatomic, assign) CGFloat offsety; // 波峰所在位置的y坐标
@property (nonatomic, assign) CGFloat offsetx; // 偏移
@property (nonatomic, strong) UIBezierPath *path;

@end

@implementation WaveToolView

@synthesize distanceV = _distanceV;
@synthesize distanceH = _distanceH;

+ (instancetype)waveViewWithFrame:(CGRect)frame andColorSet: (NSMutableArray <UIColor *>*)colorMutableArray andProgress: (CGFloat)progress {
    return [[self alloc]initWithFrame:frame andColorSet:colorMutableArray andProgress:progress];
}

- (instancetype)initWithFrame:(CGRect)frame andColorSet: (NSMutableArray <UIColor *>*)colorMutableArray andProgress: (CGFloat)progress
{
    if (self = [super initWithFrame:frame]) {
        self.colorMutableArray = colorMutableArray;
        self.progress = progress;
        self.isWaveStart = true;
    }
    return self;
}

#pragma mark - getter
- (CGFloat)progress {
    if (_progress >= 1) {
        [self endWave];
        NSLog(@"%@ --- 波浪进度大于等于1，已经停止波浪",self.class);
        _progress = 1;
    }
    return _progress;
}

- (CGFloat)amplitude {
    
    if (!_amplitude) {
        _amplitude = 4;
    }
    return _amplitude;
}

- (CGFloat)cycle {
    
    if (!_cycle) {
        _cycle = 2 * M_PI / (self.frame.size.width * 0.9);
    }
    return _cycle;
}

- (CGFloat)distanceH {
    
    if (!_distanceH) {
        _distanceH = 2 * M_PI / self.cycle * 0.6;
    }
    return _distanceH;
}

- (CGFloat)distanceV {
    
    if (!_distanceV) {
        _distanceV = self.amplitude * 0.4;
    }
    return _distanceV;
}

- (CGFloat)moveWidth {
    
    if (!_moveWidth) {
        _moveWidth = 0.5;
    }
    return _moveWidth;
}

- (CGFloat)waveScale {
    
    if (!_waveScale) {
        _waveScale = 0.1;
    }
    return _waveScale;
}

- (CGFloat)offsetyScale {
    
    if (!_offsetyScale) {
        _offsetyScale = 1;
    }
    return _offsetyScale;
}

- (CGFloat)offsety {
    
    if (!_offsety) {
        _offsety = (1 - self.progress) * (self.frame.size.height + 2 * self.amplitude);
    }
    return _offsety;
}

- (UIBezierPath *)path {
    if (!_path) {
        [self getPath];
        
    }
    return _path;
}
- (void)getPath {
    if (self.bazierPath) _path = self.bazierPath;
    switch (self.pathType) {
        case WaveViewPathType_CIRCULAR://圆形
            _path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
            break;
        case WaveViewPathType_RECT://矩形
            _path = [UIBezierPath bezierPathWithRect:self.bounds];
    }
}

#pragma mark - setter
//MARK: 是否开始冲浪
- (void)setIsWaveStart:(BOOL)isWaveStart {
    _isWaveStart = isWaveStart;
    if (isWaveStart) {
        [self startWave];
    }else {
        [self endWave];
    }
}

- (void)setBazierPath:(UIBezierPath *)bazierPath {
    _bazierPath = bazierPath;
    self.path = bazierPath;
}

#pragma mark - 开始波浪
//MARK: 开始波浪
- (void)startWave{
    self.backgroundColor = [UIColor clearColor];
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

// 定时器相应的方法
- (void)displayLinkAction
{
    self.offsetx += self.waveScale;
    [self setNeedsDisplay];
}


//MARK: 绘制
- (void)drawRect:(CGRect)rect
{
    //设置颜色
    [self.waveViewBackgroundColor setFill];
    //填充
    [self.path fill];
    //这个必须要每次调用都设置一下，否则会有问题
    [self.path addClip];
    
    //绘制两个波形图
    [self.colorMutableArray enumerateObjectsUsingBlock:^(UIColor  *color, NSUInteger idx, BOOL * _Nonnull stop) {
        [self drawWaveColor:color offsetx:self.distanceH * idx + self.distanceH offsety:self.distanceV * idx + self.distanceV];
    }];
}


//MARK: 画出单层的波浪
- (void)drawWaveColor:(UIColor *)color offsetx:(CGFloat)offsetx offsety:(CGFloat)offsety
{
    //波浪动画，进度的实际操作范围是，多加上两个振幅的高度，到达设置进度的位置y
    CGFloat end_offY = (1 - self.progress) * (self.frame.size.height + 2 * self.amplitude);
    if (self.offsety != end_offY) {
        if (end_offY < self.offsety) {
            self.offsety = MAX(self.offsety -= (self.offsety - end_offY) * self.offsetyScale, end_offY);
        }else {
            self.offsety = MIN(self.offsety += (end_offY - self.offsety) * self.offsetyScale, end_offY);
        }
    }
    
    UIBezierPath *wavePath = [UIBezierPath bezierPath];
    for (float next_x = 0.f; next_x <= self.frame.size.width; next_x ++) {
        //正弦函数，绘制波形
        CGFloat next_y = self.amplitude * sin(self.cycle * next_x + self.offsetx + offsetx / self.bounds.size.width * 2 * M_PI) + self.offsety + offsety;
        if (next_x == 0) {
            [wavePath moveToPoint:CGPointMake(next_x, next_y - self.amplitude)];
        }else {
            [wavePath addLineToPoint:CGPointMake(next_x, next_y - self.amplitude)];
        }
    }
    
    [wavePath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [wavePath addLineToPoint:CGPointMake(0, self.bounds.size.height)];
    [color set];
    [wavePath fill];
}

#pragma mark - 结束波浪
//MARK: 结束波浪
- (void)endWave {
    [self removeDisplayLinkAction];
}
// 移除定时器
- (void)removeDisplayLinkAction
{
    [self.displayLink invalidate];
    self.displayLink = nil;
}

@end
