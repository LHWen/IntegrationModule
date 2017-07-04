//
//  PieChartViewController.m
//  AllDemo
//
//  Created by yuhui on 17/5/22.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "PieChartViewController.h"

@interface PieChartViewController ()

@end

@implementation PieChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Pie Chart";
    self.view.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
    
    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:10 color:PNRed],
                       [PNPieChartDataItem dataItemWithValue:20 color:PNBlue description:@"WWDC 64"],
                       [PNPieChartDataItem dataItemWithValue:40 color:PNGreen description:@"GOOL I/O"],
                       ];
    
//    PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(40.0, 155.0, 240.0, 240.0) items:items];
//    pieChart.descriptionTextColor = [UIColor whiteColor];
////    pieChart.displayAnimated = NO;  // 禁止动画
//    pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:14.0];
//    [pieChart strokeChart];
//    [self.view addSubview:pieChart];
    
    
    PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(40.0, 155.0, 240.0, 240.0) items:items];
    pieChart.backgroundColor = [UIColor greenColor];
    pieChart.legendStyle = PNLegendItemStyleStacked;   // 样式
    pieChart.legendFont = [UIFont systemFontOfSize:12.0f];
    
    pieChart.descriptionTextColor = [UIColor whiteColor];
    //    pieChart.displayAnimated = NO;  // 禁止动画
    pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:14.0];
    [pieChart strokeChart];
    
    UIView *legend = [pieChart getLegendWithMaxWidth:200];
    [legend setFrame:CGRectMake(40, 400, legend.frame.size.width, legend.frame.size.height)];
    [self.view addSubview:pieChart];
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
