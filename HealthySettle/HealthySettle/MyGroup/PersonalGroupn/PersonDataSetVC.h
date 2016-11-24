//
//  PersonDataSetVC.h
//  HealthySettle
//
//  Created by yrc on 16/11/11.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PersonDataSetVC : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *man_btn;
@property (weak, nonatomic) IBOutlet UIButton *woman_btn;
@property (weak, nonatomic) IBOutlet UIButton *birthday_btn;
@property (weak, nonatomic) IBOutlet UIButton *submit_btn;
@property (strong,nonatomic)UITextField * name_textfield;
@property (strong,nonatomic)UIView * color_view;
@property (weak, nonatomic) IBOutlet UIView *group_view;

@end
