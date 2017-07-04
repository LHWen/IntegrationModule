//
//  BarChartsViewController.m
//  AllDemo
//
//  Created by Liwen on 2017/6/10.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "BarChartsViewController.h"
#import "AllDemo-Bridging-Header.h"

@interface BarChartsViewController () <ChartViewDelegate>

@property (nonatomic, strong) BarChartView *barChartView;

@end

@implementation BarChartsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Charts Bar";
    self.view.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
    
    self.barChartView = [[BarChartView alloc] init];
    self.barChartView.delegate = self;//设置代理
    [self.view addSubview:self.barChartView];
    [self.barChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.bounds.size.width-20, 300));
        make.center.mas_equalTo(self.view);
    }];
    
    // 1.基本样式
    self.barChartView.backgroundColor = [UIColor colorWithRed:230/255.0f green:253/255.0f blue:253/255.0f alpha:1];
    self.barChartView.noDataText = @"暂无数据";//没有数据时的文字提示
    self.barChartView.drawValueAboveBarEnabled = YES;//数值显示在柱形的上面还是下面
//    self.barChartView.drawHighlightArrowEnabled = NO;//点击柱形图是否显示箭头
    self.barChartView.drawBarShadowEnabled = NO;//是否绘制柱形的阴影背景

    // 2.barChartView的交互设置
    self.barChartView.scaleYEnabled = NO;//取消Y轴缩放
    self.barChartView.doubleTapToZoomEnabled = NO;//取消双击缩放
    self.barChartView.dragEnabled = NO;//启用拖拽图表
//    self.barChartView.dragDecelerationEnabled = NO;//拖拽后是否有惯性效果
//    self.barChartView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
    
//    3.设置barChartView的X轴样式
//    首先需要先获取到barChartView的X轴，然后进行设置.
//    通过barChartView的xAxis属性获取到X轴，代码如下：
    
//    hartXAxis *xAxis = self.barChartView.xAxis;
//    设置X轴样式的代码如下：
    
    ChartXAxis *xAxis = self.barChartView.xAxis;
    xAxis.axisLineWidth = 0;//设置X轴线宽
    xAxis.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置，默认是显示在上面的
    xAxis.drawGridLinesEnabled = NO;//不绘制网格线
//    xAxis.spaceMin = 1;//设置label间隔，若设置为1，则如果能全部显示，则每个柱形下面都会显示label
    xAxis.labelTextColor = [UIColor brownColor];//label文字颜色
    
    NSNumberFormatter *xAxisFormatter = [[NSNumberFormatter alloc] init];
//    xAxisFormatter.minimumFractionDigits = 0;
//    xAxisFormatter.maximumFractionDigits = 1;
//    xAxisFormatter.negativeSuffix = @"月";  // 最左边
    xAxisFormatter.positiveSuffix = @" 月";
    xAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:xAxisFormatter];
    
//    4.设置barChartView的Y轴样式
//    barChartView默认样式中会绘制左右两侧的Y轴，首先需要先隐藏右侧的Y轴，代码如下：
    
    self.barChartView.rightAxis.enabled = NO;//不绘制右边轴
    self.barChartView.leftAxis.enabled = NO; // 不绘制左边轴

/**
    //    接着开始设置左侧Y轴的样式.
    self.barChartView.leftAxis.forceLabelsEnabled = NO;//不强制绘制制定数量的label
//    self.barChartView.leftAxis.showOnlyMinMaxEnabled = NO;//是否只显示最大值和最小值
    self.barChartView.leftAxis.axisMinValue = 0;//设置Y轴的最小值
//    self.barChartView.leftAxis.startAtZeroEnabled = YES;//从0开始绘制
    self.barChartView.leftAxis.axisMaxValue = 105;//设置Y轴的最大值
    self.barChartView.leftAxis.inverted = NO;//是否将Y轴进行上下翻转
    self.barChartView.leftAxis.axisLineWidth = 0.5;//Y轴线宽
    self.barChartView.leftAxis.axisLineColor = [UIColor blackColor];//Y轴颜色

    //    通过labelCount属性设置Y轴要均分的数量.
//    在这里要说明一下，设置的labelCount的值不一定就是Y轴要均分的数量，这还要取决于forceLabelsEnabled属性，如果forceLabelsEnabled等于YES, 则强制绘制指定数量的label, 但是可能不是均分的.代码如下：
    
    ChartYAxis *leftAxis = self.barChartView.leftAxis;//获取左边Y轴
    leftAxis.labelCount = 5;
    leftAxis.forceLabelsEnabled = NO;
    
//    设置Y轴上标签的样式，代码如下：
    
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
    leftAxis.labelTextColor = [UIColor brownColor];//文字颜色
    leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体

    //    设置Y轴上标签显示数字的格式，代码如下：
    
//    leftAxis.valueFormatter = [[NSNumberFormatter alloc] init];//自定义格式
//    leftAxis.valueFormatter.positiveSuffix = @" $";//数字后缀单位
//    设置Y轴上网格线的样式，代码如下：
    
    leftAxis.gridLineDashLengths = @[@3.0f, @3.0f];//设置虚线样式的网格线
    leftAxis.gridColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1];//网格线颜色
    leftAxis.gridAntialiasEnabled = YES;//开启抗锯齿
//    在Y轴上添加限制线，代码如下：
    
    ChartLimitLine *limitLine = [[ChartLimitLine alloc] initWithLimit:80 label:@"限制线"];
    limitLine.lineWidth = 2;
    limitLine.lineColor = [UIColor greenColor];
    limitLine.lineDashLengths = @[@5.0f, @5.0f];//虚线样式
    limitLine.labelPosition = ChartLimitLabelPositionRightTop;//位置
    [leftAxis addLimitLine:limitLine];//添加到Y轴上
    leftAxis.drawLimitLinesBehindDataEnabled = YES;//设置限制线绘制在柱形图的后面
    
 */
    
//    5.设置barChartView的其它样式
//    通过legend获取到图例对象，然后把它隐藏掉，代码如下：
    
    self.barChartView.legend.enabled = NO;//不显示图例说明
//    隐藏描述文字，代码如下：
    self.barChartView.descriptionText = @"";//不显示，就设为空字符串即可
    
    //为柱形图提供数据
    self.barChartView.data = [self setData];
    //设置动画效果，可以设置X轴和Y轴的动画效果
    [self.barChartView animateWithYAxisDuration:1.0f];
}

//为柱形图设置数据
- (BarChartData *)setData{
    
    int xVals_count = 6;//X轴上要显示多少条数据
    double maxYVal = 100;//Y轴的最大值
    
    //X轴上面需要显示的数据
//    NSMutableArray *xVals = [[NSMutableArray alloc] init];
//    for (int i = 0; i < xVals_count; i++) {
//        [xVals addObject:[NSString stringWithFormat:@"%d月", i+1]];
//    }
    
    NSArray *yArr = @[@1, @2, @3, @4, @5, @6];
    NSArray *yArrTitle = @[@"1月", @"2月", @"3月", @"4月", @"5月", @"6月"];
    
    //对应Y轴上面需要显示的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < xVals_count; i++) {
        double mult = maxYVal + 1;
        double val = (double)(arc4random_uniform(mult));
//        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithValue:val xIndex:i];
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:i y:val icon:[UIImage imageNamed:@""]];
//        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:i
//                                                                yValues:yArr[i]
//                                                                  label:yArrTitle[i]];
        [yVals addObject:entry];
    }
    
    //创建BarChartDataSet对象，其中包含有Y轴数据信息，以及可以设置柱形样式
//    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithYVals:yVals label:nil];
//    set1.barSpace = 0.2;//柱形之间的间隙占整个柱形(柱形+间隙)的比例
//    set1.drawValuesEnabled = YES;//是否在柱形图上面显示数值
//    set1.highlightEnabled = NO;//点击选中柱形图是否有高亮效果，（双击空白处取消选中）
//    [set1 setColors:ChartColorTemplates.material];//设置柱形图颜色
//    //将BarChartDataSet对象放入数组中
//    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
//    [dataSets addObject:set1];
//    
//    //创建BarChartData对象, 此对象就是barChartView需要最终数据对象
//    BarChartData *data = [[BarChartData alloc] initWithXVals:xVals dataSets:dataSets];
//    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];//文字字体
//    [data setValueTextColor:[UIColor orangeColor]];//文字颜色
//    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//    //自定义数据显示格式
//    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
//    [formatter setPositiveFormat:@"#0.0"];
//    [data setValueFormatter:formatter];
    
    
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@"The year 2017"];
    
    [set1 setColors:ChartColorTemplates.material];
    
    set1.drawValuesEnabled = YES;//是否在柱形图上面显示数值
    set1.highlightEnabled = YES;//点击选中柱形图是否有高亮效果，（双击空白处取消选中）

    set1.drawIconsEnabled = NO;
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    
    BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
    
    data.barWidth = 0.5f;

    return data;
}

//1.点击选中柱形图时的代理方法，代码如下：

- (void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry highlight:(ChartHighlight * _Nonnull)highlight {
    NSLog(@"---chartValueSelected---value: %g", entry.x);
}
//2.没有选中柱形图时的代理方法，代码如下：

- (void)chartValueNothingSelected:(ChartViewBase * _Nonnull)chartView{
    NSLog(@"---chartValueNothingSelected---");
}
//当选中一个柱形图后，在空白处双击，就可以取消选择，此时会回调此方法.

//3.捏合放大或缩小柱形图时的代理方法，代码如下：

- (void)chartScaled:(ChartViewBase * _Nonnull)chartView scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY{
    NSLog(@"---chartScaled---scaleX:%g, scaleY:%g", scaleX, scaleY);
}
//4.拖拽图表时的代理方法

- (void)chartTranslated:(ChartViewBase * _Nonnull)chartView dX:(CGFloat)dX dY:(CGFloat)dY{
    NSLog(@"---chartTranslated---dX:%g, dY:%g", dX, dY);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
