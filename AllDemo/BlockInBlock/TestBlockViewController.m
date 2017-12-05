//
//  TestBlockViewController.m
//  AllDemo
//
//  Created by LHWen on 2017/10/10.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "TestBlockViewController.h"
#import "TestBlockTool.h"
#import "BlockChilckViewController.h"

@interface TestBlockViewController ()

@end

@implementation TestBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Block";
    self.view.backgroundColor = [UIColor greenColor];
    
    [TestBlockTool startTaskWithCallBack:^(id<NSObject> obj, NSError *error, id stat) {
      
        NSLog(@"*---- TestBlockViewController Start---*");
        
        NSLog(@"obj = %@, stat = %@", [NSString stringWithFormat:@"%@", obj], stat);
        
        NSLog(@"*---- TestBlockViewController End---*");
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 50, 50, 50);
    [button setTitle:@"跳转" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickStatButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)clickStatButton:(UIButton *)sender {
    
    BlockChilckViewController *vc = [[BlockChilckViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)testChilckBlock:(TestCompletion)comple {
    
    self.complet = comple;
    self.complet(@"测试成功");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
