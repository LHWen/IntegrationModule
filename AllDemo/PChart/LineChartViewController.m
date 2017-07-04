//
//  LineChartViewController.m
//  AllDemo
//
//  Created by yuhui on 17/5/22.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "LineChartViewController.h"

@interface LineChartViewController ()

@end

@implementation LineChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Line Chart";
    self.view.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
    
    /**
    //For Line Chart
    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 200.0)];
    //是否显示坐标轴
    lineChart.showCoordinateAxis = YES;
    
    [lineChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5"]];
    
    // Line Chart No.1
    NSArray * data01Array = @[@60.1, @160.1, @126.4, @262.2, @186.2];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = PNFreshGreen;
    data01.itemCount = lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    // Line Chart No.2
    NSArray * data02Array = @[@20.1, @180.1, @26.4, @202.2, @126.2];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.color = PNTwitterColor;
    data02.itemCount = lineChart.xLabels.count;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    lineChart.chartData = @[data01, data02];
    [lineChart strokeChart];
    
    [self.view addSubview:lineChart];
     
     */
    
    //For Line Chart
    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 200.0)];
    
    lineChart.legendStyle = PNLegendItemStyleStacked;  // 带点
    // lineChart.showSmoothLines = YES;// 是否显示曲线
    //是否显示坐标轴
    lineChart.showCoordinateAxis = YES;
    
    [lineChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5"]];
    
    // Line Chart No.1
    NSArray * data01Array = @[@60.1, @160.1, @126.4, @262.2, @186.2];
    PNLineChartData *data01 = [PNLineChartData new];
    
    data01.inflexionPointStyle = PNLineChartPointStyleCircle;       // 设置每组数据的点的样式
    data01.inflexionPointColor = [UIColor redColor];
    data01.dataTitle = @"数据1标注名称";             //数据标注名称
    
    data01.color = PNFreshGreen;
    data01.itemCount = lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    // Line Chart No.2
    NSArray * data02Array = @[@20.1, @180.1, @26.4, @202.2, @126.2];
    PNLineChartData *data02 = [PNLineChartData new];
    
    data02.inflexionPointStyle = PNLineChartPointStyleTriangle;
    data02.inflexionPointColor = [UIColor orangeColor];
    data02.dataTitle = @"数据2标注名称";
    
    data02.color = PNTwitterColor;
    data02.itemCount = lineChart.xLabels.count;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    lineChart.chartData = @[data01, data02];
    [lineChart strokeChart];
    
    lineChart.legendFont = [UIFont systemFontOfSize:11.0f];   //标注字体
    lineChart.legendFontColor = [UIColor blackColor];         // 字体颜色
    lineChart.legendStyle = PNLegendItemStyleSerial;          // 摆放样式
    UIView *legend = [lineChart getLegendWithMaxWidth:320];
    [legend setFrame:CGRectMake(30, 340, legend.frame.size.width, legend.frame.size.height)];
    
    [self.view addSubview:lineChart];
    
    [self.view addSubview:legend];

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
