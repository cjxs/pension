//
//  SearchOrganTVCell.h
//  HealthySettle
//
//  Created by yrc on 16/4/5.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchOrganTVCell : UITableViewCell
@property (strong, nonatomic)  UIImageView *organ_imageView;
@property (strong,nonatomic) UILabel * name_la;
-(void)configWithImage:(NSString *)str title:(NSString *)title;
- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view;

@end
