//
//  ViewController.m
//  demo11_NSOperationInvocation
//
//  Created by LuoShimei on 16/5/12.
//  Copyright © 2016年 罗仕镁. All rights reserved.
//

/**
 打印输出结果：
     whoami...
     current thread:<NSThread: 0x7fb121405b00>{number = 1, name = main}
     whoami...
     show
     current thread:<NSThread: 0x7fb121505060>{number = 2, name = (null)}
     current thread:<NSThread: 0x7fb12148c880>{number = 3, name = (null)}
 
 总结：
     NSOperactionQueue队列只有两种队列：
     1.主队列，[NSOperactionQueue mainQueue]，同步串行
     2.自定义的队列，异步并行
 
 **/

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

/** 同步执行 */
- (IBAction)operationSync:(id)sender {
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(print) object:nil];
    
    //本质上就是把一些操作封装成对象，我们可以在适当的时机来激活对象
    //[invocationOperation start];
    
    //获取到主队列
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    
    //将操作的对象放入到主队列中，操作聚会被激活
    [mainQueue addOperation:invocationOperation];
}

- (void)print{
    NSLog(@"whoami...");
    NSLog(@"current thread:%@",[NSThread currentThread]);
}

- (void)show{
    NSLog(@"show");
    NSLog(@"current thread:%@",[NSThread currentThread]);
}

/** 异步执行 */
- (IBAction)operationAsync:(id)sender {
    NSInvocationOperation *invocation_0 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(print) object:nil];
    NSInvocationOperation *invocation_1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(show) object:nil];
    
    //自定义队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //将操作添加到队列中
    [queue addOperation:invocation_0];
    [queue addOperation:invocation_1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
