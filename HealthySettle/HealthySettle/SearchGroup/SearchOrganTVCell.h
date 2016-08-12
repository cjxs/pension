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
-(void)configWithImage:(UIImage *)image;
- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view;

@end
