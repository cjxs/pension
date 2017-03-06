//
//  OrdAndRefundTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/4/7.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "OrdAndRefundTVCell.h"
#import "Order_ed.h"

@implementation OrdAndRefundTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.organAddress_label.numberOfLines = 0;
    [self.first_btn.layer setBorderColor:RGB(237, 237, 237).CGColor];
    [self.first_btn.layer setBorderWidth:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)configOrderWithOrder:(Order_ed *)order type:(NSString *)type{
    if (self)
    {
        if ([order.cat_id intValue] == 3) {
            self.serve_label.text = [NSString stringWithFormat:@"目的地： %@",order.area_name];
            self.organAddress_label.text = [NSString stringWithFormat:@"出团日期: %@",[DDLogin timeStrWithstr:order.group_date]];
            self.number_label.text = [NSString stringWithFormat:@"报名人数: %@个",order.num];
        }else if([order.cat_id intValue] == 2) {
            if (order.order_spec.length!=0) {
                self.serve_label.text = [NSString stringWithFormat:@"服务细则： %@",order.order_spec];
            }else{
                self.serve_label.text = @"";
            }
            self.organAddress_label.text = [NSString stringWithFormat:@"入住:%@,退房:%@",[DDLogin timeStrWithstr:order.checkin_time],[DDLogin timeStrWithstr:order.checkout_time]];
            self.number_label.text = [NSString stringWithFormat:@"预订房间:%@间",order.lived_num];

        }else{
            self.serve_label.text = [NSString stringWithFormat:@"服务细则:%@",order.order_spec];
            self.organAddress_label.text = [NSString stringWithFormat:@"入住:%@,退房:%@",[DDLogin timeStrWithstr:order.checkin_time],[DDLogin timeStrWithstr:order.checkout_time]];
            self.number_label.text = [NSString stringWithFormat:@"入住人数:%@人",order.beds];
        }
        if (order.order_name)
        {
            self.title_label.text = order.order_name;
        }
        if (order.pic)
        {
            NSString *  str2 = [NSString stringWithFormat:@"%@/upload/group/%@",BASEURL,order.pic];
            NSString * str3 = [str2 stringByReplacingOccurrencesOfString:@"," withString:@"/"];
            [self.organImage_view sd_setImageWithURL:[NSURL URLWithString:str3] placeholderImage:[UIImage imageNamed:@"list_p"]];
        }
        if ([type isEqualToString:@"refund"]){
            self.first_btn.alpha = 0;
            self.price_label.text = [NSString stringWithFormat:@"总价钱:%@",order.total_money];
            
            if ([order.status intValue] == 2) {
                self.type_label.text = @"处理中";
            }else if ([order.status intValue] == 4 ||[order.status intValue] == 5 ||[order.status intValue] == 8 ){
                self.type_label.text = @" 退款成功";
            }else if ([order.status intValue] == 9){
                self.type_label.text = @" 退款失败";
            }
        }else {
            if ([order.dd_status intValue] == 19 )
            {
                self.type_label.text = @"待付款";
                if ([order.pay_type isEqualToString:@"线下支付"]) {
                    self.type_label.text = order.pay_type;
                    
                }else{
                    self.type_label.text = @"待付款";
                }
                
                [self.first_btn setTitle:@"去付款"
                                forState:UIControlStateNormal];
                self.first_btn.alpha = order.pay_type.length == 0?1:0;
                self.price_label.text = [NSString stringWithFormat:@"待付款:%@",order.payment_money];
            }else if ([order.dd_status intValue] == 20 ){
                self.type_label.text = @"已关闭";
                
                self.first_btn.alpha = 0;
                self.price_label.text = [NSString stringWithFormat:@"总价钱:%@",order.total_money];
            }else if ([order.dd_status intValue] == 21 ){
                self.first_btn.alpha = 0;
                self.type_label.text = @"使用中";
                NSInteger money = [order.payment_money intValue] + [order.balance_pay intValue];
                self.price_label.text = [NSString stringWithFormat:@"实付款:%ld",money];
            }else{
                self.first_btn.alpha = 0;
                self.type_label.text = @"已付款";
                NSInteger money = [order.payment_money intValue] + [order.balance_pay intValue];
                self.price_label.text = [NSString stringWithFormat:@"实付款:%ld",money];
            }

        }
        self.price_label.textAlignment = NSTextAlignmentRight;
        self.type_label.textAlignment = NSTextAlignmentRight;
        if (order.add_time) {
            self.add_time_label.text = [NSString stringWithFormat:@"下单时间:%@",[DDLogin timeStrWithstr:order.add_time]];
        }
        

    }

    
}

-(void)configRefundWithtitle:(NSString *)title
                       image:(UIImage *)image
                        type:(NSInteger)type
                       price:(NSString *)price
{
    if (self)
    {
        if (title)
        {
            self.title_label.text = title;
        }
        if (image)
        {
            self.organImage_view.image = image;
        }
        if (type == 1)
        {
            self.type_label.text = @"未处理";
            [self.first_btn setTitle:@"查看订单"
                            forState:UIControlStateNormal];
//            [self.second_btn setTitle:@"取消付款"
//                             forState:UIControlStateNormal];
            self.serve_label.text = @"自理｜单人间朝南｜包餐";
            self.organAddress_label.text = @"地址：杭州市滨江区江晖路隆和国际603fsgsdkyarhkgadgdshgfjzdhgfzdhj";
        }else if (type == 2)
        {
            self.type_label.text = @"已退款";
            [self.first_btn setTitle:@"查看订单"
                            forState:UIControlStateNormal];
//            [self.second_btn setTitle:@"删除订单"
//                             forState:UIControlStateNormal];
            self.serve_label.text = @"自理｜单人间朝南｜包餐";
            self.organAddress_label.text = @"地址：杭州市滨江区江晖路隆和国际603fsgsdkyarhkgadgdshgfjzdhgfzdhj";
        }
        if (price)
        {
            self.price_label.text = price;
        }
    }
}
@end
