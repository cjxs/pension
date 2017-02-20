//
//  ConPersonTVCell.m
//  HealthySettle
//
//  Created by yrc on 17/2/20.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "ConPersonTVCell.h"

@implementation ConPersonTVCell{
    UILabel * name_label,*card_label;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        name_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.1, screenHeight * 0.005, screenWide * 0.3, screenHeight*0.04)];
        [self addSubview:name_label];
        card_label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.1, screenHeight * 0.045, screenWide * 0.5, screenHeight * 0.025)];
        [self addSubview:card_label];
        UIView *line_view = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.08-1, screenWide, 1)];
        line_view.backgroundColor = GRAYCOLOR;
        [self addSubview:line_view];
        
    }
    return self;
}
-(void)configWithName:(NSString *)name card:(NSString *)card{
    if (name) {
        name_label.text = name;
    }
    if (card) {
        card_label.text = card;
        card_label.textColor = [UIColor grayColor];
    }else{
        card_label.text = @"请补充证件信息";
        card_label.textColor = [UIColor redColor];
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
