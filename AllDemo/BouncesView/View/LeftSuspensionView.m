//
//  LeftSuspensionView.m
//  AllDemo
//
//  Created by LHWen on 2017/12/5.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "LeftSuspensionView.h"

@interface LeftSuspensionView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

//-----左侧滑动判断----
@property (nonatomic, assign) CGFloat statrX;
@property (nonatomic, assign) BOOL isLeftMove;

@end

@implementation LeftSuspensionView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        [self setup];
        
        return self;
    }
    return nil;
}

- (void)setup {
 
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    
    _dataArray = @[@"  个人装扮", @"  我的收藏", @"  我的相册", @"  我的文件", @"  设置"];
    _isLeftMove = NO;
    
    _headerView = [CreateViewFactory p_setViewBGColor:[UIColor greenColor]];
    _headerView.frame = CGRectMake(0, 0, -(kSCREENWIDTH/4 * 3), 200);
    [_headerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeaderView:)]];
    [self addSubview:_headerView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, -(kSCREENWIDTH/4 * 3), kSCREENHEIGHT)
                                              style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.estimatedRowHeight = 0;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.tableFooterView = [[UIView alloc] init];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableCell"];
    [self addSubview:_tableView];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
        _headerView.frame = CGRectMake(0, 0, kSCREENWIDTH/4 * 3, 200);
        _tableView.frame = CGRectMake(0, 200, kSCREENWIDTH/4 * 3, kSCREENHEIGHT);
    }];
}

- (void)tapHeaderView:(UITapGestureRecognizer *)tap {
    
    NSLog(@"headerVeiw");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (_isLeftMove) {
        [UIView animateWithDuration:0.3f animations:^{
            
            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
            _headerView.frame = CGRectMake(-(kSCREENWIDTH/4 * 3), 0, kSCREENWIDTH/4 * 3, 200);
            _tableView.frame = CGRectMake(-(kSCREENWIDTH/4 * 3), 200, kSCREENWIDTH/4 * 3, kSCREENHEIGHT);
            _isLeftMove = NO;
        } completion:^(BOOL finished) {
            
            self.completeAnimate(YES);
        }];
    }else {
       
        [UIView animateWithDuration:0.3f animations:^{
            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
            _headerView.frame = CGRectMake(0, 0, kSCREENWIDTH/4 * 3, 200);
            _tableView.frame = CGRectMake(0, 200, kSCREENWIDTH/4 * 3, kSCREENHEIGHT);
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    _statrX = [[touches anyObject] locationInView:self].x;
    _isLeftMove = YES;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CGFloat moveX = [[touches anyObject] locationInView:self].x;
    
    CGFloat pX = _statrX - moveX;
    
    if (pX >= 0) {
        _tableView.frame = CGRectMake(-pX, 200, kSCREENWIDTH/4 * 3, kSCREENHEIGHT);
        _headerView.frame = CGRectMake(-pX, 0, kSCREENWIDTH/4 * 3, 200);
        
        if (pX >= kSCREENWIDTH/5*2) {
            _isLeftMove = YES;
        }else {
           _isLeftMove = NO;
        }
    }else {
        _isLeftMove = NO;
        _tableView.frame = CGRectMake(0, 200, kSCREENWIDTH/4 * 3, kSCREENHEIGHT);
        _headerView.frame = CGRectMake(0, 0, kSCREENWIDTH/4 * 3, 200);
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"---%@---", _dataArray[indexPath.row]);
}

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

@end
