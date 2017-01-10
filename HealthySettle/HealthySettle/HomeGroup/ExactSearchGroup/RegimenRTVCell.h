//
//  RegimenRTVCell.h
//  HealthySettle
//
//  Created by yrc on 16/3/31.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegimenRTVCell : UITableViewCell
@property (strong, nonatomic)  UIImageView *organization_image;
@property (strong, nonatomic)  UILabel *organization_title;
@property (strong, nonatomic)  UILabel *price_label;
@property (strong, nonatomic)  UILabel *address_label;
- (void)configWithImage:(NSString *)image_u title:(NSString *)title address:(NSString *)address price:(NSString *)price supportArray:(NSArray *)array;
-(void)configWithData:(NSDictionary *)data;
@end
