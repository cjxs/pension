//
//  ArticleListTViewCell.h
//  HealthySettle
//
//  Created by yrc on 16/10/26.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleListTViewCell : UITableViewCell
@property (strong, nonatomic)  UILabel *title_label;
@property (strong, nonatomic)  UILabel *time_label;
@property (strong, nonatomic)  UILabel *reads_label;
@property (strong,nonatomic)UIView * view;
-(void)configWithDic:(NSDictionary *)dic;

@end
