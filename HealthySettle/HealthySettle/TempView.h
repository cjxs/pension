//
//  TempView.h
//  HealthySettle
//
//  Created by yrc on 16/3/18.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TempView : UIView
@property (nonatomic, strong)UIImageView * markImageV;
@property (nonatomic, strong)UILabel * explainTitle;
-(instancetype)initWithFrame:(CGRect)frame withMark:(UIImage *)mark andTitle :(NSString *)string ;

@end
