//
//  CommentViewController.m
//  HealthySettle
//
//  Created by yrc on 16/4/9.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController ()
{
    UIView * select_view;
    UITextView * textView;
    UIButton *addImage_btn;
}

@end

@implementation CommentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我要点评";
    
    for (int i = 0; i< 3; i++)
    {
        UILabel * line = [[UILabel alloc] init];
        switch (i)
        {
            case 0:
                line.frame = CGRectMake(0, screenHeight * 0.077, screenWide, 1);
                break;
            case 1:
                line.frame = CGRectMake(0, screenHeight * 0.47, screenWide, 1);
                break;
     
            default:
                line.frame = CGRectMake(0, screenHeight * 0.63, screenWide, 1);
                break;
        }
        line.backgroundColor = RGB(249, 249, 249);
        [self.view addSubview:line];
    }
    select_view = [[UIView alloc]
                   initWithFrame:CGRectMake(0, 0, screenWide, screenHeight * 0.077)];
    UILabel * title1_label = [[UILabel alloc]
                              initWithFrame:CGRectMake(screenWide * 0.03, screenHeight * 0.025, screenWide * 0.2, screenHeight * 0.03)];
    title1_label.text = @"总体评价";
    title1_label.font = [UIFont systemFontOfSize:13];
    [select_view addSubview:title1_label];
    NSArray * select_array = @[@"好评",@"中评",@"差评"];
    [self fundButtonWithArray:select_array
                    andHeight:screenHeight * 0.02
                         Wide:screenWide * 0.136];
    [self.view addSubview:select_view];
    UILabel * title2_label = [[UILabel alloc]
                              initWithFrame:CGRectMake(screenWide * 0.03, screenHeight * 0.1, screenWide * 0.2, screenHeight * 0.03)];
    title2_label.text = @"内容";
    title2_label.font = [UIFont systemFontOfSize:13];
    title2_label.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:title2_label];
    textView = [[UITextView alloc]
                initWithFrame:CGRectMake(screenWide * 0.25, screenHeight * 0.1, screenWide * 0.7, screenHeight * 0.35)];
    textView.text = @"你可以聊一聊机构服务,位置，设施等";
    textView.layer.borderColor = [RGB(244, 244, 244) CGColor];
    textView.layer.borderWidth = 1;
    [self.view addSubview:textView];
    UILabel * title3_label = [[UILabel alloc]
                              initWithFrame:CGRectMake(screenWide * 0.03, screenHeight * 0.495, screenWide * 0.2, screenHeight * 0.03)];
    title3_label.text = @"上传图片";
    title3_label.font = [UIFont systemFontOfSize:13];
    title3_label.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:title3_label];
    addImage_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    addImage_btn.frame = CGRectMake(screenWide * 0.25, screenHeight * 0.495, screenHeight * 0.08, screenHeight * 0.08);
    [addImage_btn setBackgroundImage:[UIImage imageNamed:@"add_btn"]
                            forState:UIControlStateNormal];
    [self.view addSubview:addImage_btn];
    UILabel * addImage_label = [[UILabel alloc]
                                initWithFrame:CGRectMake(screenWide * 0.25, screenHeight * 0.58, screenWide * 0.7, screenHeight * 0.02)];
    addImage_label.text = @"点击添加图片，最多可上传7张图片， 每张大小不超过2M，支持jpg，gif，png";
    addImage_label.adjustsFontSizeToFitWidth = YES;
    addImage_label.textColor = RGB(195, 195, 195);
    [self.view addSubview:addImage_label];
    
    UIButton * commit_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    commit_btn.frame = CGRectMake(screenWide * 0.15, screenHeight * 0.66, screenWide * 0.7, screenHeight * 0.05);
    commit_btn.backgroundColor = RGB(230, 11, 24);
    commit_btn.clipsToBounds = YES;
    commit_btn.layer.cornerRadius = 5;
    [commit_btn setTitle:@"发表点评"
                forState:UIControlStateNormal];
    [commit_btn addTarget:self
                   action:@selector(pressBtnToSubmit)
         forControlEvents:UIControlEventTouchUpInside];
    [commit_btn setTitleColor:[UIColor whiteColor]
                     forState:UIControlStateNormal];
    commit_btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:commit_btn];

    

}
-(void)fundButtonWithArray:(NSArray *)array
                 andHeight:(CGFloat)height Wide:(CGFloat)wide
{
    for (int i = 0; i < array.count; i++)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(screenWide * 0.25 + wide * (i * 2), height, wide, screenHeight *0.048);
        [btn setTitle:array[i]
             forState:UIControlStateNormal];
        if (i == 0)
        {
            btn.backgroundColor = RGB(229, 12, 24);
            [btn setTitleColor:[UIColor whiteColor]
                      forState:UIControlStateNormal];
        }else {
            btn.backgroundColor = RGB(244,245, 246);
            [btn setTitleColor:RGB(127, 128, 129)
                      forState:UIControlStateNormal];
        }
        btn.tag = 600 + i;
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.clipsToBounds = YES;
        btn.layer.cornerRadius = 5;
        [btn addTarget:self
                action:@selector(selectValueBtn:)
      forControlEvents:UIControlEventTouchUpInside];
        [select_view addSubview:btn];
    }
}
- (void)selectValueBtn:(UIButton *)button
{
    for (UIView * view in select_view.subviews)
    {
        if ([view isKindOfClass:[UIButton class]])
        {
            UIButton * btn = (UIButton *)view;
             btn.backgroundColor = RGB(244,245, 246);
            [btn setTitleColor:RGB(127, 128, 129)
                      forState:UIControlStateNormal];
        }
    }
    button.backgroundColor = RGB(229, 12, 24);
    [button setTitleColor:[UIColor whiteColor]
                 forState:UIControlStateNormal];
    NSLog(@"%ld",button.tag - 600);
}
- (void)pressBtnToSubmit
{
    NSLog(@"提交点评");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
