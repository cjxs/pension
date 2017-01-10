//
//  TravelTVCell.h
//  HealthySettle
//
//  Created by yrc on 17/1/4.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelTVCell : UITableViewCell
@property (strong, nonatomic)  UIImageView *organization_image;
@property (strong, nonatomic)  UILabel *organization_title;
@property (assign, nonatomic)  BOOL discount;
@property (strong, nonatomic)  UILabel *price_label;
-(void)configWithData:(NSDictionary *)data;
@end
