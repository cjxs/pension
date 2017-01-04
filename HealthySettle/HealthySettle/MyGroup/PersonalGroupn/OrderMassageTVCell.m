//
//  OrderMassageTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/12/9.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "OrderMassageTVCell.h"
#import "OrderMasView.h"
#import "ArrayLabelView.h"
#import "Order_ed.h"

@implementation OrderMassageTVCell{
    UILabel * order_name_label;
    OrderMasView * order_oView;
}

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
        order_name_label = [[UILabel alloc] initWithFrame:CGRectMake(10,5, screenWide, 30)];
        order_name_label.text = @"杭州上城区维康老年公寓";
        [self addSubview:order_name_label];
        order_oView = [[OrderMasView alloc] initWithFrame:CGRectMake(0, 40, screenWide, screenWide/4 + 20)];
        [self addSubview:order_oView];
        NSArray * array1 = @[@"满减",@"－¥20.00",@"积分抵扣",@"－¥0.38",@"现金账户",@"－¥35.00"];
        ArrayLabelView * arrayLabel_view1 = [[ArrayLabelView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(order_oView.frame), screenWide, array1.count * 20) Array:array1 color:UIColorFromHex(@"#929394")];
        [self addSubview:arrayLabel_view1];
        UIView *line_view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(arrayLabel_view1.frame), screenWide, 1)];
        line_view.backgroundColor =  UIColorFromHex(@"#e0e1e2");
        [self addSubview:line_view];

        NSArray * array2 = @[@"待付款",@"¥568.00"];
        ArrayLabelView * arrayLabel_view2 = [[ArrayLabelView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line_view.frame), screenWide, array2.count * 20 + 10) Array:array2 color:UIColorFromHex(@"#ec3538")];
        [self addSubview:arrayLabel_view2];
        
        UIView * back_view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(arrayLabel_view2.frame), screenWide, 10)];
        back_view.backgroundColor = UIColorFromHex(@"#e0e1e2");
        [self addSubview:back_view];

    }
    return self;
}
-(void)configWithOrder:(Order_ed *)order{
    order_name_label.text = order.order_name;
    if (order.pic)
    {
        NSString *  str2 = [NSString stringWithFormat:@"%@/upload/group/%@",BASEURL,order.pic];
        NSString * str3 = [str2 stringByReplacingOccurrencesOfString:@"," withString:@"/"];
        [order_oView.group_imageView sd_setImageWithURL:[NSURL URLWithString:str3] placeholderImage:[UIImage imageNamed:@"list_p"]];
    }
    order_oView.orderSpec_label.text = order.order_spec;
    order_oView.orderPrice_label.text = [NSString stringWithFormat:@"¥%@",order.price];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
