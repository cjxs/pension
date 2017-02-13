//
//  TravelPersonTVCell.m
//  HealthySettle
//
//  Created by yrc on 17/2/10.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "TravelPersonTVCell.h"
#import "SelectOneView.h"

@implementation TravelPersonTVCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle: style
                reuseIdentifier:reuseIdentifier];
    if (self)
    {
        man = 1;
        NSArray * arr = @[@"出行人",@"手机号码",@"证件号码",@"性别"];
        for (int i = 0; i < 4; i++) {
            UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(10, screenHeight * 0.015 + screenHeight * 0.07*i, screenWide * 0.25, screenHeight * 0.04)];
            lab.text = arr[i];
            if (IS_IPHONE6EARLY) {
                lab.font = [UIFont systemFontOfSize:13];
            }
            [self addSubview:lab];
            
            UIView * line_view = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.07 * i, screenWide, 1)];
            line_view.backgroundColor = GRAYCOLOR;
            [self addSubview:line_view];
            
        }
        
        _name_field = [[UITextField alloc] initWithFrame:CGRectMake(screenWide * 0.27, screenHeight * 0.015, screenWide * 0.5, screenHeight * 0.04)];
        _name_field.placeholder = @"姓名";
        [self addSubview:_name_field];
        
        _add_person_btn  = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_add_person_btn];
        [_add_person_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(screenHeight *0.03, screenHeight * 0.03));
            make.right.equalTo(self).offset(-10);
            make.centerY.equalTo(_name_field);
        }];

        _phone_field = [[UITextField alloc] initWithFrame:CGRectMake(screenWide * 0.27, screenHeight * 0.085, screenWide * 0.5, screenHeight * 0.04)];
        _phone_field.placeholder = @"";
        [self addSubview:_phone_field];
        _id_field = [[UITextField alloc] initWithFrame:CGRectMake(screenWide * 0.27, screenHeight * 0.155, screenWide * 0.5, screenHeight * 0.04)];
        _id_field.placeholder = @"";
        [self addSubview:_id_field];
        
        man_view = [[SelectOneView alloc] initWithFrame:CGRectMake(screenWide * 0.27, screenHeight * 0.225, screenWide * 0.15, screenWide * 0.075)];
        [self addSubview:man_view];
        man_view.lab.text = @"男";
        @weakify(self);

        man_view.lab.textColor = [UIColor redColor];
        man_view.selectBlock =  ^(CGFloat num){
            int a =  (num - screenWide *0.27)/screenWide/0.15;
            @strongify(self);

            [self selectOne:a];
        };
        woman_view = [[SelectOneView alloc] initWithFrame:CGRectMake(screenWide * 0.52, screenHeight * 0.225, screenWide * 0.15, screenWide * 0.075)];
        [self addSubview:woman_view];
        woman_view.lab.text = @"女";
        woman_view.selectBlock =  ^(CGFloat num){
            int a =  num/screenWide/0.27;
            @strongify(self);

            [self selectOne:a];
        };
        
        
        
        
    }
    return self;
}
-(void)selectOne:(int)num{
    if (num ==0 ) {
        if (man != 1) {
            man = 1;
            man_view.lab.textColor = [UIColor redColor];
            woman_view.lab.textColor = [UIColor blackColor];
        }
        
    }else{
        man = 0;
        woman_view.lab.textColor = [UIColor redColor];
        man_view.lab.textColor = [UIColor blackColor];

    }
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
