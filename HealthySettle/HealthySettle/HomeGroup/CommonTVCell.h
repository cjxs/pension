//
//  CommonTVCell.h
//  HealthySettle
//
//  Created by yrc on 16/4/8.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonTVCell : UITableViewCell {
    NSDateFormatter *formatter;
}
@property (weak, nonatomic) IBOutlet UILabel *date_label;
@property (weak, nonatomic) IBOutlet UILabel *title_label;
- (void)configWithTitle:(NSString *)title date:(NSDate *)date;
@end
