//
//  TravelPersonTVCell.m
//  HealthySettle
//
//  Created by yrc on 17/2/10.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "TravelPersonTVCell.h"
#import "SelectOneView.h"
#import "YYLUser.h"
#import "ChooPersonView.h"

@implementation TravelPersonTVCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle: style
                reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _man = _man?_man:0;
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

        _phone_field = [[UITextField alloc] initWithFrame:CGRectMake(screenWide * 0.27, screenHeight * 0.085, screenWide * 0.5, screenHeight * 0.04)];
        _phone_field.placeholder = @"";
        [self addSubview:_phone_field];
        _id_field = [[UITextField alloc] initWithFrame:CGRectMake(screenWide * 0.27, screenHeight * 0.155, screenWide * 0.5, screenHeight * 0.04)];
        _id_field.placeholder = @"";
        [self addSubview:_id_field];
        if (IS_IPHONE6EARLY) {
            _name_field.font = [UIFont systemFontOfSize:13];
            _phone_field.font = [UIFont systemFontOfSize:13];
            _id_field.font = [UIFont systemFontOfSize:13];
        }
        
        man_view = [[SelectOneView alloc] initWithFrame:CGRectMake(screenWide * 0.27, screenHeight * 0.225, screenWide * 0.15, screenWide * 0.075)];
        [self addSubview:man_view];
        
        man_view.lab.text = @"男";
        @weakify(self);
        man_view.selectBlock =  ^(CGFloat num){
            int a =  (num - screenWide *0.27)/screenWide/0.15;
            a = a == 0?1:0;
            @strongify(self);
            [self selectOne:a];
        };
        
        woman_view = [[SelectOneView alloc] initWithFrame:CGRectMake(screenWide * 0.52, screenHeight * 0.225, screenWide * 0.15, screenWide * 0.075)];
        [self addSubview:woman_view];
        woman_view.lab.text = @"女";
        woman_view.selectBlock =  ^(CGFloat num){
            int a =  num/screenWide/0.27;
            a = a == 0?1:0;
            @strongify(self);
            [self selectOne:a];
        };
        [self selectOne:_man];
    }
    return self;
}
-(void)selectOne:(int)num{
    if (num == 0 ){
            _man = 0;
            woman_view.lab.textColor = [UIColor redColor];
            woman_view.img_view.image = [UIImage imageNamed:@"selected"];
            man_view.lab.textColor = [UIColor blackColor];
            man_view.img_view.image = [UIImage imageNamed:@"un_select"];
    }else{
        _man = 1;
        man_view.lab.textColor = [UIColor redColor];
        man_view.img_view.image = [UIImage imageNamed:@"selected"];
        woman_view.lab.textColor = [UIColor blackColor];
        woman_view.img_view.image = [UIImage imageNamed:@"un_select"];
    }
    _selectSex ? _selectSex([NSString stringWithFormat:@"%d",num]) : nil;

}
-(void)configWithBtn{
    
    _add_person_btn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_add_person_btn];
    [_add_person_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(screenHeight *0.03, screenHeight * 0.03));
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(_name_field);
    }];
    [_add_person_btn setBackgroundImage:[UIImage imageNamed:@"add_p"] forState:UIControlStateNormal];
    [_add_person_btn addTarget:self action:@selector(addPersonView) forControlEvents:UIControlEventTouchUpInside];

}
-(void)addPersonView{
    NSArray * arr = [Member DefaultUser].cont_arr;
    if (arr.count != 0) {
        ChooPersonView * choose_view = [[ChooPersonView alloc] init];
        
        choose_view.data_arr = arr;
        
        choose_view.selected = ^(NSDictionary *user){
            _name_field.text = user[@"travel_name"];
            _phone_field.text = user[@"travel_phone"];
            _id_field.text = user[@"travel_id"];
            [self selectOne:[user[@"travel_sex"] intValue]];
        };

        
        [choose_view addFirstView];
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:choose_view];
        
    }else{
        [SVProgressHUD showErrorWithStatus:@"您目前暂无常用联系人"];
    }

}

-(void)configWithYYLuser:(YYLUser *)user{
    if (user.travel_name) {
        self.name_field.text = user.travel_name;
    }
    if (user.travel_phone ) {
        self.phone_field.text = user.travel_phone;
    }
    if (user.travel_id) {
        self.id_field.text = user.travel_id;
    }
    if (user.travel_sex) {
        [self selectOne:[user.travel_sex intValue]];
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
