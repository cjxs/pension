//
//  SelectTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/4/2.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "SelectTVCell.h"


@implementation SelectTVCell
-(instancetype)init {
    self = [super init];
    if (self) {
        NSArray * array = @[@"护理级别",@"床位类型",@"饮食选择"];
        for (int i = 0; i < 3; i++) {
            UIView * line_view = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.123 *(i+1), screenWide, 1)];
            line_view.backgroundColor = RGB(245, 245, 245);
            [self addSubview:line_view];
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, screenHeight *0.008 *(i+1), screenWide * 0.18, screenHeight * 0.045)];
            label.text = array[i];
            [self addSubview:label];
        }
        
        
        
        
        
        
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
