//
//  ScatterChartViewController.m
//  AllDemo
//
//  Created by yuhui on 17/5/22.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "ScatterChartViewController.h"

@interface ScatterChartViewController ()

@end

@implementation ScatterChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Scatter Chart";
    self.view.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
    
    PNScatterChart *scatterChart = [[PNScatterChart alloc] initWithFrame:CGRectMake(SCREEN_WIDTH /6.0 - 30, 135, 280, 200)];
    [scatterChart setAxisXWithMinimumValue:20 andMaxValue:100 toTicks:6];
    [scatterChart setAxisYWithMinimumValue:30 andMaxValue:50 toTicks:5];
    
    NSArray * data01Array = @[@[@(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300)], @[@(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300), @(arc4random() % 300)]];
    PNScatterChartData *data01 = [PNScatterChartData new];
    data01.strokeColor = PNGreen;
    data01.fillColor = PNFreshGreen;
    data01.size = 2;
    data01.itemCount = [[data01Array objectAtIndex:0] count];
    data01.inflexionPointStyle = PNScatterChartPointStyleCircle;
    __block NSMutableArray *XAr1 = [NSMutableArray arrayWithArray:[data01Array objectAtIndex:0]];
    __block NSMutableArray *YAr1 = [NSMutableArray arrayWithArray:[data01Array objectAtIndex:1]];
    data01.getData = ^(NSUInteger index) {
        CGFloat xValue = [[XAr1 objectAtIndex:index] floatValue];
        CGFloat yValue = [[YAr1 objectAtIndex:index] floatValue];
        return [PNScatterChartDataItem dataItemWithX:xValue AndWithY:yValue];
    };
    
    [scatterChart setup];
    scatterChart.chartData = @[data01];

    [self.view addSubview:scatterChart];
//    self.scatterChart.chartData = @[data01];
    /***
     this is for drawing line to compare
     CGPoint start = CGPointMake(20, 35);
     CGPoint end = CGPointMake(80, 45);
     [scatterChart drawLineFromPoint:start ToPoint:end WithLineWith:2 AndWithColor:PNBlack];
     ***/
//    scatterChart.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
