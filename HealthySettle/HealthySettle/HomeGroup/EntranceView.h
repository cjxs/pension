//
//  EntranceView.h
//  HealthySettle
//
//  Created by yrc on 16/12/29.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntranceView : UIView
@property (nonatomic,strong)UILabel * title_label;
@property (nonatomic,strong)UILabel * text_label;
@property (nonatomic,strong)UIImageView * image_view;
-(void)configWithtitle:(NSString *)title text:(NSString *)text imageName:(NSString *)imageName gesture:(UITapGestureRecognizer *)gesture;

@end
