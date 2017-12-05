//
//  BlockChilckViewController.m
//  AllDemo
//
//  Created by LHWen on 2017/10/25.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "BlockChilckViewController.h"

@interface BlockChilckViewController ()

@end

@implementation BlockChilckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(150, 50, 50, 50);
    [button setTitle:@"click" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)clickButton:(UIButton *)sender {
    
    [self testChilckBlock:^(NSString *StrBok) {
        NSLog(@"------sting %@-----", StrBok);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
