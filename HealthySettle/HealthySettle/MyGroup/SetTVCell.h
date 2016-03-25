//
//  SetTVCell.h
//  HealthySettle
//
//  Created by yrc on 16/3/25.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mark_label;
@property (weak, nonatomic) IBOutlet UILabel *explain_label;
@property (weak, nonatomic) IBOutlet UIImageView *btn_View;
@property (weak, nonatomic) IBOutlet UIImageView *mark_View;
- (void)setThingsWithName:(NSString *)stringQ Image:(UIImage *)imageB number:(NSString *)stringH;
@end
