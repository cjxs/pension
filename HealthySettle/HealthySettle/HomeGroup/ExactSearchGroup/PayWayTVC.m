//
//  PayWayTVC.m
//  HealthySettle
//
//  Created by yrc on 16/12/2.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "PayWayTVC.h"

@implementation PayWayTVC
-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle: style
                reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        _pay_way_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 10, 30, 30)];
        _pay_way_imageView.layer.cornerRadius = 15;
        _pay_way_imageView.layer.masksToBounds = YES;
        [self addSubview:_pay_way_imageView];
        
        _pay_way_label = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 100, 30)];
        _pay_way_label.font = [UIFont systemFontOfSize:13];
        [self addSubview:_pay_way_label];
        
        _select_status_btn = [[UIImageView alloc] init];
        _select_status_btn.frame = CGRectMake(screenWide - 40, 10, 30, 30);
        [self addSubview:_select_status_btn];
        
    }
    return self;
}
-(void)configWithimageName:(NSString *)image_name title:(NSString *)title aliPay:(BOOL)ali_pay{
    _pay_way_imageView.image = [UIImage imageNamed:image_name];
    _pay_way_label.text = title;
    
    if ([image_name isEqualToString:@"ali_btn"]) {
        if (ali_pay) {
            _select_status_btn.image = [UIImage imageNamed:@"selected"];
        }else{
            _select_status_btn.image = [UIImage imageNamed:@"un_select"];
        }
    }else{
         if (ali_pay) {
             _select_status_btn.image = [UIImage imageNamed:@"un_select"];
         }else{
             _select_status_btn.image = [UIImage imageNamed:@"selected"];

         }
        
    }
}

@end
