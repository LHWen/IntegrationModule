//
//  TestViewController.m
//  AllDemo
//
//  Created by yuhui on 17/1/5.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titlesArray;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titlesArray = @[@"天枢", @"天璇", @"天玑", @"天权", @"玉衡", @"开阳", @"瑶光"];
    
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = self.view.bounds;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"testCell"];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_type == 2) {
        return 3;
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"testCell"];
    
    cell.textLabel.text = _titlesArray[_type];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"type = %ld", _type);
}





@end
