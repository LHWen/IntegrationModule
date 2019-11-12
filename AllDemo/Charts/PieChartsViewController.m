//
//  PieChartsViewController.m
//  AllDemo
//
//  Created by yuhui on 17/6/5.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "PieChartsViewController.h"
#import "AllDemo-Bridging-Header.h"

@interface PieChartsViewController ()

@property (nonatomic, strong) PieChartView *pieChartView;
@property (nonatomic, strong) PieChartData *data;

@end

@implementation PieChartsViewController
{
    NSArray *_dataArr;
    NSArray *_dataTitleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Charts Pie";
    self.view.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
    
    _dataArr = @[@"23", @"46", @"21"];
    _dataTitleArr = @[@"苹果 23", @"桃子 46", @"荔枝 21"];
    
    
    UIButton *updataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    updataBtn.frame = CGRectMake(65.0f, 65.0f, 80.0f, 40.0f);
    [updataBtn setTitle:@"updata" forState:UIControlStateNormal];
    [updataBtn setBackgroundColor:[UIColor blueColor]];
    [updataBtn addTarget:self action:@selector(updateData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:updataBtn];
    
    self.pieChartView = [[PieChartView alloc] init];
    self.pieChartView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.pieChartView];
    [self.pieChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 300));
        make.center.mas_equalTo(self.view);
    }];
    

    [self.pieChartView setExtraOffsetsWithLeft:20 top:0 right:20 bottom:0];//饼状图距离边缘的间隙
    self.pieChartView.usePercentValuesEnabled = YES;//是否根据所提供的数据, 将显示数据转换为百分比格式
    self.pieChartView.dragDecelerationEnabled = YES;//拖拽饼状图后是否有惯性效果
    self.pieChartView.drawCenterTextEnabled = YES;//是否显示区块文本
    
    self.pieChartView.drawHoleEnabled = YES;//饼状图是否是空心
    self.pieChartView.holeRadiusPercent = 0.5;//空心半径占比
    self.pieChartView.holeColor = [UIColor clearColor];//空心颜色
    self.pieChartView.transparentCircleRadiusPercent = 0.52;//半透明空心半径占比
    self.pieChartView.transparentCircleColor = [UIColor colorWithRed:210/255.0 green:145/255.0 blue:165/255.0 alpha:0.3];//半透明空心的颜色
    
//    self.pieChartView.descriptionText = @"饼状图示例";
//    self.pieChartView.descriptionFont = [UIFont systemFontOfSize:10];
//    self.pieChartView.descriptionTextColor = [UIColor grayColor];
    
    self.pieChartView.legend.maxSizePercent = 1;//图例在饼状图中的大小占比, 这会影响图例的宽高
    self.pieChartView.legend.formToTextSpace = 5;//文本间隔
    self.pieChartView.legend.font = [UIFont systemFontOfSize:10];//字体大小
    self.pieChartView.legend.textColor = [UIColor grayColor];//字体颜色
//    self.pieChartView.legend.position = ChartLegendPositionBelowChartCenter;//图例在饼状图中的位置
    self.pieChartView.legend.form = ChartLegendFormCircle;//图示样式: 方形、线条、圆形
    self.pieChartView.legend.formSize = 12;//图示大小

    //为饼状图提供数据
    self.data = [self setData];
    self.pieChartView.data = self.data;
    //设置动画效果
    [self.pieChartView animateWithXAxisDuration:1.0f easingOption:ChartEasingOptionEaseOutExpo];
}

- (void)updateData{
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < _dataArr.count; i++)
    {
        //        [values addObject:[[PieChartDataEntry alloc] initWithValue:(arc4random_uniform(mult) + mult / 5) label:[NSString stringWithFormat:@"%d", i+1] icon: [UIImage imageNamed:@"icon"]]];
        
        [values addObject:[[PieChartDataEntry alloc] initWithValue:[_dataArr[i] doubleValue]
                                                             label:_dataTitleArr[i]
                                                              icon:[UIImage imageNamed:@""]]];
    }
    
//    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:values label:@"水果数据"];
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithEntries:[values copy] label:@"水果数据"];
    
    dataSet.drawIconsEnabled = YES;
    
    dataSet.sliceSpace = 2.0;
    dataSet.iconsOffset = CGPointMake(0, 40);
    
    // add a lot of colors
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObject:[UIColor redColor]];
    [colors addObject:[UIColor orangeColor]];
    [colors addObject:[UIColor blueColor]];
    //    [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
    //    [colors addObjectsFromArray:ChartColorTemplates.joyful];
    //    [colors addObjectsFromArray:ChartColorTemplates.colorful];
    //    [colors addObjectsFromArray:ChartColorTemplates.liberty];
    //    [colors addObjectsFromArray:ChartColorTemplates.pastel];
    
    dataSet.colors = colors;
    
    dataSet.sliceSpace = 0; // 相邻区块之间的间距
    dataSet.selectionShift = 8; // 选中区块时, 放大的半径
    dataSet.xValuePosition = PieChartValuePositionInsideSlice; // 名称位置
    dataSet.yValuePosition = PieChartValuePositionOutsideSlice; // 数据位置
    dataSet.valueLinePart1OffsetPercentage = 0.85;//折线中第一段起始位置相对于区块的偏移量, 数值越大, 折线距离区块越远
    dataSet.valueLinePart1Length = 0.5; // 折线中第一段长度占比
    dataSet.valueLinePart2Length = 0.4; // 折线中第二段长度最大占比
    dataSet.valueLineWidth = 1; // 折线的粗细
    dataSet.valueLineColor = [UIColor whiteColor]; // 折线颜色
    
    
    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
    
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 1;
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @" %";
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];
    [data setValueTextColor:UIColor.whiteColor];
    
    self.pieChartView.data = data;
    //设置动画效果
    [self.pieChartView animateWithXAxisDuration:1.0f easingOption:ChartEasingOptionEaseOutExpo];
}

- (PieChartData *)setData{
    
    double mult = 100;
    int count = 5; // 饼状图总共有几块组成
    
    //每个区块的数据
//    NSMutableArray *yVals = [[NSMutableArray alloc] init];
//    for (int i = 0; i < count; i++) {
//        double randomVal = arc4random_uniform(mult + 1);
//        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:i y:randomVal];
////        BarChartDataEntry *entryd = [[BarChartDataEntry alloc] init];
//        [yVals addObject:entry];
//    }
//    
//    //每个区块的名称或描述
//    NSMutableArray *xVals = [[NSMutableArray alloc] init];
//    for (int i = 0; i < count; i++) {
//        NSString *title = [NSString stringWithFormat:@"part%d", i+1];
//        [xVals addObject:title];
//    }
//    
//    //dataSet [[PieChartDataSet alloc] initWithYVals:yVals label:@""];
//    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:yVals label:@""];
//    dataSet.drawValuesEnabled = YES;//是否绘制显示数据
//    NSMutableArray *colors = [[NSMutableArray alloc] init];
//    [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
//    [colors addObjectsFromArray:ChartColorTemplates.joyful];
//    [colors addObjectsFromArray:ChartColorTemplates.colorful];
//    [colors addObjectsFromArray:ChartColorTemplates.liberty];
//    [colors addObjectsFromArray:ChartColorTemplates.pastel];
//    [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
//    dataSet.colors = colors;//区块颜色
//    dataSet.sliceSpace = 0;//相邻区块之间的间距
//    dataSet.selectionShift = 8;//选中区块时, 放大的半径
//    dataSet.xValuePosition = PieChartValuePositionInsideSlice;//名称位置
//    dataSet.yValuePosition = PieChartValuePositionOutsideSlice;//数据位置
//    //数据与区块之间的用于指示的折线样式
//    dataSet.valueLinePart1OffsetPercentage = 0.85;//折线中第一段起始位置相对于区块的偏移量, 数值越大, 折线距离区块越远
//    dataSet.valueLinePart1Length = 0.5;//折线中第一段长度占比
//    dataSet.valueLinePart2Length = 0.4;//折线中第二段长度最大占比
//    dataSet.valueLineWidth = 1;//折线的粗细
//    dataSet.valueLineColor = [UIColor brownColor];//折线颜色
//    
//    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
//    [dataSets addObject:dataSets];
//    
//    //data [[PieChartData alloc] initWithXVals:xVals dataSet:dataSet];
//    PieChartData *data = [[PieChartData alloc] initWithDataSets:dataSets];
////    [data addDataSet:dataSet];
//    
//    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//    formatter.numberStyle = NSNumberFormatterPercentStyle;
//    formatter.maximumFractionDigits = 0;//小数位数
//    formatter.multiplier = @1.0f;
//    [data setValueFormatter:formatter];//设置显示数据格式
//    [data setValueTextColor:[UIColor brownColor]];
//    [data setValueFont:[UIFont systemFontOfSize:10]];
    
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        [values addObject:[[PieChartDataEntry alloc] initWithValue:(arc4random_uniform(mult) + mult / 5) label:[NSString stringWithFormat:@"%d", i+1] icon: [UIImage imageNamed:@"icon"]]];
    }
    
//    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:values label:@"Election Results"];
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithEntries:[values copy] label:@"Election Results"];
    
    dataSet.drawIconsEnabled = YES;
    
    dataSet.sliceSpace = 2.0;
    dataSet.iconsOffset = CGPointMake(0, 40);
    
    // add a lot of colors
    
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
    [colors addObjectsFromArray:ChartColorTemplates.joyful];
    [colors addObjectsFromArray:ChartColorTemplates.colorful];
    [colors addObjectsFromArray:ChartColorTemplates.liberty];
    [colors addObjectsFromArray:ChartColorTemplates.pastel];
    [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
    
    dataSet.colors = colors;
    
    dataSet.sliceSpace = 0; // 相邻区块之间的间距
    dataSet.selectionShift = 8; // 选中区块时, 放大的半径
    dataSet.xValuePosition = PieChartValuePositionInsideSlice; // 名称位置
    dataSet.yValuePosition = PieChartValuePositionOutsideSlice; // 数据位置
    dataSet.valueLinePart1OffsetPercentage = 0.85;//折线中第一段起始位置相对于区块的偏移量, 数值越大, 折线距离区块越远
    dataSet.valueLinePart1Length = 0.5; // 折线中第一段长度占比
    dataSet.valueLinePart2Length = 0.4; // 折线中第二段长度最大占比
    dataSet.valueLineWidth = 1; // 折线的粗细
    dataSet.valueLineColor = [UIColor whiteColor]; // 折线颜色

    
    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
    
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 1;
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @" %";
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];
    [data setValueTextColor:UIColor.whiteColor];
    
    return data;
}




/** 
 
 pieChartView.delegate = self; // 可以调整大小, 位置 
 //        pieChartView.setExtraOffsets(left: 20.0, top: 0.0, right: 20.0, bottom: 0.0)
 self.view.addSubview(pieChartView)
 var yValues = [BarChartDataEntry]() // 最好从0 开始. 否则第一个将失去点击效果, 并出现bug... 
 for i in 0...5 { // 占比数据 
 yValues.append(BarChartDataEntry.init(value: (Double)(arc4random_uniform(5)) + 2.0, xIndex: i))
 
 }
 var xValues = [String]() for j in 0...5 { // 描述文字 xValues.append(NSString(format: "%d\\\\("夏天然后")", j + 5) as String)
 } // let dataSet: PieChartDataSet = PieChartDataSet.init(yVals: yValues, label: "data Set"); // 空隙 dataSet.sliceSpace = 5.0 var colors = [UIColor]()
 colors.append(UIColor ( red: 0.8185, green: 0.8172, blue: 0.0023, alpha: 1.0 ))
 colors.append(UIColor ( red: 0.0, green: 0.81, blue: 0.81, alpha: 1.0 ))
 colors.append(UIColor.greenColor())
 colors.append(UIColor.grayColor())
 colors.append(UIColor.purpleColor())
 colors.append(UIColor.blueColor())
 dataSet.colors = colors // 如果你需要指示文字在外部标注百分比, 你需要这样. dataSet.valueLinePart1OffsetPercentage = 0.8;
 dataSet.valueLinePart1Length = 0.2;
 dataSet.valueLinePart2Length = 0.4;
 dataSet.yValuePosition = .OutsideSlice
 let data = PieChartData(xVals: xValues, dataSet: dataSet)
 let formatter = NSNumberFormatter.init()
 formatter.maximumFractionDigits = 1 formatter.numberStyle = NSNumberFormatterStyle.PercentStyle
 formatter.multiplier = 1.0 formatter.percentSymbol = " %" data.setValueFormatter(formatter)
 data.setValueTextColor(UIColor.blackColor())
 pieChartView.data = data
 
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
