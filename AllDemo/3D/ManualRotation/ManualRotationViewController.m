//
//  ManualRotationViewController.m
//  AllDemo
//
//  Created by LHWen on 2018/1/31.
//  Copyright © 2018年 yuhui. All rights reserved.
//

#import "ManualRotationViewController.h"

@interface ManualRotationViewController ()

@property (nonatomic, strong) NSArray *imageArr;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) CGPoint diceAngle;

@end

@implementation ManualRotationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"3D手动旋转";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _imageArr = @[@"3DRotate1", @"3DRotate2", @"3DRotate3", @"3DRotate4", @"3DRotate5", @"3DRotate6"];
    [self p_setContentView];
    
    //add cube face 1
    CATransform3D diceTransform = CATransform3DIdentity;
    diceTransform = CATransform3DTranslate(diceTransform, 0, 0, kSCREENWIDTH/4);   // 图片视图一半
    [self addFace:0 withTransform:diceTransform];
    
    //add cube face 2
    diceTransform = CATransform3DTranslate(CATransform3DIdentity, kSCREENWIDTH/4, 0, 0);
    diceTransform = CATransform3DRotate(diceTransform, M_PI_2, 0, 1, 0);
    [self addFace:1 withTransform:diceTransform];
    
    //add cube face 3
    //move this code after the setup for face no. 6 to enable button
    diceTransform = CATransform3DTranslate(CATransform3DIdentity, 0, -(kSCREENWIDTH/4), 0);
    diceTransform = CATransform3DRotate(diceTransform, M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:diceTransform];
    
    //add cube face 4
    diceTransform = CATransform3DTranslate(CATransform3DIdentity, 0, kSCREENWIDTH/4, 0);
    diceTransform = CATransform3DRotate(diceTransform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:diceTransform];
    
    //add cube face 5
    diceTransform = CATransform3DTranslate(CATransform3DIdentity, -(kSCREENWIDTH/4), 0, 0);
    diceTransform = CATransform3DRotate(diceTransform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:diceTransform];
    
    //add cube face 6
    diceTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 0, -(kSCREENWIDTH/4));
    diceTransform = CATransform3DRotate(diceTransform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:diceTransform];
}

- (void)p_setContentView {
    
    _contentView = [CreateViewFactory p_setViewBGColor:[UIColor orangeColor]];
    _contentView.frame = CGRectMake(0, 0, kSCREENWIDTH - 40, kSCREENWIDTH - 40);
    _contentView.center = self.view.center;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(viewTransform:)];
    [self.contentView addGestureRecognizer:pan];
    [self.view addSubview:_contentView];
}

- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform {
    
    UIImageView *face = [CreateViewFactory p_setImageViewImageName:_imageArr[index]];
    face.frame = CGRectMake(0, 0, kSCREENWIDTH/2, kSCREENWIDTH/2);
    [_contentView addSubview:face];
    
    CGSize containerSize = _contentView.bounds.size;
    face.center = CGPointMake(containerSize.width / 2.0, containerSize.height / 2.0);
    
    face.layer.transform = transform;
    face.layer.doubleSided = NO;
}

- (void)viewTransform:(UIPanGestureRecognizer *)sender {
    
    CGPoint point = [sender translationInView:_contentView];
    CGFloat angleX = self.diceAngle.x + (point.x/30);
    CGFloat angleY = self.diceAngle.y - (point.y/30);
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1 / 500;
    transform = CATransform3DRotate(transform, angleX, 0, 1, 0);
    transform = CATransform3DRotate(transform, angleY, 1, 0, 0);
    self.contentView.layer.sublayerTransform = transform;
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        self.diceAngle = CGPointMake(angleX, angleY);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
