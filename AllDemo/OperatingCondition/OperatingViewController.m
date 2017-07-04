//
//  OperatingViewController.m
//  AllDemo
//
//  Created by yuhui on 17/6/22.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "OperatingViewController.h"
#import "OperationHeaderView.h"

@interface OperatingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation OperatingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setTableViewLayout];
}

- (void)setTableViewLayout {
    
    if (!_tableView) {
        
        OperationHeaderView *headerView = [[OperationHeaderView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, 160.0f)];
        
        
        _tableView = [[UITableView alloc] init];
        _tableView.frame = CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT - 64.0f);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor grayColor];
        _tableView.tableHeaderView = headerView;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.showsVerticalScrollIndicator = NO;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
        [self.view addSubview:_tableView];
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
