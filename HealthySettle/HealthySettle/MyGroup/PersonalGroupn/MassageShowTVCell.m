//
//  MassageShowTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/12/8.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "MassageShowTVCell.h"

@implementation MassageShowTVCell{
    UILabel * title_label;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        title_label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 30)];
        [self addSubview:title_label];
        
        
        
    }
    return self;
}
-(void)configWithTitle:(NSString *)title Array:(NSArray *)array{
        title_label.text = title;
    for (int i = 0; i < array.count; i++) {
        UILabel * title_name_label = [[UILabel alloc] initWithFrame:CGRectMake(10, 40 + i * 40, screenWide /4, 40)];
        title_name_label.textColor = UIColorFromHex(@"#909192");
        UILabel * text_label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(title_name_label.frame) + 10, 40 + i * 40, screenWide/4 * 3 - 20, 40)];

        if (i% 2 == 0) {
            UIView * line_view = [[UIView alloc] initWithFrame:CGRectMake(0, 39 + i * 80, screenWide, 1)];
            line_view.backgroundColor = UIColorFromHex(@"#e0e1e2");
            [self addSubview:line_view];
            title_name_label.text = [title_label.text isEqualToString:@"预定信息"]?@"联系人":[NSString stringWithFormat:@"入住人%d",i/2 + 1];
        }else{
            title_name_label.text = [title_label.text isEqualToString:@"预定信息"]?@"联系电话":@"身份证号";
        }
        text_label.text = array[i];
        [self addSubview:title_name_label];
        [self addSubview:text_label];
    }
    UIView * back_view = [[UIView alloc] initWithFrame:CGRectMake(0, 40 + array.count/2 * 80, screenWide, 10)];
    back_view.backgroundColor = UIColorFromHex(@"#e0e1e2");
    [self addSubview:back_view];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
