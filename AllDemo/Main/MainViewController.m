//
//  MainViewController.m
//  AllDemo
//
//  Created by yuhui on 16/12/27.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import "MainViewController.h"
#import "MainTableViewCell.h"
#import "CountDownViewController.h"     // 倒计时测试
#import "MaskViewController.h"          // 点击弹出遮挡层（使用UIWindow实现）
#import "TableFoldViewController.h"     // 使用头部视图实现表格的展开
#import "TableCategoryViewController.h" // 表格关联
#import "APiecePhotoViewController.h"   // 选择单张照片
#import "MorePhotoViewController.h"     // 选择多张照片
#import "VoiceViewController.h"         // 语音
#import "LodingViewController.h"        // 加载
#import "UIconllectionViewSimpleVC.h"   // 基础使用UIconllectionView
#import "WaterViewController.h"         // 瀑布流
#import "AllViewController.h"
#import "CollectionVC.h"                // 轮播
#import "AnimateViewController.h"       // 原生动画
#import "FuViewController.h"            // 弹幕
#import "WebViewController.h"           // 加载网页

#import "CameravailViewController.h"    // 相机使用
#import "ChooseImageController.h"       // 获取相册选择照片
#import "RecordingVideoController.h"    // 录制视频
#import "EditorVideoController.h"       // 编辑视频，编辑完成后保存

#import "ImgViewController.h"           // UIImageView 处理
#import "KWebViewViewController.h"      // WKWebView

#import "HWTimeStyleTool.h"            // 时间格式
// 图表
#import "LineChartViewController.h"    // 折线
#import "BarChartViewController.h"     // 柱状
#import "CircleChartViewController.h"  // 圆形
#import "PieChartViewController.h"     // 饼图
#import "ScatterChartViewController.h" // 散点

#import "PieChartsViewController.h"  // charts pie
#import "BarChartsViewController.h"  // charts bar

#import "NinaViewController.h"       // 不好用

#import "OperatingViewController.h"   // 测试经营情况

#import "MoveCollectionViewController.h" // 移动 CollectionView 进行模板定制设置
#import "SystemShareViewController.h"    // 系统分享
#import "QRImageViewController.h"        // 生成二维码
#import "WaveToolViewController.h"       // 波浪
#import "TestBlockViewController.h"      // block 中 回调 block

#import "TestBouncesViewController.h"    // 测试弹框视图

#import "CustomViewController.h"

#import "UpdateAlertTool.h"

static NSString const *errorString = @"token已过期,请重新登录";

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *allDemoArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *headerImgView;

@end

@implementation MainViewController

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        UIView *headerView = [CreateViewFactory p_setViewBGColor:[UIColor orangeColor]];
        headerView.frame = CGRectMake(0, 0, kSCREENWIDTH, 200.0f);
        
        _headerImgView = [CreateViewFactory p_setImageViewScaleAspectFillImageName:@"guilin"];
        _headerImgView.frame = CGRectMake(0, 0, kSCREENWIDTH, 200.0f);
        _headerImgView.center = headerView.center;
        [headerView addSubview:_headerImgView];
        
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableHeaderView = headerView;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[MainTableViewCell class] forCellReuseIdentifier:@"MainTableViewCell"];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"主页";
    self.view.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
    
    _allDemoArray = @[@"倒计时", @"UIWindow实现遮挡层效果", @"表格折叠", @"表格关联", @"选择单张照片", @"选择多张照片", @"语音", @"加载视图", @"基础使用UIconllectionView", @"瀑布流", @"分页滑动", @"判断String中是否存在某个值", @"头部item", @"原生动画", @"弹幕", @"加载网页", @"相机", @"选择照片", @"录制视频", @"编辑视频", @"Image", @"KWebView", @"折线", @"柱状", @"圆形", @"饼图", @"散点(有问题的)", @"charts饼图", @"Charts柱状", @"Nina", @"测试经营情况", @"移动 CollectionView", @"系统分享", @"QRImage", @"wave波浪", @"block 中 block(看控制台的打印)", @"弹框", @"自定义视频播放器", @"自定义更新Alert视图"];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
//    NSLog(@"a1=>%@", [HWTimeStyleTool timeHorizontalLineStyle:@"1494921666678"]);
//    NSLog(@"a2=>%@", [HWTimeStyleTool timeHorizontalLineNoSecondsStayle:@"1494921666678"]);
//    NSLog(@"a3=>%@", [HWTimeStyleTool timeHorizontalLineNoTimeStayle:@"1494921666678"]);
//    NSLog(@"a4=>%@", [HWTimeStyleTool timeYearMonthDataStyle:@"1494921666678"]);
//    NSLog(@"a5=>%@", [HWTimeStyleTool timeYearMonthDataNoSecondeStyle:@"1494921666678"]);
//    NSLog(@"a6=>%@", [HWTimeStyleTool timeYearMonthDataNoTimeStyle:@"1494921666678"]);
//    NSLog(@"============================");
//    NSLog(@"b1=>%@", [HWTimeStyleTool timeHorizontalLineStyle:@"1494914009"]);
//    NSLog(@"b2=>%@", [HWTimeStyleTool timeHorizontalLineNoSecondsStayle:@"1494914009"]);
//    NSLog(@"b3=>%@", [HWTimeStyleTool timeHorizontalLineNoTimeStayle:@"1494914009"]);
//    NSLog(@"b4=>%@", [HWTimeStyleTool timeYearMonthDataStyle:@"1494914009"]);
//    NSLog(@"b5=>%@", [HWTimeStyleTool timeYearMonthDataNoSecondeStyle:@"1494914009"]);
//    NSLog(@"b6=>%@", [HWTimeStyleTool timeYearMonthDataNoTimeStyle:@"1494914009"]);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 偏移的y值
    CGFloat yOffset = scrollView.contentOffset.y;
    
    if (yOffset < 0) {
        // 200 原有高度 ABS取绝对值
        CGFloat totalOffset = 200 + ABS(yOffset);
        // 比原图的比例
        CGFloat f = totalOffset / 200;
        //拉伸后的图片的frame应该是同比例缩放。
        _headerImgView.frame = CGRectMake(- (kSCREENWIDTH * f - kSCREENWIDTH) / 2, yOffset, kSCREENWIDTH * f, totalOffset);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _allDemoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainTableViewCell"];
    
    cell.titleLable.text = _allDemoArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:{ // 倒计时
            CountDownViewController *vc = [[CountDownViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1:{ // 使用新建UIWindow实现遮挡层
            MaskViewController *vc = [[MaskViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:{ // 使用头部视图实现表格的折叠
            TableFoldViewController *vc = [[TableFoldViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3:{ // 表格关联
            TableCategoryViewController *vc = [[TableCategoryViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 4:{ // 选择单张照片
            APiecePhotoViewController *vc = [[APiecePhotoViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 5:{ // 选择多张照片
            MorePhotoViewController *vc = [[MorePhotoViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 6:{ // 语音
            VoiceViewController *vc = [[VoiceViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 7:{ // 加载视图
            LodingViewController *vc = [[LodingViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 8:{ // 基础使用UIconllectionView
            UIconllectionViewSimpleVC *vc = [[UIconllectionViewSimpleVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 9:{ // 瀑布流
            WaterViewController *vc = [[WaterViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 10:{ // 分页滑动
            AllViewController *vc = [[AllViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 11:{ // 判断String中是否存在某个值
            [self judgeString];
            break;
        }
        case 12:{ // 头部item  轮播
            CollectionVC *vc = [[CollectionVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 13:{ // 原生动画
            AnimateViewController *vc = [[AnimateViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 14:{ // 弹幕
            FuViewController *vc = [[FuViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 15:{ // 加载网页 webView
            WebViewController *vc = [[WebViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 16:{ // 相机的使用
            CameravailViewController *vc = [[CameravailViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 17:{ // 选择照片
            ChooseImageController *vc = [[ChooseImageController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 18:{ // 录制视频
            RecordingVideoController *vc = [[RecordingVideoController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 19:{ // 编辑视频
            EditorVideoController *vc = [[EditorVideoController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 20:{ // ImageView
            ImgViewController *vc = [[ImgViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 21:{ // KWebViewViewController
            KWebViewViewController *vc = [[KWebViewViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 22:{ // LineChartViewController 折线
            LineChartViewController *vc = [[LineChartViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 23:{ // BarChartViewController 柱状
            BarChartViewController *vc = [[BarChartViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 24:{ // CircleChartViewController 圆形
            CircleChartViewController *vc = [[CircleChartViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 25:{ // PieChartViewController 饼图
            PieChartViewController *vc = [[PieChartViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 26:{ // ScatterChartViewController 散点
            ScatterChartViewController *vc = [[ScatterChartViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 27:{ // PieChartsViewController 饼图
            PieChartsViewController *vc = [[PieChartsViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 28:{ // BarChartsViewController 柱状
            BarChartsViewController *vc = [[BarChartsViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 29:{
            // Nina
            NinaViewController *vc = [[NinaViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 30:{ // 经营情况
            OperatingViewController *vc = [[OperatingViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 31:{ // 移动 collectionView
            MoveCollectionViewController *vc = [[MoveCollectionViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 32: { // 系统分享
            SystemShareViewController *vc = [[SystemShareViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 33: { // QRImage
            QRImageViewController *vc = [[QRImageViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 34:{ // #import "WaveToolViewController.h" 波浪
            WaveToolViewController *vc = [[WaveToolViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 35:{ // TestBlockViewController  block
            TestBlockViewController *vc = [[TestBlockViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 36:{ // TestBouncesViewController 弹框
            TestBouncesViewController *vc = [[TestBouncesViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 37:{  // CustomViewController 自定义视频播放器
            CustomViewController *vc = [[CustomViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 38:{ // 自定义更新视图的AlertView
            NSString *string = @"1.意见反馈功能升级\n2.新增我的评价功能\n3.新增深圳包区管理员工单统计功能意见反馈功能升级";
            [UpdateAlertTool updateMessage:string updateAddress:@""];
            break;
        }
            
        default:
            break;
    }
}

//--------添加动画--------
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.contentView.alpha = 0;
    cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0, 0), 0);
    
    
    [UIView animateKeyframesWithDuration:.6 delay:0.0 options:0 animations:^{
        
        /**
         *  分步动画   第一个参数是该动画开始的百分比时间  第二个参数是该动画持续的百分比时间
         */
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.2 animations:^{
            cell.contentView.alpha = .2;
            cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.2, 0.2), 0);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.2 animations:^{
            cell.contentView.alpha = .5;
            cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.5, 0.5), 0);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.4 relativeDuration:0.4 animations:^{
            cell.contentView.alpha = .7;
            cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(1.2, 1.2), 0);
            
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
            cell.contentView.alpha = 1;
            cell.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(1, 1), 0);
            
        }];
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)judgeString {
    
    NSString *str1;
    NSString *str2;
    NSString *str3;
    
    // 字条串是否包含有某字符串
    if ([errorString rangeOfString:@"请重新登录"].location != NSNotFound) {
        str1 = @"包含 请重新登录";
    } else {
        str1 = @"不存在 请重新登录";
    }
    
    // 字条串开始包含有某字符串
    if ([errorString hasPrefix:@"token"]) {
        str2 = @"字段开始包含 token";
    } else {
        str2 = @"字段开始不存在 token";
    }
    
    // 字符串末尾有某字符串；
    if ([errorString hasSuffix:@"请重新登录"]) {
        str3 = @"字段末尾包含 请重新登录";
    } else {
        str3 = @"字段末尾不存在 请重新登录";
    }
    
    // 在iOS8之后可以这样判断
    //    if ([errorString containsString:@"请重新登录"]) {
    //        NSLog(@"containsString 包含 world");
    //    } else {
    //        NSLog(@"containsString 不存在 world");
    //    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"token已过期,请重新登录"
                                                    message:[NSString stringWithFormat:@"%@\n%@\n%@", str1, str2, str3]
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"ok", nil];
    [alert show];
}

@end
