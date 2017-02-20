//
//  ChoosePTVCell.h
//  HealthySettle
//
//  Created by yrc on 17/2/20.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoosePTVCell : UITableViewCell
@property (nonatomic,strong)UILabel * text_label;
@property (nonatomic,strong)UIImageView * img_view;
-(void)configWithname:(NSString *)name;
@end
