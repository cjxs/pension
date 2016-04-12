//
//  MonthViewController.m
//  HealthySettle
//
//  Created by yrc on 16/4/8.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "MonthViewController.h"

@interface MonthViewController ()

@end

@implementation MonthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   self.province2_label.text = self.province1_label.text = @"江苏";
    self.month_imageview.image = [UIImage imageNamed:@"month_imagedemo"];
    self.cityleft_imageview.image = [UIImage imageNamed:@"image_left"];
    self.citymid_imageview.image = [UIImage imageNamed:@"image_mid"];
    self.cityright_imageview.image = [UIImage imageNamed:@"image_right"];
    NSArray * array = @[@" 无锡",@"南京",@"苏州",@"扬州",@"周庄",@"镇江",@"常州"];
        for (int i = 0; i < array.count; i++) {
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15 +(screenWide/(array.count + 6)+kMargin)*i ,self.province1_label.frame.origin.y - 40, screenWide/(array.count + 6), 25)];
            label.text = array[i];
            label.font = [UIFont systemFontOfSize:10];
            [self.view addSubview:label];
        }
    for (int i = 0; i < array.count; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15 +(screenWide/(array.count + 6)+kMargin)*i ,self.province2_label.frame.origin.y - 40, screenWide/(array.count + 6), 25)];
        label.text = array[i];
        label.font = [UIFont systemFontOfSize:10];
        [self.view addSubview:label];
    }
//    self.cityright_label.text = self.citymid_label.text = self.cityleft_label.text = @"哈哈";
//    self.month_label.text = @"二月在那里";
    [self.view bringSubviewToFront:self.month_label];


}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    UIImageView * back_imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leftop_w"]];
    back_imageView.frame = CGRectMake(screenWide * 0.04, screenHeight * 0.05, screenWide * 0.03,screenWide * 0.03/10 * 18 );
    [self.view addSubview:back_imageView];
    
    UIButton * back_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    back_btn.frame = CGRectMake(screenWide * 0.02, screenHeight * 0.03, screenWide * 0.12,screenHeight * 0.08);
    [back_btn addTarget:self action:@selector(backToViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.month_imageview addSubview:back_btn];
    self.month_imageview.userInteractionEnabled = YES;
    
}
- (void)backToViewController {
    [self.navigationController popViewControllerAnimated:NO];
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
