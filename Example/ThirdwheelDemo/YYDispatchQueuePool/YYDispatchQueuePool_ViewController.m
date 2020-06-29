//
//  YYDispatchQueuePool_ViewController.m
//  ThirdwheelDemo_Example
//
//  Created by Chen jiemin on 2020/6/23.
//  Copyright © 2020 chenjm. All rights reserved.
//

#import "YYDispatchQueuePool_ViewController.h"
#import <YYDispatchQueuePool/YYDispatchQueuePool.h>

@interface YYDispatchQueuePool_ViewController ()

@end

@implementation YYDispatchQueuePool_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    for (int i = 0; i< 100; i ++) {
        dispatch_queue_t queue = [self getQueue1];
        dispatch_async(queue, ^{
            NSLog(@"%@",[NSThread currentThread]);
        });
    }
}

- (dispatch_queue_t)getQueue1 {
    // 1. 从全局的 queue pool 中获取一个 queue
    dispatch_queue_t queue = YYDispatchQueueGetForQOS(NSQualityOfServiceUtility);
    return queue;
}

- (dispatch_queue_t)getQueue2 {
    // 2. 创建一个新的 serial queue pool
    YYDispatchQueuePool *pool = [[YYDispatchQueuePool alloc] initWithName:@"file.read" queueCount:2 qos:NSQualityOfServiceBackground];
    return [pool queue];
}

@end
