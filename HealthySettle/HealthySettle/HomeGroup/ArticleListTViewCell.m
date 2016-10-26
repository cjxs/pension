//
//  ArticleListTViewCell.m
//  HealthySettle
//
//  Created by yrc on 16/10/26.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "ArticleListTViewCell.h"

@implementation ArticleListTViewCell
-(UILabel *)title_label {
    if (!_title_label) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, screenWide-40, 22)];
        if (IS_IPHONE5) {
            label.font = [UIFont systemFontOfSize:16];
        }else{
            label.font = [UIFont systemFontOfSize:18];
        }
        label.textColor = RGB(21, 21, 21);
        label.textAlignment = NSTextAlignmentLeft;
        _title_label = label;
    }
    return _title_label;
}
- (UILabel *)time_label {
    if (!_time_label) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 34, 80, 18)];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = RGB(222, 222, 222);

        _time_label = label;
    }
    return _time_label;
}
-(UILabel *)reads_label {
    if (!_reads_label) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(130, 34, 60, 18)];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = RGB(212, 212, 212);
        _reads_label = label;
    }
    return _reads_label;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self addSubview:self.title_label];
        [self addSubview:self.time_label];
        [self addSubview:self.reads_label];
        self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0.5, screenWide, 0.5)];
        self.view.backgroundColor = RGB(212, 212, 212);
        [self addSubview:self.view];
       
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)configWithDic:(NSDictionary *)dic{
    self.title_label.text = dic[@"title"];
    self.time_label.text = dic[@"date"];
    self.reads_label.text = dic[@"viewNum"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
