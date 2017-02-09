//
//  LeaderViewController.m
//  HealthySettle
//
//  Created by yrc on 17/2/9.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "LeaderViewController.h"
#import "UIImage+DDImage.h"
#import "TitleNumberView.h"

@interface LeaderViewController ()

@end

@implementation LeaderViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.barTintColor = RGB(254, 102, 64);//背景色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};//字体颜色
    self.navigationController.navigationBar.translucent = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIView * back_view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide , screenHeight * 0.25)];
    UIImage *bg_img = [UIImage gradientColorImageFromColors:@[[UIColor colorWithHexString:@"#fa6546"],[UIColor colorWithHexString:@"#f13a2a"]] gradientType:GradientTypeTopToBottom imgSize:CGSizeMake(screenWide, screenHeight * 0.25)];
    back_view.backgroundColor = [UIColor colorWithPatternImage:bg_img];
    [self.view addSubview:back_view];
    
    UIImageView * head_img_view = [[UIImageView alloc] init];
    head_img_view.image = [UIImage imageNamed:@"boy_head.png"];
    head_img_view.clipsToBounds = YES;
    head_img_view.layer.cornerRadius = screenWide/8;
    [back_view addSubview:head_img_view];
    [head_img_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(screenWide/4, screenWide/4));
        make.top.equalTo(back_view).offset((20));
        make.centerX.equalTo(back_view);
    }];
    
    UIButton * phone_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    phone_btn.layer.cornerRadius = screenWide/12;
    phone_btn.layer.masksToBounds = YES;
    [back_view addSubview:phone_btn];
    [phone_btn setBackgroundImage:[UIImage imageNamed:@"boy_head.png"] forState:UIControlStateNormal];
    [phone_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(screenWide/6, screenWide/6));
        make.centerY.equalTo(head_img_view);
        make.centerX.equalTo(head_img_view).offset(-screenWide/24*7);
    }];
    
    UIButton * twocode_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    twocode_btn.layer.cornerRadius = screenWide/12;
    twocode_btn.layer.masksToBounds = YES;
    [back_view addSubview:twocode_btn];
    [twocode_btn setBackgroundImage:[UIImage imageNamed:@"boy_head.png"] forState:UIControlStateNormal];
    [twocode_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(screenWide/6, screenWide/6));
        make.centerY.equalTo(head_img_view);
        make.centerX.equalTo(head_img_view).offset(screenWide/24*7);
    }];
    UILabel * name_label = [[UILabel alloc] init];
    name_label.textColor = [UIColor whiteColor];
    name_label.textAlignment = NSTextAlignmentCenter;
    name_label.font = [UIFont systemFontOfSize:15];
    [back_view addSubview:name_label];
    [name_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(head_img_view.mas_bottom).offset(10);
        make.centerX.equalTo(back_view);
        make.size.mas_equalTo(CGSizeMake(200, 40));
    }];
    name_label.text = @"娟娟细流";
    TitleNumberView * lead_times_view = [[TitleNumberView alloc] initWithFrame:CGRectMake(0, screenHeight* 0.25, screenWide/2, screenHeight * 0.08)];
    [self.view addSubview:lead_times_view];
    lead_times_view.backgroundColor = [UIColor colorWithHexString:@"#f75741"];
    lead_times_view.title_label.text = @"带队次数";
    lead_times_view.number_label.text = @"56,231";
    
    TitleNumberView * lead_numbers_view = [[TitleNumberView alloc] initWithFrame:CGRectMake(screenWide/2, screenHeight* 0.25, screenWide/2, screenHeight * 0.08)];
    [self.view addSubview:lead_numbers_view];
    lead_numbers_view.backgroundColor = [UIColor colorWithHexString:@"#ef3731"];
    lead_numbers_view.title_label.text = @"带队人数";
    lead_numbers_view.number_label.text = @"32,341";
    

    
    
    

    
    
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
