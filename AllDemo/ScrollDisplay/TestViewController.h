//
//  TestViewController.h
//  AllDemo
//
//  Created by yuhui on 17/1/5.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AllViewControllerType) {
    AllViewControllerTypeOne = 0,
    AllViewControllerTypeTwo = 1,
    AllViewControllerTypeThree = 2,
    AllViewControllerTypeFour = 3,
    AllViewControllerTypefive = 4,
    AllViewControllerTypeSix = 5,
    AllViewControllerTypeSeven = 6
};

@interface TestViewController : UIViewController

//传入需要的变量确定来显示的是哪一页
@property (nonatomic,assign)AllViewControllerType type;


@end
