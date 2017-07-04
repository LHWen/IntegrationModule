//
//  BarChartViewController.m
//  AllDemo
//
//  Created by yuhui on 17/5/22.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "BarChartViewController.h"

@interface BarChartViewController ()

@end

@implementation BarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Bar Chart";
    self.view.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
    
    //For BarC hart
    PNBarChart * barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 200.0)];
    
    //Y坐标label宽度(微调)
    barChart.yChartLabelWidth = 20;    // y 坐标显示的宽度，0 相当于隐藏y坐标
    barChart.chartMarginLeft = 10.0;
    barChart.chartMarginRight = 10.0;
    barChart.chartMarginTop = 5.0;
    barChart.chartMarginBottom = 10.0;
    
    //X坐标刻度的上边距
    barChart.labelMarginTop = 2.0;
    //是否显示坐标轴
    barChart.showChartBorder = NO;
    barChart.isShowNumbers = YES;     // 是否显示数值
    
    [barChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5"]];
    [barChart setYValues:@[@1,  @10, @2, @6, @3]];
    [barChart strokeChart];
    [self.view addSubview:barChart];
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
