//
//  ContentsTVCell.m
//  HealthySettle
//
//  Created by yrc on 17/2/10.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "ContentsTVCell.h"

@implementation ContentsTVCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle: style
                reuseIdentifier:reuseIdentifier];
    if (self)
    {
        NSArray * arr = @[@"联系人",@"联系人手机"];
        NSArray * arr2 = @[@"联系人信息",@"出行人信息"];
        for (int i = 0; i < 2; i++) {
            UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(10, screenHeight * 0.1 + screenHeight * 0.07*i, screenWide * 0.25, screenHeight * 0.04)];
            lab.text = arr[i];
            lab.font = [UIFont systemFontOfSize:13];

            [self addSubview:lab];
            UILabel * title_lab_0 = [[UILabel alloc] initWithFrame:CGRectMake(10, screenHeight * 0.03 + screenHeight * 0.225 * i, screenWide * 0.4, screenHeight * 0.04)];
            [self addSubview:title_lab_0];
            title_lab_0.textColor = [UIColor redColor];
            title_lab_0.text = arr2[i];

            UIView * line_view = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.015 + screenHeight * 0.07 * (i+1), screenWide, 1)];
            line_view.backgroundColor = GRAYCOLOR;
            [self addSubview:line_view];
            
            UIView * line_view_0 = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.225 * i, screenWide, screenHeight * 0.015)];
            line_view_0.backgroundColor = GRAYCOLOR;
            [self addSubview:line_view_0];
        }
        
        _name_field = [[UITextField alloc] initWithFrame:CGRectMake(screenWide * 0.27, screenHeight * 0.1, screenWide * 0.5, screenHeight * 0.04)];
        _name_field.placeholder = @"姓名";
        [self addSubview:_name_field];
        _phone_field = [[UITextField alloc] initWithFrame:CGRectMake(screenWide * 0.27, screenHeight * 0.17, screenWide * 0.5, screenHeight * 0.04)];
        _phone_field.placeholder = @"请填写真实号码";
        [self addSubview:_phone_field];
        _add_person_btn  = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_add_person_btn];
        [_add_person_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(screenHeight *0.03, screenHeight * 0.03));
            make.right.equalTo(self).offset(-10);
            make.centerY.equalTo(_name_field);
        }];

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
