//
//  OrderStatusTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/12/8.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "OrderStatusTVCell.h"


@implementation OrderStatusTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        UILabel * prompt_label = [[UILabel alloc] initWithFrame:CGRectMake(15, 3, screenWide - 30, 37)];
        prompt_label.backgroundColor = UIColorFromHex(@"#fdfbc0");
        prompt_label.text = @"  请及时付款，不然就被抢光啦!";
        _prompt_label = prompt_label;
        [self addSubview:_prompt_label];
        
        UILabel * order_status_label = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 100, 40)];
        order_status_label.textColor = UIColorFromHex(@"#79d86e");
        order_status_label.text = @"待付款";
        _order_status_label = order_status_label;
        [self addSubview:_order_status_label];
        
        UILabel * order_sn_label = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, screenWide/2, 25)];
        order_sn_label.text = @"订单号：YS1348957559";
        order_sn_label.textColor = UIColorFromHex(@"#909192");
        _order_sn_label = order_sn_label;
        [self addSubview:_order_sn_label];
        UILabel * order_addtime_label = [[UILabel alloc] initWithFrame:CGRectMake(10, 105, screenWide/3 * 2, 25)];
        order_addtime_label.text = @"下单时间： 2016-6-5  14:25:30";
        order_addtime_label.textColor = UIColorFromHex(@"#909192");
        _order_addtime_label = order_addtime_label;
        [self addSubview:_order_addtime_label];
        
        UILabel * order_balance_money_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide - 100, 85, 90, 30)];
        order_balance_money_label.text = @"¥ 3450";
        order_balance_money_label.textColor = UIColorFromHex(@"#eb3338");
        _order_balance_money_label = order_balance_money_label;
        [self addSubview:_order_balance_money_label];
        
        UIView * back_view = [[UIView alloc] initWithFrame:CGRectMake(0,130, screenWide, 10)];
        back_view.backgroundColor = UIColorFromHex(@"#e0e1e2");
        [self addSubview:back_view];


    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
