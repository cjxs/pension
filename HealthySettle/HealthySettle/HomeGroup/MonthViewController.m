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
    UIButton * return_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    return_btn.frame = CGRectMake(screenWide * 0.04, screenHeight * 0.03, screenWide * 0.05, screenHeight * 0.05);
    [self.view addSubview:return_btn];
    [return_btn addTarget:self action:@selector(backToViewController) forControlEvents:UIControlEventTouchUpInside];
    
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
