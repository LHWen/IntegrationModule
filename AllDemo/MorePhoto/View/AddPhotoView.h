//
//  AddPhotoView.h
//  获取相册图片
//
//  Created by yuhui on 16/12/9.
//  Copyright © 2016年 yuhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPhotoView : UIView

@property (nonatomic, assign) UIViewController *controller;

@property (nonatomic, assign) NSInteger imageMargin;   // 图片间距
@property (nonatomic, assign) NSInteger leftMargin;    // 图片距离左边间距
@property (nonatomic, assign) NSInteger imageSize;     // 图片尺寸
@property (nonatomic, assign) NSInteger imagesInRow;   // 一行显示张数
@property (nonatomic, assign) NSInteger maxImagesCount;  // 一次可选择照片最多张数

- (void)initView;

- (NSArray *) getArray;

@end
