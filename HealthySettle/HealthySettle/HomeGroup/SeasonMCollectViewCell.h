//
//  SeasonMCollectViewCell.h
//  HealthySettle
//
//  Created by yrc on 16/3/23.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeasonMCollectViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView  * image_view;
@property (nonatomic, strong) UILabel * season_label, *describe_label;
-(void)configViewWithimage:(NSString *)imageurl season:(NSString *)season describ:(NSString *)describ;
@end
