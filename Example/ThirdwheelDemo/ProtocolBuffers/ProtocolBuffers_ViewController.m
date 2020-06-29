//
//  ProtocolBuffers_ViewController.m
//  ThirdwheelDemo_Example
//
//  Created by Chen jiemin on 2020/6/28.
//  Copyright © 2020 chenjm. All rights reserved.
//

#import "ProtocolBuffers_ViewController.h"
#import <Protobuf/GPBProtocolBuffers.h>
#import "SearchRequest.pbobjc.h"

@interface ProtocolBuffers_ViewController ()

@end

@implementation ProtocolBuffers_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:textView];
    textView.text = @"\n 1. 安装protoc；\n 2. 通过'protoc ./SearchRequest.proto --objc_out=./'生成SearchRequest.pbobjc.h和SearchRequest.pbobjc.m； \n 3. 导入SearchRequest.pbobjc.h和SearchRequest.pbobjc.m，开始使用SearchRequest类";
    
    
    
    SearchRequest *request = [[SearchRequest alloc] init];
    request.query = @"query..";
    request.pageNumber = 32;
    request.resultPerPage = 300;
    
    //以下是效率对比
    //protocbufer
    NSLog(@"protocbufer: %@",request);
    NSLog(@"pb data.length:%lu",[request data].length);
    
    //json
    NSDictionary *pj = @{@"query":@"query..",
                         @"pageNumber":@32,
                         @"resultPerPage":@300};
    
    NSData *jsd = [NSJSONSerialization dataWithJSONObject:pj options:0 error:nil];
    NSLog(@"JSON: %@",pj);
    NSLog(@"JSON data.length:%lu", jsd.length);
        
    //xml
    NSString *xml = @"<query>query..</query><pageNumber>32</pageNumber><resultPerPage>300</resultPerPage>";
    NSData *xmlData = [xml dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"XML: %@",xml);
    NSLog(@"xml data.length:%lu",xmlData.length);
}


@end
