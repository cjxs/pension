//
//  MonthViewController.h
//  HealthySettle
//
//  Created by yrc on 16/4/8.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonthViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel     *province1_label;
@property (weak, nonatomic) IBOutlet UIImageView *month_imageview;
@property (weak, nonatomic) IBOutlet UIImageView *cityleft_imageview;
@property (weak, nonatomic) IBOutlet UIImageView *citymid_imageview;
@property (weak, nonatomic) IBOutlet UIImageView *cityright_imageview;
@property (weak, nonatomic) IBOutlet UILabel     *month_label;
@property (nonatomic,strong)NSDictionary * dataDic;
@property (weak, nonatomic) IBOutlet UIButton *cityleft_btn;
@property (weak, nonatomic) IBOutlet UIButton *citymid_btn;
@property (weak, nonatomic) IBOutlet UIButton *cityright_btn;

@end
