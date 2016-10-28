//
//  HomeTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/4/1.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "HomeTVCell.h"


@implementation HomeTVCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    UIView * margin_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, 13)];
    margin_view.backgroundColor =  RGB(242, 242, 242);
    [self addSubview:margin_view];

    self.reserve_btn.clipsToBounds = YES;
    self.reserve_btn.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
-(void)configWithdic:(NSDictionary*)dic show:(NSString *)show
{
    if (dic[@"pic"])
    {
        [self.organ_imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"pic"]] placeholderImage:@"list_p"];

    }
    if (dic[@"room_type"]) {
        self.room_type.text = dic[@"room_type"];
    }

    if (dic[@"room_price"])
    {
        self.price_label.text = [NSString stringWithFormat:@"¥ %d",[dic[@"room_price"] intValue]];
    }
    if ([dic[@"is_catered"] integerValue] == 1) {
        self.catered_l.text = @"包早餐";
    }else if ([dic[@"is_catered"] integerValue] == 2) {
        self.catered_l.text = @"包三餐";
    }else{
        self.catered_l.text = @"不包餐";
    }
    if ([dic[@"is_wifi"] integerValue] == 1) {
        self.bed_type.text = [NSString stringWithFormat:@"%@|免费WiFi",dic[@"bed_type"]];
    }
    if (dic[@"size"]) {
        self.size_l.text = [NSString stringWithFormat:@"房间%@m2",dic[@"size"]];
    }
    if (dic[@"live_num"]) {
        self.live_num.text = [NSString stringWithFormat:@"可住%@人",dic[@"live_num"]];
    }
    
    if ([show isEqualToString:@"y"])
    {
        UIView * view = [[UIView alloc]
                         initWithFrame:CGRectMake(0, 156, screenWide, 60)];
        for (int i = 0; i < 2; i++)
        {
            UIView * viewB = [[UIView alloc]
                              initWithFrame:CGRectMake(0, 25*i, screenWide , 23)];
            if (i == 0)
            {
                viewB.backgroundColor = RGB(246, 246, 246);
                NSArray * array = @[@"1-6天",@"7-14天",@"15-29天",@"多于30天"];
                for (int i = 0; i < 4; i++)
                {
                    UILabel * label = [[UILabel alloc]
                                       initWithFrame:CGRectMake((screenWide /4 )*i, 0, screenWide /4 , 25)];
                    label.font = [UIFont systemFontOfSize:10];
                    label.text = array[i];
                    label.textAlignment = NSTextAlignmentCenter;
                    [viewB addSubview:label];
                }
            }else
            {
                NSDictionary * dic_b = dic[@"price_spec"];
                int j = 0;
                for (NSString * val in dic_b) {
                    UILabel * label = [[UILabel alloc]
                                       initWithFrame:CGRectMake(screenWide/4 * j, 0, screenWide /4, 25)];
                    label.font = [UIFont systemFontOfSize:10];
                    label.text = dic_b[val];
                    label.textAlignment = NSTextAlignmentCenter;
                    [viewB addSubview:label];
                    j++;

                }
                viewB.backgroundColor = RGB(251, 251, 251);
             
            }
            [view addSubview:viewB];
        }
        
        [self addSubview:view];
    }
}
@end
