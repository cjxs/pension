//
//  MonthViewController.m
//  HealthySettle
//
//  Created by yrc on 16/4/8.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "MonthViewController.h"
#import "UIImageView+WebCache.h"
#import "DDSeaGet.h"

@interface MonthViewController ()

@end

@implementation MonthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.month_imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",BASEURL,_dataDic[@"banner"]]]];
    self.province1_label.text = [NSString stringWithFormat:@"        %@",_dataDic[@"desc"]];
    self.month_label.text = _dataDic[@"title"];

    
    DDSeaGet * seaGet = [[DDSeaGet alloc] initWithSea_id:_dataDic[@"season_id"]];
    [seaGet startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSArray * data = [DDLogin arrayWithJsonString:request.responseString];
        for (int i = 0; i < data.count; i++ ) {
            NSDictionary * dic = data[i];
            NSString *  str2 = [NSString stringWithFormat:@"%@/upload/group/%@",BASEURL,dic[@"file"]];
            NSString * str3 = [str2 stringByReplacingOccurrencesOfString:@"," withString:@"/"];
            [dic setValue:str3 forKey:@"file"];
            NSURL * url = [NSURL URLWithString:str3];
            switch (i) {
                case 0:
                    [self.cityleft_imageview sd_setImageWithURL:url];
                    self.cityleft_label.text = dic[@"area_name"];
                    break;
                case 1:
                    [self.citymid_imageview sd_setImageWithURL:url];
                    self.citymid_label.text = dic[@"area_name"];

                    break;
                case 2:
                    [self.cityright_imageview sd_setImageWithURL:url];
                    self.cityright_label.text = dic[@"area_name"];

                    break;
                default:
                    break;
            }
        }
     
    } failure:^(__kindof YTKBaseRequest *request) {
        
    }];
    
    
    [self.view bringSubviewToFront:self.month_label];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES
                                             animated:YES];
    UIImageView * back_imageView = [[UIImageView alloc]
                                    initWithImage:[UIImage imageNamed:@"leftop_w"]];
    back_imageView.frame = CGRectMake(screenWide * 0.04, screenHeight * 0.05, screenWide * 0.03,screenWide * 0.03/10 * 18 );
    [self.view addSubview:back_imageView];
    UIButton * back_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    back_btn.frame = CGRectMake(screenWide * 0.02, screenHeight * 0.03, screenWide * 0.12,screenHeight * 0.08);
    [back_btn addTarget:self
                 action:@selector(backToViewController)
       forControlEvents:UIControlEventTouchUpInside];
    [self.month_imageview addSubview:back_btn];
    self.month_imageview.userInteractionEnabled = YES;
}
- (void)backToViewController
{
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
