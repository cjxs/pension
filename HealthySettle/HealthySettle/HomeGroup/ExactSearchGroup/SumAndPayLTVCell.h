//
//  SumAndPayLTVCell.h
//  HealthySettle
//
//  Created by yrc on 17/2/14.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SumAndPayLTVCell : UITableViewCell
{
    UILabel * _realize_label,* _add_time_label,* _reality_label,* _vocher_label,* _num_sum_label,* _pay_way_label;
}

@property (nonatomic,strong)UIButton * contact_btn,*fill_message_btn;


@end
