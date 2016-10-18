//
//  RegimenRTVCell.h
//  HealthySettle
//
//  Created by yrc on 16/3/31.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegimenRTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *organization_image;
@property (weak, nonatomic) IBOutlet UILabel *organization_title;
@property (weak, nonatomic) IBOutlet UILabel *price_label;
@property (weak, nonatomic) IBOutlet UILabel *address_label;
- (void)configWithImage:(NSString *)image_u title:(NSString *)title address:(NSString *)address price:(NSString *)price supportArray:(NSArray *)array;

@end
