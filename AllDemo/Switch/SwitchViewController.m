//
//  SwitchViewController.m
//  AllDemo
//
//  Created by LHWen on 2018/8/8.
//  Copyright © 2018年 yuhui. All rights reserved.
//

#import "SwitchViewController.h"
#import "SwitchTableViewCell.h"
#import "SwitchModel.h"

static NSString *const kSwitchCell = @"SwitchTableViewCell";

@interface SwitchViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation SwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"UISwitch";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArray = [SwitchModel getSwitchArray];
    
    [self p_setTableViewLayout];
}

- (void)p_setTableViewLayout {
    
    if (!_tableView) {
        _tableView = [CreateViewFactory p_initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableHeaderView = [UIView new];
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorColor = [UIColor lightGrayColor];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 13.0f, 0, 0);
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[SwitchTableViewCell class] forCellReuseIdentifier:kSwitchCell];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSwitchCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SwitchModel *model = _dataArray[indexPath.row];
    
    cell.titleStr = model.title;
    cell.indexRow = indexPath.row;
    cell.isOpen = model.isOpen;
    
    cell.completion = ^(NSInteger row, BOOL isOpen) {
        SwitchModel *sModel = _dataArray[row];
        sModel.open = isOpen;
        
        if (sModel.open) {
            NSLog(@"%d row change switch is on", row);
        } else {
            NSLog(@"%d row change switch is off", row);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexPath *reloadIndexPath = [NSIndexPath indexPathForRow:row inSection:indexPath.section];
            [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:reloadIndexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
        });
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
