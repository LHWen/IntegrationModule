//
//  MoveCollectionViewController.m
//  AllDemo
//
//  Created by LHWen on 2017/6/30.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "MoveCollectionViewController.h"
#import "SimpleCollectionViewCell.h"

static NSString *const collectionViewCell = @"SimpleCollectionViewCell";

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

@interface MoveCollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MoveCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"MoveCollectionView";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;  // 横向滑动
    _flowLayout.minimumInteritemSpacing = 5;  // 左右中间间隔距离
    _flowLayout.minimumLineSpacing = 5;       // 选项间上下距离间距
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[SimpleCollectionViewCell class] forCellWithReuseIdentifier:collectionViewCell];
    
    //此处给其增加长按手势，用此手势触发cell移动效果
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
    longGesture.minimumPressDuration = 0.5f;//触发长按事件时间为：秒
    [_collectionView addGestureRecognizer:longGesture];
    
    [self.view addSubview:_collectionView];
    
    _dataArray = [NSMutableArray array];
    
    for (int i = 0; i < 6; i++) {
        [_dataArray addObject:[NSString stringWithFormat:@"第%d项标题", i]];
    }
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SimpleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    cell.layer.borderWidth = 0.5;
    cell.layer.borderColor = [UIColor grayColor].CGColor;
    
    cell.titleLable.text = _dataArray[indexPath.row];
    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width - 20, 60);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

// 设置是否可以选择cell
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

// 设置是否支持高亮
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (IOS_VERSION >= 9 ) {
//        return YES;
//    }else{
//        return NO;
//    }
//    开启 item 是否可选，如果可选，需要开启高亮
    return YES;
}

// 设置高亮 颜色
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor orangeColor];
}

// 取消高亮后 颜色
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor greenColor];
}

// 选择项
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%@", _dataArray[indexPath.row]);
}

#pragma mark 监听手势，并设置其允许移动cell和交换资源
- (void)handlelongGesture:(UILongPressGestureRecognizer *)longGesture {
   
    if (IOS_VERSION < 9.0) {
        //iOS9之前
        [self action:longGesture];
    }else{
        //iOS9及其以上版本
        [self iOS9_Action:longGesture];
    }
}

#pragma mark item拖动 iOS9 后才有
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    //返回YES允许其item移动
    if (indexPath.section == 0) {
        return YES;
    }
    else{
        return NO;
    }
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    
    if (sourceIndexPath.section == destinationIndexPath.section) {
        
        //取出源item数据 更新
        id objc = [_dataArray objectAtIndex:sourceIndexPath.item];
        //从资源数组中移除该数据
        [_dataArray removeObject:objc];
        
        //将数据插入到资源数组中的目标位置上
        [_dataArray insertObject:objc atIndex:destinationIndexPath.item];
    }
    
}

// ------------------ ios 9 之后 添加手势进行移动 ---------------
- (void)iOS9_Action:(UILongPressGestureRecognizer *)longGesture{
    
    switch (longGesture.state) {
        case UIGestureRecognizerStateBegan:{ // 手势开始
            //判断手势落点位置是否在Item上
            NSIndexPath *indexPath = [_collectionView indexPathForItemAtPoint:[longGesture locationInView:_collectionView]];
            if (indexPath == nil) {
                break;
            }
            if (indexPath.section == 0) { // && _managed  是否开启管理
                UICollectionViewCell *cell = [_collectionView cellForItemAtIndexPath:indexPath];
                [_collectionView bringSubviewToFront:cell];
                //在Item上则开始移动该Item的cell
                [_collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            }
            
        }
            break;
        case UIGestureRecognizerStateChanged:{//手势改变
            //移动过程当中随时更新cell位置
            
            [_collectionView updateInteractiveMovementTargetPosition:[longGesture locationInView:_collectionView]];
        }
            break;
        case UIGestureRecognizerStateEnded:{//手势结束
            //移动结束后关闭cell移动
            
            [_collectionView endInteractiveMovement];
        }
            break;
        default://手势其他状态
            
            [_collectionView cancelInteractiveMovement];
            break;
    }
}


//---------------------- --- ios 9 之前移动实现 START --- ------------------------
#pragma mark item拖动 iOS9之前，需要截图等操作
static UIView *snapedView;              //截图快照
static NSIndexPath *currentIndexPath;   //当前路径
static NSIndexPath *oldIndexPath;       //旧路径

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath willMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    
    //取出源item数据 更新
    id objc = [_dataArray objectAtIndex:sourceIndexPath.item];
    //从资源数组中移除该数据
    [_dataArray removeObject:objc];
    //将数据插入到资源数组中的目标位置上
    [_dataArray insertObject:objc atIndex:destinationIndexPath.item];
}

- (void)action:(UILongPressGestureRecognizer *)longGesture{
    
    switch (longGesture.state) {
        case UIGestureRecognizerStateBegan:{//手势开始
            //判断手势落点位置是否在Item上
            oldIndexPath = [_collectionView indexPathForItemAtPoint:[longGesture locationInView:_collectionView]];
            if (oldIndexPath == nil) {
                break;
            }
            if (oldIndexPath.section == 0) { // && _managed // 是否开启管理
                UICollectionViewCell *cell = [_collectionView cellForItemAtIndexPath:oldIndexPath];
                //使用系统截图功能，得到cell的截图视图
                snapedView = [cell snapshotViewAfterScreenUpdates:NO];
                snapedView.frame = cell.frame;
                
                [_collectionView addSubview:snapedView];
                
                //截图后隐藏当前cell
                cell.hidden = YES;
                CGPoint currentPoint = [longGesture locationInView:_collectionView];
                [UIView animateWithDuration:0.25 animations:^{
                    snapedView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
                    snapedView.center = CGPointMake(currentPoint.x, currentPoint.y);
                }];
            }
        }
            break;
        case UIGestureRecognizerStateChanged:{//手势改变
            
            CGPoint currentPoint = [longGesture locationInView:_collectionView];
            snapedView.center = CGPointMake(currentPoint.x, currentPoint.y);
            
            //计算截图视图和哪个cell相交
            for (UICollectionViewCell *cell in [_collectionView visibleCells]) {
                //当前隐藏的cell就不需要交换了，直接continue
                if ([_collectionView indexPathForCell:cell] == oldIndexPath) {
                    continue;
                }
                //计算中心距
                CGFloat space = sqrtf(pow(snapedView.center.x - cell.center.x, 2) + powf(snapedView.center.y - cell.center.y, 2));
                //如果相交一半就移动
                if (space <= snapedView.bounds.size.width / 4) {
                    currentIndexPath = [_collectionView indexPathForCell:cell];
                    if (currentIndexPath.section == 0) {
                        
                        //移动 会调用willMoveToIndexPath方法更新数据源
                        NSString *str = [_dataArray objectAtIndex:oldIndexPath.row];
                        [_dataArray removeObjectAtIndex:oldIndexPath.row];
                        [_dataArray insertObject:str atIndex:currentIndexPath.row];
                        [_collectionView moveItemAtIndexPath:oldIndexPath toIndexPath:currentIndexPath];
                        //设置移动后的起始indexPath
                        oldIndexPath = currentIndexPath;
                    }
                    
                    break;
                }
            }
        }
            break;
        default:{//手势结束和其他状态
            UICollectionViewCell *cell = [_collectionView cellForItemAtIndexPath:oldIndexPath];
            //结束动画过程中停止交互，防止出问题
            _collectionView.userInteractionEnabled = NO;
            //给截图视图一个动画移动到隐藏cell的新位置
            [UIView animateWithDuration:0.25 animations:^{
                snapedView.center = cell.center;
                snapedView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
            } completion:^(BOOL finished) {
                //移除截图视图、显示隐藏的cell并开启交互
                [snapedView removeFromSuperview];
                cell.hidden = NO;
                _collectionView.userInteractionEnabled = YES;
            }];
        }
            break;
    }
}

/** * ------------------  --- ios 9 之前的配置 END ---  ----------------- * */


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
