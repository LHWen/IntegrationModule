//
//  ImageTextView.h
//  AllDemo
//
//  Created by LHWen on 2018/9/14.
//  Copyright © 2018年 yuhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageTextView : UIView

@property (nonatomic, copy) NSString *infoStr;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, assign) CGRect infoRect;

@end
