//
//  CustomerViewController.m
//  HealthySettle
//
//  Created by yrc on 16/3/17.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "CustomerViewController.h"
#import "DDTestApi.h"
#import "DDTestApiS.h"
#import "YTKBatchRequest.h"
@interface CustomerViewController ()
@end
@implementation CustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    DDTestApi * ddTestApi = [[DDTestApi alloc] init];
//    [ddTestApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
//        NSLog(@"%@正常",request.responseData);
//        NSLog(@"%d",(int)request.responseStatusCode);
//
//    } failure:^(__kindof YTKBaseRequest *request) {
//        NSLog(@"%@错误",request.requestOperation);
//        NSLog(@"%d",(int)request.responseStatusCode);
//    }];

    
//    [ddTestApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
////        NSLog(@"%@", (NSDictionary )request.responseData);
//        
////        NSDictionary * dic = [NSDictionary]
//    } failure:^(__kindof YTKBaseRequest *request) {
//        
//        
//    }];
//    YTKBatchRequest * batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:@[ddTestApi,testApi]];
//    [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest *batchRequest) {
//        YTKBaseRequest *request1 = batchRequest.requestArray.firstObject;
//        YTKBaseRequest *request2 = batchRequest.requestArray.lastObject;
//        NSLog(@"%d, %d",(int)request1.responseStatusCode,(int)request2.responseStatusCode);
//    } failure:^(YTKBatchRequest *batchRequest) {
//        YTKBaseRequest *request1 = batchRequest.requestArray.firstObject;
//        YTKBaseRequest *request2 = batchRequest.requestArray.lastObject;
//        NSLog(@"%d, %d",(int)request1.responseStatusCode,(int)request2.responseStatusCode);
//        
//    }];
    
    
//    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
//    [dic setObject:@"v1" forKey:@"k1"];
//    [dic setObject:@"v2" forKey:@"k2"];
//    [dic setObject:@"v3" forKey:@"k3"];
//    NSArray *array=[NSArray arrayWithObjects:@"2",@"3",@"4",@"5",nil];
//    
//    
//    
//    [dic setObject:array forKey:@"k4"];
//    
//    id obj=[dic valueForKeyPath:@"k4.@sum.floatValue"];
//    
//    NSLog(@"%@",[obj description]);//==14
    
    
    

    
    
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
