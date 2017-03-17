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

@interface LeaderViewController ()<UIActionSheetDelegate>{
    UIView * shade_view;
    UIView * white_view;
    UIImageView *_sentImg;
    UIImageView * code_imageview;
}

@end

@implementation LeaderViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIView * back_view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide , screenHeight * 0.35)];
    UILabel * title_lebel = [[UILabel alloc] initWithFrame:CGRectMake(100, 15, screenWide-200, 44)];
    title_lebel.text = @"管家";
    title_lebel.textAlignment = NSTextAlignmentCenter;
    title_lebel.textColor = [UIColor whiteColor];
    title_lebel.font = [UIFont systemFontOfSize:18];
    [back_view addSubview:title_lebel];
    UIButton * back_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    back_btn.frame = CGRectMake(screenWide * 0.01, screenHeight * 0.005 , screenWide * 0.2, screenHeight * 0.1 );
    [back_btn addTarget:self action:@selector(cancleToSubview) forControlEvents:UIControlEventTouchUpInside];
    [back_view addSubview:back_btn];
    
    CGRect back_frame = CGRectMake(5, 20 , screenWide * 0.04, screenWide * 0.04/10 *18 );
    UIImageView * back_imageView = [[UIImageView alloc] initWithFrame:back_frame];

    back_imageView.image = [UIImage imageNamed:@"leftop_w"];
    [back_btn addSubview:back_imageView];
 
    UIImage *bg_img = [UIImage gradientColorImageFromColors:@[[UIColor colorWithHexString:@"#fa6546"],[UIColor colorWithHexString:@"#f13a2a"]] gradientType:GradientTypeTopToBottom imgSize:CGSizeMake(screenWide, screenHeight * 0.35)];
    back_view.backgroundColor = [UIColor colorWithPatternImage:bg_img];
    [self.view addSubview:back_view];
    
    UIImageView * head_img_view = [[UIImageView alloc] init];
    NSString *  str2 = [NSString stringWithFormat:@"%@/upload/group/%@",BASEURL,_data_dic[@"pic"]];
    NSString * str3 = [str2 stringByReplacingOccurrencesOfString:@"," withString:@"/"];
    [head_img_view sd_setImageWithURL:[NSURL URLWithString:str3] placeholderImage:[UIImage imageNamed:@"boy_head.png"]];
    head_img_view.clipsToBounds = YES;
    head_img_view.layer.cornerRadius = screenWide/8;
    [back_view addSubview:head_img_view];
    [head_img_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(screenWide/4, screenWide/4));
        make.top.equalTo(back_view).offset((screenHeight * 0.1));
        make.centerX.equalTo(back_view);
    }];
    
    UIButton * phone_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    phone_btn.layer.cornerRadius = screenWide/12;
    phone_btn.layer.masksToBounds = YES;
    [back_view addSubview:phone_btn];
    [phone_btn setBackgroundImage:[UIImage imageNamed:@"tel.png"] forState:UIControlStateNormal];
    [phone_btn addTarget:self action:@selector(telPhone) forControlEvents:UIControlEventTouchUpInside];
    
    [phone_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(screenWide/6, screenWide/6));
        make.centerY.equalTo(head_img_view);
        make.centerX.equalTo(head_img_view).offset(-screenWide/24*7);
    }];
    
    UIButton * twocode_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    twocode_btn.layer.cornerRadius = screenWide/12;
    twocode_btn.layer.masksToBounds = YES;
    [back_view addSubview:twocode_btn];
    
    
    [twocode_btn setBackgroundImage:[UIImage imageNamed:@"twocode.png"] forState:UIControlStateNormal];
    [twocode_btn addTarget:self action:@selector(showTwoCode) forControlEvents:UIControlEventTouchUpInside];
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
    name_label.text = _data_dic[@"name"];
    TitleNumberView * lead_times_view = [[TitleNumberView alloc] initWithFrame:CGRectMake(0, screenHeight* 0.35, screenWide/2, screenHeight * 0.08)];
    [self.view addSubview:lead_times_view];
    lead_times_view.backgroundColor = [UIColor colorWithHexString:@"#f75741"];
    lead_times_view.title_label.text = @"带队次数";
    lead_times_view.number_label.text = _data_dic[@"num_leader"];
    
    TitleNumberView * lead_numbers_view = [[TitleNumberView alloc] initWithFrame:CGRectMake(screenWide/2, screenHeight* 0.35, screenWide/2, screenHeight * 0.08)];
    [self.view addSubview:lead_numbers_view];
    lead_numbers_view.backgroundColor = [UIColor colorWithHexString:@"#ef3731"];
    lead_numbers_view.title_label.text = @"带队人数";
    lead_numbers_view.number_label.text = _data_dic[@"peo_leader"];
    
    UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(10, screenHeight * 0.45, screenWide-20, screenHeight * 0.3)];
    title_label.text = [NSString stringWithFormat:@"    %@",_data_dic[@"content"]];
    [self.view addSubview:title_label];
    title_label.font = [UIFont systemFontOfSize:12];
    
    


}
-(void)telPhone{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",_data_dic[@"phone"]];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}
-(void)showTwoCode{
    shade_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight)];
    shade_view.backgroundColor = [UIColor blackColor];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancleshowcode)];
    tap.numberOfTouchesRequired = 1;
    [shade_view addGestureRecognizer:tap];
    shade_view.alpha = 0.4;
    [self.view addSubview:shade_view];
    white_view = [[UIView alloc] initWithFrame:CGRectMake(20, screenHeight * 0.35, screenWide-40, screenWide-40)];
    white_view.backgroundColor = [UIColor whiteColor];
    white_view.clipsToBounds = YES;
    white_view.layer.cornerRadius = 5;
    [self.view addSubview:white_view];
    code_imageview = [[UIImageView alloc] init];
    [white_view addSubview:code_imageview];
    NSString *  str2 = [NSString stringWithFormat:@"%@/upload/group/%@",BASEURL,_data_dic[@"two_code"]];
    NSString * str3 = [str2 stringByReplacingOccurrencesOfString:@"," withString:@"/"];
    [code_imageview sd_setImageWithURL:[NSURL URLWithString:str3] placeholderImage:[UIImage imageNamed:@"boy_head.png"]];
    code_imageview.userInteractionEnabled = YES;
    [code_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(screenWide-140, screenWide-140));
        make.centerX.equalTo(white_view);
        make.centerY.equalTo(white_view).offset(-15);
    }];
    UILongPressGestureRecognizer * longges = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(imglongTapClick:)];
    //UITapGestureRecognizer * longges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dayin)];
    longges.numberOfTouchesRequired = 1;
    [white_view addGestureRecognizer:longges];
    
    UILabel * text_label = [[UILabel alloc] init];
    [white_view addSubview:text_label];
    [text_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(screenWide-150,40));
        make.top.mas_equalTo(code_imageview.mas_bottom).offset(10);
        make.centerX.equalTo(code_imageview);
    }];
    text_label.textAlignment = NSTextAlignmentCenter;
    text_label.text = @"长按保存至系统相册，打开微信扫一扫，添加好友";
    text_label.font = [UIFont systemFontOfSize:10];
    
}

-(void)imglongTapClick:(UILongPressGestureRecognizer *)gesture

{
    if(gesture.state == UIGestureRecognizerStateBegan)
        
    {
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      
                                      initWithTitle:@"保存图片"
                                      
                                      delegate:self
                                      
                                      cancelButtonTitle:@"取消"
                                      
                                      destructiveButtonTitle:nil
                                      
                                      otherButtonTitles:@"保存图片到手机",nil];
        
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        
        [actionSheet showInView:self.view];
        
        
        
        
        _sentImg = code_imageview;
        
    }
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex

{
    
    if (buttonIndex == 0) {
        
        UIImageWriteToSavedPhotosAlbum(code_imageview.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
        
    }
    
}
#pragma mark --- UIActionSheetDelegate---

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo

{
    
    NSString *message;
    
    if (!error) {
        
        message = @"成功保存到相册";
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
        
        
        
    }else
        
    {
        
        message = [error description];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
        
    }
    
    
}
-(void)cancleToSubview{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)cancleshowcode{
    for (UIView * view in white_view.subviews) {
        [view removeFromSuperview];
    }
    [white_view removeFromSuperview];
    [shade_view removeFromSuperview];
    
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
