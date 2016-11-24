//
//  PersonTVCell.h
//  HealthySettle
//
//  Created by yrc on 16/3/29.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel     *className;
@property (weak, nonatomic) IBOutlet UILabel     *resultLabel;
@property (weak, nonatomic) IBOutlet UIImageView *NextImage;
- (void)configClassName:(NSString *)class_name ;
@end
