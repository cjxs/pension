//
//  OrderMasView.m
//  HealthySettle
//
//  Created by yrc on 16/12/9.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "OrderMasView.h"

@implementation OrderMasView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromHex(@"#f8f9fa");
        _group_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, screenWide /4, screenWide /4)];
        _group_imageView.image = [UIImage imageNamed:@"home_pic"];
        [self addSubview:_group_imageView];
        UILabel * title1_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide/4 + 20, 10, screenWide/5*0.3, 30)];
        title1_label.text = @"入住";
        title1_label.font = [UIFont systemFontOfSize:12];
        title1_label.textColor = UIColorFromHex(@"#909192");
        [self addSubview:title1_label];
        
        _checkin_label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(title1_label.frame)+5, 10, screenWide/5*0.7, 30)];
        _checkin_label.text = @"2月14日";
        _checkin_label.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_checkin_label];
        UILabel * title2_label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_checkin_label.frame), 10, screenWide/5 * 0.3, 30)];
        title2_label.text = @"离店";
        title2_label.font = [UIFont systemFontOfSize:12];
        title2_label.textColor = UIColorFromHex(@"#909192");
        [self addSubview:title2_label];
        
        _checkout_label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(title2_label.frame)+5, 10, screenWide/5 * 0.7, 30)];
        _checkout_label.text = @"3月15日";
        _checkout_label.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_checkout_label];
        _liveTime_label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_checkout_label.frame)+10, 10, screenWide/5, 30)];
        _liveTime_label.text = @"1个月";
        _liveTime_label.textColor = UIColorFromHex(@"#909192");
        [self addSubview:_liveTime_label];
        
        _orderSpec_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide/4 +20, CGRectGetMaxY(_checkout_label.frame) + 10, screenWide/2, 30)];
        _orderSpec_label.text = @"自理｜自立三级｜不包餐|回家都是手";
        _orderSpec_label.textColor = UIColorFromHex(@"#909192");
        [self addSubview:_orderSpec_label];
        
        _orderPrice_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide/5 *4, CGRectGetMaxY(_group_imageView.frame)-40, screenWide/5 - 10, 40)];
        _orderPrice_label.text = @"¥ 898.00";
        _orderPrice_label.textColor = UIColorFromHex(@"#e50c18");
        [self addSubview:_orderPrice_label];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
