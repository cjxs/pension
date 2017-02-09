//
//  TravelTVCell.m
//  HealthySettle
//
//  Created by yrc on 17/1/4.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "TravelTVCell.h"

@implementation TravelTVCell

-(UIImageView *)organization_image{
    if (_organization_image == nil) {
        _organization_image = [[UIImageView alloc] initWithFrame:CGRectMake(screenWide * 0.032, screenHeight * 0.02248, screenWide * 0.4, screenHeight * 0.1274)];
        _organization_image.image = [UIImage imageNamed:@"list_p"];
        
    }
    return _organization_image;
}
-(UILabel * )organization_title {
    if (_organization_title == nil) {
        _organization_title = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.4586, screenHeight * 0.02248, screenWide * 0.5093, screenHeight * 0.07496)];
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
        _price_label.textAlignment = NSTextAlignmentLeft;
        _price_label.font = [UIFont systemFontOfSize:15];
    }
    return _price_label;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.organization_image];
        
        [self addSubview:self.organization_title];
        [self addSubview:self.price_label];
        self.price_label.adjustsFontSizeToFitWidth = YES;
        [self.price_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(screenWide * 0.15, screenHeight * 0.0201));
            make.bottom.equalTo(_organization_image);
            make.left.equalTo(_organization_title);
        }];
        UILabel * qi_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        qi_label.text = @"起";
        [self addSubview:qi_label];

        [qi_label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_organization_image);
            make.left.equalTo(_organization_title).offset(screenWide * 0.154);
        }];
        qi_label.textColor = [UIColor colorWithHexString:@"#999999"];
        qi_label.font = [UIFont systemFontOfSize:10];
        
        UIView * line_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0.17241 * screenHeight-1, screenWide, 1)];
        [self addSubview:line_view];
        line_view.backgroundColor = GRAYCOLOR;
    }
    return self;
}
-(void)configWithData:(NSDictionary *)data{
    if (data[@"discount_info"]) {
        UILabel * dis_label = [[UILabel alloc] init];
        dis_label.textColor = WHITECOLOR;
        
        dis_label.backgroundColor = [UIColor colorWithHexString:@"#73b8ff"];
        dis_label.text = @"返券";
        dis_label.textAlignment = NSTextAlignmentCenter;
        dis_label.font = [UIFont systemFontOfSize:11];
        [self addSubview:dis_label];
        [dis_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(screenWide * 0.09066, screenHeight * 0.02099));
            make.right.equalTo(self.organization_title);
            make.bottom.equalTo(self.organization_image);
        }];

    }
    _price_label.text = [NSString stringWithFormat:@"¥ %@",data[@"price"]];
    _organization_title.text = data[@"name"];
    NSString *  str2 = [NSString stringWithFormat:@"%@/upload/group/%@",BASEURL,data[@"pic"]];
    NSString * str3 = [str2 stringByReplacingOccurrencesOfString:@"," withString:@"/"];
    [_organization_image sd_setImageWithURL:[NSURL URLWithString:str3] placeholderImage:[UIImage imageNamed:@"list_p"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
