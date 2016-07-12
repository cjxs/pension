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
@property (weak, nonatomic) IBOutlet UILabel     *province2_label;
@property (weak, nonatomic) IBOutlet UILabel     *cityleft_label;
@property (weak, nonatomic) IBOutlet UILabel     *citymid_label;
@property (weak, nonatomic) IBOutlet UILabel     *cityright_label;
@property (weak, nonatomic) IBOutlet UILabel     *month_label;

@end
