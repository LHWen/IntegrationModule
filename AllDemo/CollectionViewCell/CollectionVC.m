//
//  CollectionVC.m
//  AllDemo
//
//  Created by yuhui on 17/1/17.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "CollectionVC.h"
#import "HeaderTableViewCell.h"
#import "ShufflingTableViewCell.h"

@interface CollectionVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CollectionVC

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[HeaderTableViewCell class] forCellReuseIdentifier:@"HeaderTableViewCell"];
        [_tableView registerClass:[ShufflingTableViewCell class] forCellReuseIdentifier:@"ShufflingTableViewCell"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"nomeronCell"];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"头部item";
    self.view.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
}

#pragma mark -- UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    if (indexPath.row == 0) {
        
        HeaderTableViewCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"HeaderTableViewCell" forIndexPath:indexPath];
        [headerCell setWithItemArr:@[[UIImage imageNamed:@"pantting"],[UIImage imageNamed:@"music"],[UIImage imageNamed:@"dancing "], [UIImage imageNamed:@"musical"], [UIImage imageNamed:@"preform"], [UIImage imageNamed:@"musical"], [UIImage imageNamed:@"music"], [UIImage imageNamed:@"pantting"], [UIImage imageNamed:@"preform"],[UIImage imageNamed:@"pantting"], [UIImage imageNamed:@"music"], [UIImage imageNamed:@"pantting"]]];
        [headerCell setWithItemArrStr:@[@"美术", @"音乐", @"舞蹈", @"乐器", @"表演", @"美术", @"美术", @"美术", @"美术", @"美术", @"美术", @"美术"]];
        return headerCell;
        
    } else if (indexPath.row == 1) {
        ShufflingTableViewCell *shufflingCell = [tableView dequeueReusableCellWithIdentifier:@"ShufflingTableViewCell" forIndexPath:indexPath];
        [shufflingCell setWithItemArr:@[[UIImage imageNamed:@"banner1"],[UIImage imageNamed:@"banner2"],[UIImage imageNamed:@"banner3"]]];
        return shufflingCell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nomeronCell"];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 118;
    }
    return 178;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter]postNotification:[NSNotification notificationWithName:@"shutTimer" object:nil userInfo:nil]];
}

@end
