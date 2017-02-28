//
//  OrdAndRefundTVCell.h
//  HealthySettle
//
//  Created by yrc on 16/4/7.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Order_ed;

@interface OrdAndRefundTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel     *title_label;
@property (weak, nonatomic) IBOutlet UIImageView *organImage_view;
@property (weak, nonatomic) IBOutlet UILabel     *serve_label;
@property (weak, nonatomic) IBOutlet UILabel     *organAddress_label;
@property (weak, nonatomic) IBOutlet UILabel     *type_label;
@property (weak, nonatomic) IBOutlet UILabel     *price_label;
@property (weak, nonatomic) IBOutlet UIButton    *first_btn;
@property (weak, nonatomic) IBOutlet UILabel *number_label;
@property (weak, nonatomic) IBOutlet UILabel *add_time_label;
-(void)configOrderWithOrder:(Order_ed *)order type:(NSString *)type;
-(void)configRefundWithtitle:(NSString *)title image:(UIImage *)image type:(NSInteger)type price:(NSString *)price ;
@end
