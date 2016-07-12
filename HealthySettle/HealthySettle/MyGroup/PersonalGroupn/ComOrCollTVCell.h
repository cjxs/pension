//
//  ComOrCollTVCell.h
//  HealthySettle
//
//  Created by yrc on 16/4/7.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComOrCollTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel     *title_label;
@property (weak, nonatomic) IBOutlet UIImageView *organimage_view;
@property (weak, nonatomic) IBOutlet UILabel     *serve_label;
@property (weak, nonatomic) IBOutlet UILabel     *organAddress_label;
@property (weak, nonatomic) IBOutlet UILabel     *price_label;
@property (weak, nonatomic) IBOutlet UIButton    *last_btn;
-(void)configRefundWithtitle:(NSString *)title image:(UIImage *)image type:(NSString *)type price:(NSString *)price;

@end
