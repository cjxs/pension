//
//  TitleTVCell.h
//  HealthySettle
//
//  Created by yrc on 17/1/5.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleTVCell : UITableViewCell{
    UILabel * dis_label;
}
@property (strong, nonatomic)  UILabel *organization_title;
@property (strong, nonatomic)  UILabel *price_label;
@property (strong, nonatomic)  UILabel *introduce_label;
-(void)configTitle:(NSString *)title recommend:(NSString *)recommend return:(NSString *)vochers price:(NSString *)price;
@end
