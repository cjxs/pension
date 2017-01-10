//
//  PensionSRTVCell.h
//  HealthySettle
//
//  Created by yrc on 16/3/31.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PensionSRTVCell : UITableViewCell
@property (strong, nonatomic)  UIImageView *organization_image;
@property (strong, nonatomic)  UILabel *organization_title;
@property (strong, nonatomic)  UILabel *organization_address;
@property (strong, nonatomic)  UILabel *price_label;
- (void)configWithimage:(NSString *)image_u title:(NSString *)title address:(NSString *)address number:(NSString *)number price:(NSString *)price;
-(void)configWithData:(NSDictionary *)data;
@end
