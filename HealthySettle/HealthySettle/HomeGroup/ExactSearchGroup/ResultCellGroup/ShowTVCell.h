//
//  ShowTVCell.h
//  HealthySettle
//
//  Created by yrc on 16/4/3.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel     *title_label;
@property (weak, nonatomic) IBOutlet UIImageView *left_imageView;
@property (weak, nonatomic) IBOutlet UIImageView *mid_imageView;
@property (weak, nonatomic) IBOutlet UIImageView *right_imageView;
-(void)configWithTitle:(NSString *)title imageArray:(NSArray *)array text:(NSString *)text;

@end
