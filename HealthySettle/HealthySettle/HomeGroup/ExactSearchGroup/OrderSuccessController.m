//
//  OrderSuccessController.m
//  HealthySettle
//
//  Created by yrc on 17/2/15.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "OrderSuccessController.h"
#import "OrderStatusTVController.h"

@interface OrderSuccessController (){
    UIButton *_order_btn,*_show_btn;
}

@end

@implementation OrderSuccessController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)] ) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单预订成功";
    UIImageView * status_imgView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWide/2-35,screenHeight * 0.1, 70, 70)];
//    NSString * img_str = __data_dic[@"status"]==0?@"order_success":@"order_faild";
    status_imgView.image = [UIImage imageNamed:@"order_success"];
    [self.view addSubview:status_imgView];
    UILabel *text_label = [[UILabel alloc] initWithFrame:CGRectMake(10, screenHeight * 0.3, screenWide-20, screenHeight * 0.2)];
    text_label.numberOfLines = 0;
     text_label.text = @"您在悠悠了平台的订单号（12162542365）尚未支付，为确保您的顺利出行，请在48小时内完成支付。开户行：杭州钱江支行，帐号：1213232232132221。　如有疑问请致电329729827928，祝您生活愉快！";
    [self.view addSubview:text_label];
    for (int i = 0; i < 2; i++) {
        UIButton * two_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [two_btn setTitleColor:GRAYCOLOR forState:UIControlStateNormal];
        two_btn.layer.masksToBounds = YES;
        two_btn.layer.cornerRadius = 10;
        two_btn.layer.borderWidth  = 1;
        two_btn.layer.borderColor = [GRAYCOLOR CGColor];
        two_btn.frame = CGRectMake(50 + (screenWide-130)/2 *i, screenHeight * 0.7, (screenWide-130)/2, screenHeight * 0.05);
        if (i== 0) {
            _order_btn = two_btn;
        }else{
            _show_btn = two_btn;
        }
    }
    
    [_order_btn setTitle:@"查看订单" forState:UIControlStateNormal];
    [self.view addSubview:_order_btn];
    [_show_btn setTitle:@"去首页" forState:UIControlStateNormal];
    [self.view addSubview:_show_btn];
    
    UIButton * back_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [back_btn addTarget:self action:@selector(backBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    back_btn.frame = CGRectMake(0, 0, 10, 18);
    [back_btn setBackgroundImage:[UIImage imageNamed:@"leftop_w"] forState:UIControlStateNormal];
    UIBarButtonItem * back_item = [[UIBarButtonItem alloc] initWithCustomView:back_btn];
    self.navigationItem.leftBarButtonItem = back_item;

    
    
}
-(void)backBtnPressed{
    OrderStatusTVController * order_status_VC = [[OrderStatusTVController alloc] init];
    [self.navigationController pushViewController:order_status_VC animated:YES];
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
