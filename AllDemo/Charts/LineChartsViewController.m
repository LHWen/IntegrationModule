//
//  LineChartsViewController.m
//  AllDemo
//
//  Created by LHWen on 2018/2/6.
//  Copyright © 2018年 yuhui. All rights reserved.
//

#import "LineChartsViewController.h"
#import "AllDemo-Bridging-Header.h"

@interface LineChartsViewController ()<ChartViewDelegate>

@property (nonatomic, strong) LineChartView *lineChartView;

@end

@implementation LineChartsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Chart Line";
    self.view.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
    
    self.lineChartView = [[LineChartView alloc] init];
    self.lineChartView.backgroundColor = [UIColor colorWithWhite:204/255.f alpha:1.f];
    self.lineChartView.delegate = self;//设置代理
    
    [self.lineChartView setExtraOffsetsWithLeft:10 top:10 right:20 bottom:10];//饼状图距离边缘的间隙
    
    //    self.lineChartView.chartDescription.enabled = NO;
    //    self.lineChartView.dragEnabled = YES;
    //    [self.lineChartView setScaleEnabled:YES];
    //    self.lineChartView.drawGridBackgroundEnabled = NO;
    //    self.lineChartView.pinchZoomEnabled = YES;
    
    [self.view addSubview:self.lineChartView];
    [self.lineChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(self.view.bounds.size.width-20));
        make.height.equalTo(@300);
        make.center.equalTo(self.view);
    }];
    
//    ChartLegend *l = self.lineChartView.legend;
//    l.form = ChartLegendFormLine;
//    l.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
//    l.textColor = UIColor.whiteColor;
//    l.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
//    l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
//    l.orientation = ChartLegendOrientationHorizontal;
//    l.drawInside = NO;
    
    ChartXAxis *xAxis = self.lineChartView.xAxis;
    xAxis.labelFont = [UIFont systemFontOfSize:9.0f];
    xAxis.labelTextColor = UIColor.orangeColor;
    xAxis.axisLineWidth = 0;    // 设置X轴线宽
    xAxis.labelPosition = XAxisLabelPositionBottom;     // X轴的显示位置，默认是显示在上面的
    xAxis.drawGridLinesEnabled = NO;    // 不绘制网格线
    xAxis.drawAxisLineEnabled = NO;
    NSNumberFormatter *xAxisFormatter = [[NSNumberFormatter alloc] init];
    xAxisFormatter.positiveSuffix = @" 月";
    xAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:xAxisFormatter];
    
    ChartYAxis *leftAxis = self.lineChartView.leftAxis;
    leftAxis.labelTextColor = UIColor.greenColor;
    leftAxis.axisMaximum = 120.0;
    leftAxis.axisMinimum = 0.0;
    leftAxis.drawGridLinesEnabled = YES;
    leftAxis.drawZeroLineEnabled = NO;
    leftAxis.granularityEnabled = YES;
//    leftAxis.gridLineDashLengths = @[@3.0f, @3.0f];//设置虚线样式的网格线
    leftAxis.gridColor = UIColor.redColor;//网格线颜色
//    leftAxis.gridAntialiasEnabled = YES;//开启抗锯齿
    
    self.lineChartView.rightAxis.enabled = NO; // 不绘制右边轴
    
    self.lineChartView.legend.enabled = NO;//不显示图例说明
    //    隐藏描述文字，代码如下：
//    self.lineChartView.descriptionText = @"";//不显示，就设为空字符串即可
    
    //为柱形图提供数据
    self.lineChartView.data = [self setLineData];
    //设置动画效果，可以设置X轴和Y轴的动画效果
//    [self.lineChartView animateWithYAxisDuration:2.5f];
//    [self.lineChartView animateWithXAxisDuration:2.5f];
    [self.lineChartView animateWithXAxisDuration:1.5 yAxisDuration:2.5];
}

- (LineChartData *)setLineData {
    
    int xVals_count = 18;//X轴上要显示多少条数据
    double maxYVal = 120;//Y轴的最大值
    
    //对应Y轴上面需要显示的数据
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    
    for (int i = 1; i <= xVals_count; i++) {
        double mult = maxYVal + 1;
        double val = (double)(arc4random_uniform(mult));
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:val];
        
        [yVals1 addObject:entry];
    }
    
    for (int i = 1; i <= xVals_count; i++) {
        double mult = maxYVal + 1;
        double val = (double)(arc4random_uniform(mult));
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:val];
        
        [yVals2 addObject:entry];
    }
    
//    LineChartDataSet *set1 = [[LineChartDataSet alloc] initWithValues:yVals label:@"The year 2017"];
//    LineChartDataSet *set1 = [[LineChartDataSet alloc] initWithValues:yVals1];
//    LineChartDataSet *set2 = [[LineChartDataSet alloc] initWithValues:yVals2];
    LineChartDataSet *set1 = [[LineChartDataSet alloc] initWithEntries:[yVals1 copy]];
    LineChartDataSet *set2 = [[LineChartDataSet alloc] initWithEntries:[yVals2 copy]];
    
    [self lineChartDataSet:set1 lineColor:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
    [self lineChartDataSet:set2 lineColor:[UIColor orangeColor]];
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    [dataSets addObject:set2];
    
    LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:9.0f]];
    
    return data;
}

- (void)lineChartDataSet:(LineChartDataSet *)set lineColor:(UIColor *)color {
    
    set.axisDependency = AxisDependencyLeft;
    [set setColor:color];
    [set setCircleColor:UIColor.whiteColor];
    set.lineWidth = 2.0;
    set.circleRadius = 3.0;
    set.fillAlpha = 65/255.0;
    set.fillColor = [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f];
    set.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
    set.drawCircleHoleEnabled = NO;
    set.drawValuesEnabled = YES; // 是否在柱形图上面显示数值
    set.highlightEnabled = YES; // 点击选中柱形图是否有高亮效果，（双击空白处取消选中）
    set.drawIconsEnabled = NO;
}

#pragma mark - ChartViewDelegate
- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight {
    NSLog(@"chartValueSelected");
    
    [self.lineChartView centerViewToAnimatedWithXValue:entry.x yValue:entry.y axis:[self.lineChartView.data getDataSetByIndex:highlight.dataSetIndex].axisDependency duration:1.0];
    //[_chartView moveViewToAnimatedWithXValue:entry.x yValue:entry.y axis:[_chartView.data getDataSetByIndex:dataSetIndex].axisDependency duration:1.0];
    //[_chartView zoomAndCenterViewAnimatedWithScaleX:1.8 scaleY:1.8 xValue:entry.x yValue:entry.y axis:[_chartView.data getDataSetByIndex:dataSetIndex].axisDependency duration:1.0];
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView {
    NSLog(@"chartValueNothingSelected");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
