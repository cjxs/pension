//
//  OrderMasView.h
//  HealthySettle
//
//  Created by yrc on 16/12/9.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderMasView : UIView
@property (nonatomic,strong)UIImageView * group_imageView;
@property (nonatomic,strong)UILabel * checkin_label;
@property (nonatomic,strong)UILabel * checkout_label;
@property (nonatomic,strong)UILabel * liveTime_label;
@property (nonatomic,strong)UILabel * orderSpec_label;
@property (nonatomic,strong)UILabel * orderPrice_label;

@end
