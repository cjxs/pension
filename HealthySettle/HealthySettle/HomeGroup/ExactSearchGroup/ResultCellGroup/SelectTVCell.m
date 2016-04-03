//
//  SelectTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/4/2.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "SelectTVCell.h"


@implementation SelectTVCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray * array = @[@"护理级别",@"床位类型",@"饮食选择"];
        for (int i = 0; i < 3; i++) {
            UIView * line_view = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.123 *(i+1), screenWide, 1)];
            line_view.backgroundColor = RGB(245, 245, 245);
            [self addSubview:line_view];
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.02, screenHeight *0.008 +screenHeight * 0.123 * i, screenWide * 0.18, screenHeight * 0.045)];
            label.adjustsFontSizeToFitWidth = YES;
            label.text = array[i];
            [self addSubview:label];
        }
        NSArray * nurse_array =@[@"自理",@"半护",@"全护"];
        [self fundButtonWithArray:nurse_array andHeight:screenHeight * 0.055 Wide:screenWide /6];
        NSArray * bunk_array = @[@"单人间朝南",@"单人间朝南",@"单人间朝南"];
        [self fundButtonWithArray:bunk_array andHeight:screenHeight * 0.178 Wide:screenWide /4];
        NSArray * diet_array = @[@"不包餐",@"不包餐",@"不包餐"];
        [self fundButtonWithArray:diet_array andHeight:screenHeight * 0.301 Wide:screenWide /5];
        

}
    return self;
}
-(void)fundButtonWithArray:(NSArray *)array andHeight:(CGFloat)height Wide:(CGFloat)wide {
    for (int i = 0; i < array.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(wide / 5 + wide * (i * 1.2), height, wide, screenHeight *0.05);
        [btn setTitle:array[i] forState:UIControlStateNormal];
        btn.backgroundColor = RGB(244,245, 246);
        [btn setTitleColor:RGB(127, 128, 129) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        btn.clipsToBounds = YES;
        btn.layer.cornerRadius = 5;
        [btn addTarget:self action:@selector(selectNurseBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}
-(void)selectNurseBtn:(UIButton *)button {
  
    for (UIView * view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]] && view.frame.origin.y == button.frame.origin.y ) {
            UIButton * btn = view;
            btn.backgroundColor = RGB(244,245, 246);
            [btn setTitleColor:RGB(127, 128, 129) forState:UIControlStateNormal];
        }
    }
    button.backgroundColor = RGB(229, 12, 24);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
