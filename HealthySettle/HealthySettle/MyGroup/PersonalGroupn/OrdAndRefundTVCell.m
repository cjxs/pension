//
//  OrdAndRefundTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/4/7.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "OrdAndRefundTVCell.h"

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
-(void)configOrderWithtitle:(NSString *)title
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
            self.type_label.text = @"待付款";
            [self.first_btn setTitle:@"取消订单"
                            forState:UIControlStateNormal];
            [self.second_btn setTitle:@"付款"
                             forState:UIControlStateNormal];
            self.serve_label.text = @"自理｜单人间朝南｜包餐";
            self.organAddress_label.text = @"地址：杭州市滨江区江晖路隆和国际603fsgsdkyarhkgadgdshgfjzdhgfzdhj";
        }else if (type == 2) {
            self.type_label.text = @"待使用";
            [self.first_btn setTitle:@"取消订单"
                            forState:UIControlStateNormal];
            [self.second_btn setTitle:@"使用"
                             forState:UIControlStateNormal];
            self.serve_label.text = @"自理｜单人间朝南｜包餐";
            self.organAddress_label.text = @"地址：杭州市滨江区江晖路隆和国际603fsgsdkyarhkgadgdshgfjzdhgfzdhj";
        }else if (type == 3) {
            self.type_label.text = @"待评价";
            [self.first_btn setTitle:@"取消订单"
                            forState:UIControlStateNormal];
            [self.second_btn setTitle:@"评价"
                             forState:UIControlStateNormal];
            self.serve_label.text = @"自理｜单人间朝南｜包餐";
            self.organAddress_label.text = @"地址：杭州市滨江区江晖路隆和国际603fsgsdkyarhkgadgdshgfjzdhgfzdhj";
        }
        if (price) {
            self.price_label.text = price;
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
            [self.second_btn setTitle:@"取消付款"
                             forState:UIControlStateNormal];
            self.serve_label.text = @"自理｜单人间朝南｜包餐";
            self.organAddress_label.text = @"地址：杭州市滨江区江晖路隆和国际603fsgsdkyarhkgadgdshgfjzdhgfzdhj";
        }else if (type == 2)
        {
            self.type_label.text = @"已退款";
            [self.first_btn setTitle:@"查看订单"
                            forState:UIControlStateNormal];
            [self.second_btn setTitle:@"删除订单"
                             forState:UIControlStateNormal];
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
