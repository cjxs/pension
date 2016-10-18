//
//  PensionSRTVCell.h
//  HealthySettle
//
//  Created by yrc on 16/3/31.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PensionSRTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *organization_image;
@property (weak, nonatomic) IBOutlet UILabel *organization_title;
@property (weak, nonatomic) IBOutlet UILabel *organization_address;
@property (weak, nonatomic) IBOutlet UILabel *available_bunk;
@property (weak, nonatomic) IBOutlet UILabel *price_label;
- (void)configWithimage:(NSString *)image_u title:(NSString *)title address:(NSString *)address number:(NSString *)number price:(NSString *)price;
@end
