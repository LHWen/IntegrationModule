//
//  TestCell.m
//  AllDemo
//
//  Created by LHWen on 2018/12/11.
//  Copyright © 2018 yuhui. All rights reserved.
//

#import "TestCell.h"

@interface TestCell ()

@property(nonatomic, strong) UIView *containerView;

@end

@implementation TestCell

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self) {
        for(UIView *sub in self.contentView.subviews) {
            [sub removeFromSuperview];
        }
        [self createUI];
    }
    return self;
}

//创建UI
-(void)createUI {
    //取消关注按钮
    UIButton *cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(kWidth-100, 0, 50, 50)];
    cancelBtn.backgroundColor=[UIColor grayColor];
    [cancelBtn setTitle:@"取消\n关注" forState:UIControlStateNormal];
    cancelBtn.titleLabel.numberOfLines=0;
    cancelBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    //删除按钮
    UIButton *deleteBtn=[[UIButton alloc]initWithFrame:CGRectMake(kWidth-50, 0, 50, 50)];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    deleteBtn.backgroundColor=[UIColor redColor];
    [deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:cancelBtn];
    [self.contentView addSubview:deleteBtn];
    
    //容器视图
    _containerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 50)];
    _containerView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:_containerView];
    if(_isOpen)
        _containerView.center=CGPointMake(kWidth/2-100, _containerView.center.y);
    
    //测试Label
    _testLb=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, kWidth-20, 50)];
    [_containerView addSubview:_testLb];
    _testLb.text=@"我是左滑测试文字～";
    _testLb.backgroundColor=[UIColor whiteColor];
    
    //添加左滑手势
    UISwipeGestureRecognizer *swipLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swip:)];
    swipLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    [_containerView addGestureRecognizer:swipLeft];
    
    //添加右滑手势
    UISwipeGestureRecognizer *swipRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swip:)];
    swipRight.direction=UISwipeGestureRecognizerDirectionRight;
    [_containerView addGestureRecognizer:swipRight];
}

/** 取消关注 */
-(void)cancelAction {
    if(self.cancelCallBack)
        self.cancelCallBack();
}

/** 删除 */
-(void)deleteAction {
    if(self.deleteCallBack)
        self.deleteCallBack();
}

/**滑动手势*/
-(void)swip:(UISwipeGestureRecognizer *)sender {
    
    //滑动的回调
    if(self.swipCallBack)
        self.swipCallBack();
    
    //左滑
    if(sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        if(_isOpen)
            return;
        [UIView animateWithDuration:0.3 animations:^{
            sender.view.center=CGPointMake(sender.view.center.x-100, sender.view.center.y);
        }];
        _isOpen=YES;
    } else if(sender.direction==UISwipeGestureRecognizerDirectionRight) { //右滑
        if(!_isOpen)
            return;
        [UIView animateWithDuration:0.3 animations:^{
            sender.view.center=CGPointMake(kWidth/2, sender.view.center.y);
        }];
        _isOpen=NO;
    }
}

/** 关闭左滑菜单 */
-(void)closeMenuWithCompletionHandle:(void (^)(void))completionHandle {
    if(!_isOpen)
        return;
    __weak typeof(self) wkSelf=self;
    [UIView animateWithDuration:0.3 animations:^{
        wkSelf.containerView.center = CGPointMake(kWidth/2, wkSelf.containerView.center.y);
    }completion:^(BOOL finished) {
        if(completionHandle)
            completionHandle();
    }];
    _isOpen = NO;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
