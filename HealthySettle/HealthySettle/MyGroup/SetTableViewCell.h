//
//  SetTableViewCell.h
//  HealthySettle
//
//  Created by yrc on 16/3/18.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TempView;
@interface SetTableViewCell : UITableViewCell
@property (nonatomic, strong)TempView * tempThingV;
@property (nonatomic,strong)UILabel * informationLabel;
- (void)setThingsWithName:(NSString *)stringQ Image:(UIImage *)image number:(NSString *)stringH;
@end
