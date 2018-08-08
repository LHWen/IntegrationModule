//
//  MakeSocketViewController.m
//  AllDemo
//
//  Created by LHWen on 2018/6/7.
//  Copyright © 2018年 yuhui. All rights reserved.
//

#import "MakeSocketViewController.h"
#import "SocketUtility.h"

@interface MakeSocketViewController ()

@end

@implementation MakeSocketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 使用Facebook封装的socket https://www.jianshu.com/p/821b777555d3
    
    self.navigationItem.title = @"socket通信";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *statBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    statBtn.frame = CGRectMake(60, 70, 120, 40);
    statBtn.backgroundColor = [UIColor greenColor];
    [statBtn setTitle:@"开启通信" forState:UIControlStateNormal];
    [statBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [statBtn addTarget:self action:@selector(stateScoket) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:statBtn];
    
    UIButton *endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    endBtn.frame = CGRectMake(60, 130, 120, 40);
    endBtn.backgroundColor = [UIColor orangeColor];
    [endBtn setTitle:@"关闭通信" forState:UIControlStateNormal];
    [endBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [endBtn addTarget:self action:@selector(endScoket) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:endBtn];
}

// 开启socket通信
- (void)stateScoket {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SRWebSocketDidOpen) name:kWebSocketDidOpenNote object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SRWebSocketDidReceiveMsg:) name:kWebSocketdidReceiveMessageNote object:nil];
    [[SocketUtility instance] SRWebSocketOpenWithURLString:@"ws://192.168.1.75:1414/v1/ws"];
    
    [SocketUtility instance].completion = ^(id<NSObject> obj) {
        NSLog(@"get socket message : %@", obj);
    };
}

// 关闭socket通信
- (void)endScoket {
    [[NSNotificationCenter defaultCenter] removeObserver:kWebSocketDidOpenNote];
    [[NSNotificationCenter defaultCenter] removeObserver:kWebSocketDidCloseNote];
    [[SocketUtility instance] SRWebSocketClose];
}

- (void)SRWebSocketDidOpen {
    
    NSLog(@"开启成功");
    //在成功后需要做的操作。。。
}

- (void)SRWebSocketDidReceiveMsg:(NSNotification *)note {
    
    //收到服务端发送过来的消息
    NSString * message = note.object;
    NSLog(@"%@",message);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
