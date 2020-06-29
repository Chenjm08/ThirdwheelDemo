//
//  CJMViewController.m
//  ThirdwheelDemo
//
//  Created by chenjm on 06/23/2020.
//  Copyright (c) 2020 chenjm. All rights reserved.
//

#import "CJMViewController.h"

@interface CJMViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *dataSources;
@property (nonatomic, strong) NSArray *details;
@end

@implementation CJMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"第三方库demo";
    
    _dataSources = @[@"YYKeyboardManager", @"YYDispatchQueuePool", @"ProtocolBuffers"];
    _details = @[@"键盘管理，检测键盘高度，一般用于适当调整输入框或其他UI",
                 @"分发线程池，用一个全局的 serial queue pool 来尽量控制全局线程数",
                 @"Protobuf是由Google推出的一种轻便高效的结构化数据存储格式，可以用于结构化数据串行化，或者说序列化。"
    ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSources.count;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *vcStr = [_dataSources objectAtIndex:indexPath.row];
    Class aClass = NSClassFromString([vcStr stringByAppendingString:@"_ViewController"]);
    UIViewController *vc = [[aClass alloc] init];
    [self.navigationController pushViewController:vc animated:YES];    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *vcStr = [_dataSources objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = vcStr;
    cell.detailTextLabel.text = [_details objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

@end
