//
//  SumAndPayTVCell.m
//  HealthySettle
//
//  Created by yrc on 17/2/13.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "SumAndPayTVCell.h"

@implementation SumAndPayTVCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle: style
                reuseIdentifier:reuseIdentifier];
    if (self)
    {

        UIView * line_v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight * 0.015)];
        [self addSubview:line_v];
        line_v.backgroundColor = GRAYCOLOR;
        NSArray * arr = @[@"商品金额",@"现金账户",@"优悠券",@"",@"还需支付"];
        for (int i = 0; i < 5; i++) {
            if (i==3) {
                continue;
            }else{
                UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(10, screenHeight * 0.03 + screenHeight * 0.04*i, screenWide * 0.25, screenHeight * 0.04)];
                lab.text = arr[i];
                if (IS_IPHONE6EARLY) {
                    lab.font = [UIFont systemFontOfSize:13];
                }
                [self addSubview:lab];
                UILabel * title_lab_0 = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.7, screenHeight * 0.03 + screenHeight * 0.04*i, screenWide * 0.27, screenHeight * 0.04)];
                title_lab_0.textColor = [UIColor redColor];
                title_lab_0.textAlignment = NSTextAlignmentRight;
                switch (i) {
                    case 0:
                        _num_sum_label = title_lab_0;
                        [self addSubview:_num_sum_label];
                        break;
                    case 1:
                        _balan_label = title_lab_0;
                        [self addSubview:_balan_label];
                        break;
                    case 2:
                        _vocher_label = title_lab_0;
                        [self addSubview:_vocher_label];
                        break;
                    case 4:
                        _unpaid_label = title_lab_0;
                        [self addSubview:_unpaid_label];
                        break;
                        
                    default:
                        break;
                }
            }
            
            
        }
        UIView * line_view = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.175, screenWide, 1)];
        line_view.backgroundColor = GRAYCOLOR;
        [self addSubview:line_view];
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.235, screenWide, screenHeight * 0.15)];
        [self addSubview:view];
        view.backgroundColor = GRAYCOLOR;
        
        
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
