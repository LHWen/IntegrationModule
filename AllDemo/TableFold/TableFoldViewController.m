//
//  TableFoldViewController.m
//  AllDemo
//
//  Created by yuhui on 16/12/27.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import "TableFoldViewController.h"
#import "HWFoldHeaderView.h"

@interface TableFoldViewController () <UITableViewDataSource,UITableViewDelegate, HWFoldSectionHeaderViewDelegate>

@property(nonatomic, strong) UITableView* tableView;
@property(nonatomic, strong) NSArray* arr;

/** 存储开关字典 */
@property(nonatomic, strong) NSDictionary* foldInfoDic;

@end

@implementation TableFoldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"表格折叠";
    self.view.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
    
    [self creatArr];
    [self creatTableView];
}

- (void)creatArr {
    _arr = @[@"123445",@"12412421",@"3243243",@"12313",@"324324",@"132311",@"3423",@"3423432"];
    _foldInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                   @"0":@"0",
                                                                   @"1":@"0",
                                                                   @"2":@"0",
                                                                   @"3":@"0"
                                                                   }];
}

- (void)creatTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT-64.0f) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSString *key = [NSString stringWithFormat:@"%d", (int)section];
    BOOL folded = [[_foldInfoDic objectForKey:key] boolValue];
    
    if (section == 0) {
        return folded ? _arr.count:0;
    } else if (section == 1) {
        return folded ? _arr.count:0;
    } else if (section == 2) {
        return folded ? _arr.count:0;
    } else {
        return folded ? _arr.count:0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HWFoldHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!headerView) {
        headerView = [[HWFoldHeaderView alloc] initWithReuseIdentifier:@"header"];
    }
    
    if (section == 0) {
        [headerView setFoldSectionHeaderViewWithTitle:@"第一个Section" detail:@"9999" type: HerderStyleTotal section:0 canFold:YES width:kSCREENWIDTH];
    } else if (section == 1) {
        [headerView setFoldSectionHeaderViewWithTitle:@"第二个Section" detail:@"8888" type:HerderStyleTotal section:1 canFold:YES width:kSCREENWIDTH];
    } else if (section == 2){
        [headerView setFoldSectionHeaderViewWithTitle:@"第三个Section" detail:nil type:HerderStyleNone section:2 canFold:NO width:kSCREENWIDTH];
    } else {
        [headerView setFoldSectionHeaderViewWithTitle:@"第四个Seciton" detail:@"777" type:HerderStyleTotal section:3 canFold:YES width:kSCREENWIDTH];
    }
    
    headerView.delegate = self;
    NSString *key = [NSString stringWithFormat:@"%d", (int)section];
    BOOL folded = [[_foldInfoDic valueForKey:key] boolValue];
    headerView.fold = folded;
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [_arr objectAtIndex:indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (void)foldHeaderSection:(NSInteger)SectionHeader
{
    NSString *key = [NSString stringWithFormat:@"%d",(int)SectionHeader];
    BOOL folded = [[_foldInfoDic objectForKey:key] boolValue];
    NSString *fold = folded ? @"0" : @"1";
    [_foldInfoDic setValue:fold forKey:key];
    NSMutableIndexSet *set = [[NSMutableIndexSet alloc] initWithIndex:SectionHeader];
    /** 修改展开动画 */
    [_tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"select %ld, indexpath %ld", indexPath.section, indexPath.row);
}


@end
