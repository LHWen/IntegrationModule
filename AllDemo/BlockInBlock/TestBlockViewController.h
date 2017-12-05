//
//  TestBlockViewController.h
//  AllDemo
//
//  Created by LHWen on 2017/10/10.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TestCompletion)(NSString *StrBok);

@interface TestBlockViewController : UIViewController

@property (nonatomic, copy) TestCompletion complet;

- (void)testChilckBlock:(TestCompletion)comple;

@end
