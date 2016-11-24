//
//  PersonNTVCell.h
//  HealthySettle
//
//  Created by yrc on 16/10/21.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonNTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *personImageView;
@property (weak, nonatomic) IBOutlet UILabel *nick_name_l;
@property (weak, nonatomic) IBOutlet UILabel *sex_bir_l;
@property (weak, nonatomic) IBOutlet UILabel *set_l;
-(void)configs;
@end
