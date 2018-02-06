//
//  DispatchSemaphoreViewController.m
//  AllDemo
//
//  Created by LHWen on 2018/1/30.
//  Copyright © 2018年 yuhui. All rights reserved.
//

#import "DispatchSemaphoreViewController.h"

@interface DispatchSemaphoreViewController ()

@property (nonatomic, strong) dispatch_semaphore_t semaA;
@property (nonatomic, strong) dispatch_semaphore_t semaB;
@property (nonatomic, strong) dispatch_semaphore_t semaC;

@end

@implementation DispatchSemaphoreViewController

- (dispatch_semaphore_t)semaA {
    
    if (!_semaA) {
        _semaA = dispatch_semaphore_create(0);
    }
    return _semaA;
}

- (dispatch_semaphore_t)semaB {
    if (!_semaB) {
        _semaB = dispatch_semaphore_create(0);
    }
    return _semaB;
}

- (dispatch_semaphore_t)semaC {
    if (!_semaC) {
        _semaC = dispatch_semaphore_create(0);
    }
    return _semaC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Block顺序执行";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *showLabel = [CreateViewFactory p_setLableClearBGColorOneLineText:@"信息在控制台打印"
                                                                     textFont:18
                                                                    textColor:[UIColor blackColor]
                                                                textAlignment:NSTextAlignmentCenter];
    showLabel.frame = CGRectMake(20, 40, 200, 30);
    [self.view addSubview:showLabel];
    
    [self p_setThread];
}

- (void)p_setThread {
    
    dispatch_queue_t requestQueue = dispatch_queue_create("com.requestQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(requestQueue, ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 通过信号量通知
            // 执行requestA请求完成后的TaskA
            dispatch_semaphore_signal(self.semaA);
        });
    });
    
    dispatch_async(requestQueue, ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_semaphore_signal(self.semaB);
        });
    });
    
    dispatch_async(requestQueue, ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_semaphore_signal(self.semaC);
        });
    });
    
    // 这里注意一下!
    // 如果不新建一个线程，而直接将上方的 `保证顺序执行回调` 代码放在这里
    // 穿行队列会将自己队列中的任务放在主线程中执行，从而造成主线程阻塞（假死状态）
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(taskQueue) object:nil];
    [thread start];
}

- (void)taskQueue {
    
    dispatch_queue_t taskQueue = dispatch_queue_create("com.taskQueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(taskQueue, ^{
        [self taskA];
    });
    
    dispatch_sync(taskQueue, ^{
        [self taskB];
    });
    
    dispatch_sync(taskQueue, ^{
        [self taskC];
    });
}

- (void)taskA {
    dispatch_semaphore_wait(self.semaA, DISPATCH_TIME_FOREVER);
    NSLog(@"A Done !");
}

- (void)taskB {
    dispatch_semaphore_wait(self.semaB, DISPATCH_TIME_FOREVER);
    NSLog(@"B Done !");
}

- (void)taskC {
    dispatch_semaphore_wait(self.semaC, DISPATCH_TIME_FOREVER);
    NSLog(@"C Done !");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
