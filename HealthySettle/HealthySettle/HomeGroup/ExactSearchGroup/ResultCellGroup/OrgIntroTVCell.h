//
//  OrgIntroTVCell.h
//  HealthySettle
//
//  Created by yrc on 16/4/3.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrgIntroTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *telephone;
@property (weak, nonatomic) IBOutlet UILabel *bed_nums;
@property (weak, nonatomic) IBOutlet UILabel *spec;
@property (weak, nonatomic) IBOutlet UILabel *special_service;
@property (weak, nonatomic) IBOutlet UILabel *intro;
- (void)configWithtelephone:(NSString *)phone bed_nums:(NSString *)bed_nums spec:(NSString *)spec special_s:(NSString *)special_s intro:(NSString *)intro;
@end
