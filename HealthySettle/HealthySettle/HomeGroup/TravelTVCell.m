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
        _price_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWide * 0.134, screenHeight * 0.0201)];
        _price_label.textColor = PINKCOLOR;
        _price_label.font = [UIFont systemFontOfSize:15];
    }
    return _price_label;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.organization_image];
        
        [self addSubview:self.organization_title];
        _organization_title.text = @"的房间客户公司电话概括地说法国进口是倒海翻江韩国棒子广播电视界官方图为一人一天噶俄还将发布";
        
//        [self.price_label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.organization_image);
//            make.right.mas_equalTo(_organization_title.mas_right).offset(-15);
//        }];
//        [self.price_label mas_remakeConstraints:^(MASConstraintMaker *make) {

//        }];
//        [self addSubview:_price_label];
        UILabel * qi_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        qi_label.text = @"起";
//        [qi_label mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(_organization_image);
//            make.right.equalTo(_organization_title.mas_right);
//        }];
        qi_label.textColor = [UIColor colorWithHexString:@"#999999"];
        qi_label.font = [UIFont systemFontOfSize:10];
//        [self addSubview:qi_label];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
