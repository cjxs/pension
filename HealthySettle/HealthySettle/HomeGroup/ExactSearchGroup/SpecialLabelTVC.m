//
//  SpecialLabelTVC.m
//  HealthySettle
//
//  Created by yrc on 16/12/2.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "SpecialLabelTVC.h"

@implementation SpecialLabelTVC
-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle: style
                reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;

}
-(void)configWithData:(NSArray *)data_arr color:(UIColor *)color{
    UILabel * title_label, * status_label;

    for (int i = 0; i < [data_arr count]/2;i++ ) {
        title_label = [[UILabel alloc] initWithFrame:CGRectMake(16, 5 + 40*i, 150, 40)];
        title_label.text = data_arr[0+i*2];
        title_label.textAlignment = NSTextAlignmentLeft;
        title_label.font = [UIFont systemFontOfSize:16];
        status_label = [[UILabel alloc] initWithFrame:CGRectMake(166, 5+40*i, screenWide - 192, 40)];
        status_label.text = data_arr[1+i*2];
        status_label.textColor = color;
        status_label.textAlignment = NSTextAlignmentRight;
        status_label.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:title_label];
        [self addSubview:status_label];
    }
}

@end
