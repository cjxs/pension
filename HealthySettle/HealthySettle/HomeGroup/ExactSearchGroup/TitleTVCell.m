//
//  TitleTVCell.m
//  HealthySettle
//
//  Created by yrc on 17/1/5.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "TitleTVCell.h"

@implementation TitleTVCell
-(UILabel *)organization_title{
    if (!_organization_title) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.032, screenHeight *0.01499, screenWide * 0.936, screenHeight * 0.04947)];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:14];
        _organization_title = label;
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
-(UILabel *)introduce_label{
    if (!_introduce_label) {
        _introduce_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.2, screenHeight * 0.17239, screenWide * 0.75, screenHeight * 0.02848)];
        _introduce_label.textColor = [UIColor grayColor];
        _introduce_label.textAlignment = NSTextAlignmentRight;
        _introduce_label.text = @"简介 >";
    }
    return _introduce_label;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.organization_title];
        _organization_title.text = @"那是尽快发货速度会加快高峰时间很快过，哈fhghrt的首付款结核杆菌稻盛和夫个环境，多半是 v 和机不可失短裤说把 v 美女";

        UIView * line_view1 = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight*0.1574, screenWide, 1)];
        line_view1.backgroundColor = [UIColor colorWithHexString:@"#ebebeb"];
        [self addSubview:line_view1];
        
        dis_label = [[UILabel alloc] init];
        dis_label.textColor = WHITECOLOR;
        dis_label.backgroundColor = [UIColor colorWithHexString:@"#73b8ff"];
        dis_label.text = @"返券";
        dis_label.textAlignment = NSTextAlignmentCenter;
        dis_label.font = [UIFont systemFontOfSize:11];
        [self addSubview:dis_label];
        [dis_label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(screenWide * 0.09066, screenHeight * 0.02099));
            make.left.equalTo(self.organization_title);
            make.bottom.equalTo(line_view1).offset(-screenHeight * 0.01499);
        }];
        
        UILabel * qi_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        qi_label.text = @"起";
        [self addSubview:qi_label];
        
        [qi_label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(line_view1).offset(-screenHeight * 0.01499);
            make.right.equalTo(_organization_title);
        }];
        qi_label.textColor = [UIColor colorWithHexString:@"#999999"];
        qi_label.font = [UIFont systemFontOfSize:10];
        
        
        UILabel * ren_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        ren_label.text = @"/人";
        [self addSubview:ren_label];
        
        [ren_label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(qi_label).offset(screenHeight * 0.002);
            make.right.mas_equalTo(qi_label.mas_left);
        }];
        ren_label.textColor = [UIColor grayColor];
        ren_label.font = [UIFont systemFontOfSize:13];
        
        
        [self addSubview:self.price_label];
        _price_label.text = @"¥ 33568";
        [self.price_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(qi_label);
            make.right.mas_equalTo(ren_label.mas_left);
        }];
        UIImageView * leader_iView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"address_choose"]];
        leader_iView.frame = CGRectMake(screenWide * 0.032, screenHeight * 0.17239, screenWide * 0.05866, screenWide * 0.05866);
        [self addSubview:leader_iView];
        UILabel * leader_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.12266, screenHeight * 0.17239, screenWide * 0.4, screenHeight * 0.02848)];
        leader_label.text = @"备案管家";
        leader_label.textColor = [UIColor grayColor];
        [self addSubview:leader_label];
        [self addSubview:self.introduce_label];
        _introduce_label.userInteractionEnabled = YES;
        
    }
    return self;
}
-(void)configTitle:(NSString *)title recommend:(NSString *)recommend return:(NSString *)vochers price:(NSString *)price{
    _organization_title.text = title;
    _price_label.text = price;
    NSString * str = [NSString stringWithFormat:@"返%@优悠券",vochers];
    if (str) {
        UILabel * man_label = [[UILabel alloc] init];
        man_label.text = str;
        man_label.textColor = [UIColor grayColor];
        man_label.font = [UIFont systemFontOfSize:11];
        [self addSubview:man_label];
        [man_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo([self sizeWithString:str]);
            make.left.mas_equalTo(dis_label.mas_right).offset(screenWide * 0.0266);
            make.top.equalTo(dis_label);
        }];
    }
    NSArray *array = [recommend componentsSeparatedByString:@","];
    if (array) {
        UILabel * label0;
        for (int i = 0;i < array.count; i++) {
            UILabel * label1 = [[UILabel alloc] init];
            label1.text = array[i];
            label1.layer.borderColor = [[UIColor greenColor] CGColor];
            label1.textColor =[UIColor greenColor];
            label1.layer.borderWidth = 0.5f;
            label1.layer.cornerRadius = 2;
            label1.layer.masksToBounds = YES;
            label1.font = [UIFont systemFontOfSize:11];
            label1.textAlignment = NSTextAlignmentCenter;
            [self addSubview:label1];
            if (!label0) {
                [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo([self sizeWithString:array[i]]);
                    make.left.equalTo(_organization_title);
                    make.top.mas_equalTo(_organization_title.mas_bottom).offset(screenHeight * 0.01499);
                }];
            }else{
                [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo([self sizeWithString:array[i]]);
                    make.left.mas_equalTo(label0.mas_right).offset(screenWide * 0.0266);
                    make.top.mas_equalTo(_organization_title.mas_bottom).offset(screenHeight * 0.01499);
                }];
            }
            label0 = label1;
        }
    }

    
}
//计算划掉的数字长度
- (CGSize )sizeWithString:(NSString *)string
{
    UILabel * label = [[UILabel alloc] init];
    label.text = string;
    UIFont * fnt = [UIFont fontWithName:string size:11];
    label.font = fnt;
    CGSize size =[label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil]];
    return size;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
