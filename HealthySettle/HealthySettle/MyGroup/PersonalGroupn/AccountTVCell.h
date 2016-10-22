//
//  AccountTVCell.h
//  HealthySettle
//
//  Created by yrc on 16/4/12.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *number_label;
-(void)configWithTitle:(NSString *)title type:(NSString *)type money:(NSString *)money;
-(void)configWithTitle:(NSString *)title type:(NSString *)type score:(NSString *)score;

@end
