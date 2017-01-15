//
//  PensionSRTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/3/31.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "PensionSRTVCell.h"


@implementation PensionSRTVCell
-(UIImageView *)organization_image{
    if (_organization_image == nil) {
        _organization_image = [[UIImageView alloc] initWithFrame:CGRectMake(screenWide * 0.032, screenHeight * 0.02248, screenWide * 0.4, screenHeight * 0.1274)];
        _organization_image.image = [UIImage imageNamed:@"list_p"];
        
    }
    return _organization_image;
}
-(UILabel * )organization_title {
    if (_organization_title == nil) {
        _organization_title = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.4586, screenHeight * 0.02248, screenWide * 0.5093, screenHeight * 0.04498)];
        _organization_title.textColor = [UIColor colorWithHexString:@"#333333"];
        _organization_title.numberOfLines = 0;
        _organization_title.font = [UIFont systemFontOfSize:13];
    }
    return _organization_title;
}
-(UILabel *)price_label {
    if (_price_label == nil) {
        _price_label = [[UILabel alloc] init];
        _price_label.textColor = PINKCOLOR;
        _price_label.textAlignment = NSTextAlignmentRight;
        _price_label.font = [UIFont systemFontOfSize:15];
    }
    return _price_label;
}
-(UILabel *)organization_address {
    if (_organization_address == nil) {
        _organization_address = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.4586, screenHeight * 0.08245, screenWide * 0.5093, screenHeight * 0.03898)];
        _organization_address.textColor = [UIColor colorWithHexString:@"#666666"];
        _organization_address.font = [UIFont systemFontOfSize:12];
        _organization_address.numberOfLines = 0;
    }
    return _organization_address;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.organization_image];
        [self addSubview:self.price_label];
        [self addSubview:self.organization_title];
        [self addSubview:self.organization_address];
        
        _organization_title.text = @"客户公司电话概括地说法国进口是倒海翻江韩国棒子广播电视界官方图为一人一天噶俄还将发布";
        _organization_address.text = @"养老回家规范化建设高房价的设计风格撒娇都会风格设计";
        _price_label.text = @"¥ 35467";
        [self.price_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(screenWide * 0.154, screenHeight * 0.0201));
            make.bottom.equalTo(_organization_image);
            make.right.equalTo(_organization_title).offset(-15);
        }];

        UILabel * qi_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        qi_label.text = @"起";
        [self addSubview:qi_label];
        
        [qi_label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_organization_image);
            make.right.equalTo(_organization_title.mas_right);
        }];
        qi_label.textColor = [UIColor colorWithHexString:@"#999999"];
        qi_label.font = [UIFont systemFontOfSize:10];
        
        UIView * line_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0.17241 * screenHeight-1, screenWide, 1)];
        [self addSubview:line_view];
        line_view.backgroundColor = GRAYCOLOR;
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)configWithData:(NSDictionary *)data{
    [self.organization_image sd_setImageWithURL:[NSURL URLWithString:data[@"pic"]] placeholderImage:[UIImage imageNamed:@"list_p"]];
    self.organization_title.text = data[@"name"];
    self.organization_address.text = [NSString stringWithFormat:@"地址: %@",data[@"address"]];
    self.price_label.text = [NSString stringWithFormat:@"¥%@",data[@"price"]];



}
- (void)configWithimage:(NSString *)image_u
                  title:(NSString *)title
                address:(NSString *)address
                 number:(NSString *)number
                  price:(NSString *)price
{
    if (image_u)
    {
        NSLog(@"%@+++++++",image_u);
        [self.organization_image sd_setImageWithURL:[NSURL URLWithString:image_u] placeholderImage:[UIImage imageNamed:@"list_p"]];
    }
    if (title)
    {
        self.organization_title.text = title;
    }
    if (address)
    {
        self.organization_address.text = [NSString stringWithFormat:@"地址: %@",address];
    }
    if (number)
    {
    }
    if (price)
    {
        self.price_label.text = [NSString stringWithFormat:@"¥%@",price];
    }
    
}
@end
