//
//  CircleChartViewController.m
//  AllDemo
//
//  Created by yuhui on 17/5/22.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "CircleChartViewController.h"

@interface CircleChartViewController ()

@end

@implementation CircleChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Circle Chart";
    self.view.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
    
    //For Circle Chart
    
    PNCircleChart * circleChart = [[PNCircleChart alloc] initWithFrame:CGRectMake(0, 80.0, SCREEN_WIDTH, 100.0) total:[NSNumber numberWithInt:100] current:[NSNumber numberWithInt:60] clockwise:NO shadow:NO shadowColor:[UIColor blueColor]];

    circleChart.backgroundColor = [UIColor clearColor];
    [circleChart setStrokeColor:PNGreen];
    [circleChart strokeChart];
    [self.view addSubview:circleChart];
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
