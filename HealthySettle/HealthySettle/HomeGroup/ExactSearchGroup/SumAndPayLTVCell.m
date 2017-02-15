//
//  SumAndPayLTVCell.m
//  HealthySettle
//
//  Created by yrc on 17/2/14.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "SumAndPayLTVCell.h"

@implementation SumAndPayLTVCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle: style
                reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        self.backgroundColor = GRAYCOLOR;
        UIView * view_0 = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.015, screenWide , screenHeight * 0.06)];
        view_0.backgroundColor = [UIColor whiteColor];
        [self addSubview:view_0];
        UIView * view_1 = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.09, screenWide, screenHeight * 0.11-1)];
        view_1.backgroundColor = [UIColor whiteColor];
        [self addSubview:view_1];
        UIView * view_2 = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.2, screenWide, screenHeight * 0.15)];
        view_2.backgroundColor = [UIColor whiteColor];
        [self addSubview:view_2];
        UIView * view_3 = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.365, screenWide, screenHeight * 0.06)];
        view_3.backgroundColor = [UIColor whiteColor];
        [self addSubview:view_3];
        
        UILabel * way_label = [[UILabel alloc] initWithFrame:CGRectMake(10, screenHeight * 0.015, screenWide * 0.25, screenHeight * 0.03)];
        way_label.text = @"支付方式";
        [view_0 addSubview:way_label];
        _pay_way_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.5, screenHeight * 0.01, screenWide * 0.5-10, screenHeight * 0.04)];
        _pay_way_label.text  = @"在线支付";
        _pay_way_label.textAlignment = NSTextAlignmentRight;
        [view_0 addSubview:_pay_way_label];
        NSArray *arr = @[@"商品金额",@"优悠券"];
        for (int i = 0; i < 2; i++) {
            UILabel * label_0 = [[UILabel alloc] initWithFrame:CGRectMake(10, screenHeight * 0.015 +screenHeight * 0.04*i, screenWide * 0.25, screenHeight * 0.04)];
            label_0.text = arr[i];
            [view_1 addSubview:label_0];
            UILabel * label_1 = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.75, screenHeight * 0.015 +screenHeight * 0.04*i, screenWide * 0.25-10, screenHeight * 0.04)];
            label_1.textColor = [UIColor redColor];
            label_1.textAlignment = NSTextAlignmentRight;
            if (i==0) {
                _num_sum_label = label_1;
                [view_1 addSubview:_num_sum_label];
            }else{
                _vocher_label = label_1;
                [view_1 addSubview:_vocher_label];
            }
        }
        _num_sum_label.text = @"1223";
        _vocher_label.text = @"233";
        
        UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(10, screenHeight * 0.015, screenWide * 0.25, screenHeight * 0.04)];
        title_label.text = @"实付款:";
        [view_2 addSubview:title_label];
        _reality_label = [[UILabel alloc] initWithFrame:CGRectMake(10, screenHeight * 0.055, screenWide * 0.25, screenHeight * 0.05)];
        _reality_label.textAlignment = NSTextAlignmentRight;
        _reality_label.textColor = [UIColor redColor];
        [view_2 addSubview:_reality_label];
        _realize_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.25+20, screenHeight * 0.055, screenWide * 0.75-30, screenHeight * 0.05)];
        [view_2 addSubview:_realize_label];
        _add_time_label = [[UILabel alloc] initWithFrame:CGRectMake(10, screenHeight * 0.105, screenWide -20, screenHeight * 0.03)];
        _add_time_label.textColor = GRAYCOLOR;
        _add_time_label.textAlignment = NSTextAlignmentRight;
        [view_2 addSubview:_add_time_label];
        _contact_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _contact_btn.frame = CGRectMake(0, 0, screenWide * 0.5-5, screenHeight * 0.05);
        [_contact_btn setTitle:@"联系管家" forState:UIControlStateNormal];
        [_contact_btn setTitleColor:RGB(190, 190, 190) forState:UIControlStateNormal];
        [view_3 addSubview:_contact_btn];
        UIView * line_view = [[UIView alloc] initWithFrame:CGRectMake(screenWide/2-0.5, screenHeight * 0.005, 1, screenHeight * 0.04)];
        line_view.backgroundColor = GRAYCOLOR;
        [view_3 addSubview:line_view];
        
        _fill_message_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _fill_message_btn.frame = CGRectMake(screenWide/2+5, 0, screenWide * 0.5-5, screenHeight * 0.05);
        [_fill_message_btn setTitle:@"去填写大交通信息" forState:UIControlStateNormal];
        [_fill_message_btn setTitleColor:RGB(190, 190, 190) forState:UIControlStateNormal];

        [view_3 addSubview:_fill_message_btn];
        _reality_label.text =@"2344";
        _realize_label.text = @"=344+2323+3434";
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
