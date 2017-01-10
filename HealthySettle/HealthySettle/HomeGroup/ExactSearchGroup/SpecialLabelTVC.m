//
//  SpecialLabelTVC.m
//  HealthySettle
//
//  Created by yrc on 16/12/2.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "SpecialLabelTVC.h"

@implementation SpecialLabelTVC
-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle: style
                reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;

}
-(void)configWithData:(NSArray *)data_arr color:(UIColor *)color font:(UIFont *)font vc_type:(NSString *)type{
    UILabel * title_label, * status_label;

    for (int i = 0; i < [data_arr count]/2;i++ ) {
        title_label = [[UILabel alloc] initWithFrame:CGRectMake(16, 5 + 40*i, 150, 40)];
        title_label.font = font;
        title_label.text = data_arr[0+i*2];
        title_label.textAlignment = NSTextAlignmentLeft;
        title_label.font = font;
        status_label = [[UILabel alloc] initWithFrame:CGRectMake(166, 5+40*i, screenWide - 192, 40)];
        status_label.textColor = color;
        status_label.font = font;
        status_label.textAlignment = NSTextAlignmentRight;
        status_label.font = font;
        YYLOrder * order = [type isEqualToString:@"2"]? [YYLOrder YSOrder]:[YYLOrder YLOrder];
        if ([data_arr[0+i*2] isEqualToString:@"现金账户"]) {
            [RACObserve(order, balance_pay) subscribeNext:^(id x) {
                NSString * text = x;
                status_label.text = [NSString stringWithFormat:@"-¥%@",text];
                CGFloat pay_money = [order.price floatValue] - [order.subsidy_money_u floatValue] - [text floatValue];
                order.balance_money = [NSString stringWithFormat:@"%.2lf",pay_money];
            }];
        }else if ([data_arr[0+i*2] isEqualToString:@"还需支付"]){
            [RACObserve(order, balance_money) subscribeNext:^(id x) {
                NSString * text = x;
                status_label.text = [NSString stringWithFormat:@"¥%@",text];

            }];
        }else{
            status_label.text = data_arr[1+i*2];

        }

        
        [self addSubview:title_label];
        [self addSubview:status_label];
    }
}

@end
