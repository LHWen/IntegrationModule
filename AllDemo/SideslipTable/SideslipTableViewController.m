//
//  SideslipTableViewController.m
//  AllDemo
//
//  Created by LHWen on 2018/12/11.
//  Copyright © 2018 yuhui. All rights reserved.
//

#import "SideslipTableViewController.h"
#import "TestCell.h"

@interface SideslipTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tDataArr;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSArray *tArray;

@end

@implementation SideslipTableViewController

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorColor = UIColor.orangeColor;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 13.0f, 0, 0);
        [_tableView registerClass:[TestCell class] forCellReuseIdentifier:@"kCell"];
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"SideslipTable";
    self.view.backgroundColor = [UIColor orangeColor];
    
    _tDataArr = [NSMutableArray new];
    [_tDataArr addObjectsFromArray:@[@"Abxndk", @"Bsdfsdfs", @"CDsfewe", @"Dsewrewre", @"Efsdk", @"Fsdssapi"]];
    _dataArr = @[@"置顶", @"项目状态", @"删除"];
    _tArray = @[@"合作成功", @"合作失败", @"营商中"];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    for(TestCell *tmpCell in _tableView.visibleCells) {
        [tmpCell closeMenuWithCompletionHandle:nil];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.testLb.text=_tDataArr[indexPath.row];
    __weak typeof(self) wkSelf=self;
    __weak typeof(cell) wkCell=cell;
    
    // 取消的回调
    cell.cancelCallBack=^{
        //关闭菜单
        [wkCell closeMenuWithCompletionHandle:^{
            //发送取消关注的请求
            //若请求成功，则从数据源中删除以及从界面删除
            [wkSelf.tDataArr removeObjectAtIndex:indexPath.row];
            [wkSelf.tableView reloadData];
            
        }];
    };
    //删除的回调
    cell.deleteCallBack=^{
        //关闭菜单
        [wkCell closeMenuWithCompletionHandle:^{
            //发送删除请求
            //若请求成功，则从数据源中删除以及从界面删除
            [wkSelf.tDataArr removeObjectAtIndex:indexPath.row];
            [wkSelf.tableView reloadData];
        }];
    };
    
    // 左右滑动的回调
    cell.swipCallBack=^{
        for(TestCell *tmpCell in tableView.visibleCells)
            [tmpCell closeMenuWithCompletionHandle:nil];
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50.0f;
}

@end
