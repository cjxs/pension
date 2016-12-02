//
//  OrderTextFieldTVCell.h
//  HealthySettle
//
//  Created by yrc on 16/4/4.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTextFieldTVCell : UITableViewCell<UITextFieldDelegate>
@property (nonatomic,strong) UILabel     * title_label;
@property (nonatomic,strong) UITextField * text_field;
@property (nonatomic,strong) UIButton    * next_btn;
-(void)configWithtitle:(NSString *)title text:(NSString *)text next:(BOOL)next controller:(UIViewController *)controller;
-(UITextField *)returnfromtextField;

@end
