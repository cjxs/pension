//
//  GetPassWordViewController.h
//  HealthySettle
//
//  Created by yrc on 16/7/20.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetPassWordViewController : UIViewController
@property (nonatomic,strong)UIImageView * backPicView;
@property (nonatomic,strong)UIButton * getTest_btn;
@property (nonatomic,strong)UITextField * number_field;
@property (nonatomic,strong)UITextField * test_field;
@property (nonatomic,strong)UITextField * regispwd_field1;
@property (nonatomic,strong)UITextField * regispwd_field2;
@property (nonatomic,strong)UILabel * line_lab;
@property (nonatomic,strong)UILabel * regis_lab1;
@property (nonatomic,strong)UILabel * regis_lab2;
@property (nonatomic,strong)UIButton * back_btn;
@property (nonatomic,strong)NSString * number_text;
@property (nonatomic,strong)UIButton * submit_btn;


@end
