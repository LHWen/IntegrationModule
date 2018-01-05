//
//  CustomViewController.m
//  AllDemo
//
//  Created by LHWen on 2018/1/5.
//  Copyright © 2018年 yuhui. All rights reserved.
//

#import "CustomViewController.h"
#import "CustomVideoTableViewCell.h"
#import "CustomVideoPlayer.h"
#import "VideoItemModel.h"

static NSString *const videoListUrl = @"http://c.3g.163.com/nc/video/list/VAP4BFR16/y/0-10.html";
static NSString *const kVideoCell = @"CustomVideoTableViewCell";

@interface CustomViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CustomVideoPlayer *customPlayer;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CustomViewController

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[CustomVideoTableViewCell class] forCellReuseIdentifier:kVideoCell];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"自定义视频播放器";
    
    _dataArray = [NSMutableArray new];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self loadData];
}

- (void)loadData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:videoListUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"----downloadProgress=%@", downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"VAP4BFR16"] isKindOfClass:[NSArray class]]) {
            NSArray *videoArray = responseObject[@"VAP4BFR16"];
            for (NSDictionary *dict in videoArray) {
                
                NSString *title = dict[@"title"];
                NSString *cover = dict[@"cover"];
                NSString *mp4_url = dict[@"mp4_url"];
                
                VideoItemModel *model = [[VideoItemModel alloc] init];
                model.title = title;
                model.cover = cover;
                model.mp4_url = mp4_url;
                
                [_dataArray addObject:model];
            }
            
            [self.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"-----error=%@", error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kVideoCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    VideoItemModel *model = _dataArray[indexPath.row];
    
    cell.indexPath = indexPath;
    cell.itemModel = model;
    
    cell.customVideoBlock = ^(NSIndexPath *index, CGRect imgFrame) {
        [self showVideoPlayerFrame:imgFrame indexPath:indexPath];
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 177.0f;
}

- (void)showVideoPlayerFrame:(CGRect)frame indexPath:(NSIndexPath *)indexPath {
    
    [_customPlayer destroyPlayer];
    _customPlayer = nil;
    
    VideoItemModel *modle = _dataArray[indexPath.row];
    
    CustomVideoTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    _customPlayer = [[CustomVideoPlayer alloc] init];
    _customPlayer.videoUrl = modle.mp4_url;
    [_customPlayer playerBindTableView:self.tableView currentIndexPath:indexPath];
    _customPlayer.frame = frame;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [cell.contentView addSubview:_customPlayer];
    });
    
    _customPlayer.completedPlayingBlock = ^(CustomVideoPlayer *player) {
        [player destroyPlayer];
        _customPlayer = nil;
    };
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_customPlayer destroyPlayer];
    _customPlayer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
