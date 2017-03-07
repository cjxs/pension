//
//  TravelPLabelTVCell.m
//  HealthySettle
//
//  Created by yrc on 17/2/14.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "TravelPLabelTVCell.h"
#import "SelectOneView.h"
@implementation TravelPLabelTVCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle: style
                reuseIdentifier:reuseIdentifier];
    if (self)
    {
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
        
        _name_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.27, screenHeight * 0.015, screenWide * 0.5, screenHeight * 0.04)];
        [self addSubview:_name_label];
        
        
        _phone_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.27, screenHeight * 0.085, screenWide * 0.5, screenHeight * 0.04)];
        [self addSubview:_phone_label];
        
        _id_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.27, screenHeight * 0.155, screenWide * 0.5, screenHeight * 0.04)];
        [self addSubview:_id_label];
        if (IS_IPHONE6EARLY) {
            _name_label.font = [UIFont systemFontOfSize:13];
            _phone_label.font = [UIFont systemFontOfSize:13];
            _id_label.font = [UIFont systemFontOfSize:13];
        }
        
        
        man_view = [[SelectOneView alloc] initWithFrame:CGRectMake(screenWide * 0.27, screenHeight * 0.225, screenWide * 0.15, screenWide * 0.075)];
        [self addSubview:man_view];
        man_view.lab.text = @"男";
        
        woman_view = [[SelectOneView alloc] initWithFrame:CGRectMake(screenWide * 0.52, screenHeight * 0.225, screenWide * 0.15, screenWide * 0.075)];
        [self addSubview:woman_view];
        woman_view.lab.text = @"女";
    }
    return self;
}
-(void)configWithStr:(NSString *)str{
    NSArray * arr = [str componentsSeparatedByString:@","];
    if (arr&& arr.count == 4) {
        _name_label.text = arr[0];
        _phone_label.text = arr[1];
        _id_label.text = arr[2];
        if ([arr[3] intValue] == 0) {
            woman_view.lab.textColor = [UIColor redColor];
            woman_view.img_view.image = [UIImage imageNamed:@"selected"];
            man_view.lab.textColor = [UIColor blackColor];
            man_view.img_view.image = [UIImage imageNamed:@"un_select"];
        }else{
            man_view.lab.textColor = [UIColor redColor];
            man_view.img_view.image = [UIImage imageNamed:@"selected"];
            woman_view.lab.textColor = [UIColor blackColor];
            woman_view.img_view.image = [UIImage imageNamed:@"un_select"];

        }
        
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
