//
//  NinaViewController.m
//  AllDemo
//
//  Created by yuhui on 17/6/6.
//  Copyright © 2017年 yuhui. All rights reserved.
//

#import "NinaViewController.h"
#import "Test1ViewController.h"
#import "Test2ViewController.h"

#import "NinaPagerView.h"

@interface NinaViewController ()

@end

@implementation NinaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Nina";
    self.view.backgroundColor = [Utility colorWithHexString:@"#E1FFFF"];
    NSArray *titleArray = @[@"One1", @"Two1", @"One2", @"Two2"];
    NSArray *vcsArray = @[@"Test1ViewController",
                          @"Test2ViewController",
                          @"Test1ViewController",
                          @"Test2ViewController"];
    
    NinaPagerView *ninapagerView = [[NinaPagerView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, 44.0f)
                                                             WithTitles:titleArray
                                                                WithVCs:vcsArray];
    
    [self.view addSubview:ninapagerView];
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
