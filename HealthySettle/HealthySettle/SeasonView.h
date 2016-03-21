//
//  SeasonView.h
//  HealthySettle
//
//  Created by yrc on 16/3/21.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeasonView : UIView
@property (nonatomic, strong)UIImageView * image_view;
@property (nonatomic, strong)UILabel * season_label, *describe_label;
-(void)configViewWithimage:(UIImage *)image season:(NSString *)season describ:(NSString *)describ;
@end
