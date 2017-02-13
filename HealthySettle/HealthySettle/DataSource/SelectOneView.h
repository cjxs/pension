//
//  SelectOneView.h
//  HealthySettle
//
//  Created by yrc on 17/2/10.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectOneView : UIView
@property (nonatomic,strong)UILabel * lab;
@property (nonatomic,strong)UIImageView * img_view;
@property (nonatomic, copy) void(^selectBlock)(CGFloat x);
@end
