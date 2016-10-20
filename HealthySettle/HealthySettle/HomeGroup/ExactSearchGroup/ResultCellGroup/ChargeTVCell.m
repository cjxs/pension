//
//  ChargeTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/4/3.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "ChargeTVCell.h"

@implementation ChargeTVCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle: style  reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UILabel * title_label =[[UILabel alloc]
                                initWithFrame:CGRectMake(8, 0,60, 30)];
        title_label.text = @"收费标准";
        title_label.font = [UIFont systemFontOfSize:14];
        title_label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:title_label];
        for (int i = 0; i < 3; i++)
        {
            UIView * view = [[UIView alloc]
                             initWithFrame:CGRectMake(0, 30+48 *i, screenWide, 24)];
            view.backgroundColor = RGB(249, 250, 251);
            [self addSubview:view];
        }
        NSArray * charge_array = @[@"护理费",@"自理",@"半护",@"全护",@"特护"];
        NSArray * bunk_array = @[@"床位费",@"单人间朝南",@"双人间朝南",@"八人间朝南"];
        NSArray * dining_array = @[@"餐饮费",@"套餐1",@"套餐2",@"套餐3"];
        NSArray * array = @[charge_array,bunk_array,dining_array];
        for (int i = 0; i < array.count; i++)
        {
            for (int j = 0; j < [array[i] count]; j++)
            {
                UILabel * label = [[UILabel alloc]
                                   initWithFrame:CGRectMake(8+screenWide/5 *j,30+48 *i , screenWide/5, 24)];
                label.text = array[i][j];
                label.textColor = RGB(113, 114, 116);
                label.font = [UIFont systemFontOfSize:10];
                label.textAlignment = NSTextAlignmentCenter;
                [self addSubview:label];
            }
        }
        NSArray *  array1 = @[@"800",@"900",@"1000",@"1100"];
        NSArray * array2 = @[@"600",@"400",@"200"];
        NSArray * array3 = @[@"500",@"600",@"700"];
        NSArray * data_array = @[array1,array2,array3];
        for (int i = 0; i < data_array.count; i++)
        {
            for (int j = 0; j < [data_array[i] count] ; j++)
            {
                UILabel * label = [[UILabel alloc]
                                   initWithFrame:CGRectMake(8+screenWide/5 *(j+1),54+48 *i , screenWide/5, 24)];
                label.text = data_array[i][j];
                label.textColor = RGB(156, 157, 158);
                label.font = [UIFont systemFontOfSize:10];
                label.textAlignment = NSTextAlignmentCenter;
                [self addSubview:label];
            }
        }
    }
    return self;
}
-(void)configWithDataDic:(NSDictionary *)dic{
    
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
