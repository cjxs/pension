//
//  OrdAndRefundTVCell.h
//  HealthySettle
//
//  Created by yrc on 16/4/7.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrdAndRefundTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel     *title_label;
@property (weak, nonatomic) IBOutlet UIImageView *organImage_view;
@property (weak, nonatomic) IBOutlet UILabel     *serve_label;
@property (weak, nonatomic) IBOutlet UILabel     *organAddress_label;
@property (weak, nonatomic) IBOutlet UILabel     *type_label;
@property (weak, nonatomic) IBOutlet UILabel     *price_label;
@property (weak, nonatomic) IBOutlet UIButton    *first_btn;
@property (weak, nonatomic) IBOutlet UIButton    *second_btn;
-(void)configOrderWithtitle:(NSString *)title image:(UIImage *)image type:(NSInteger)type price:(NSString *)price;
-(void)configRefundWithtitle:(NSString *)title image:(UIImage *)image type:(NSInteger)type price:(NSString *)price ;
@end
