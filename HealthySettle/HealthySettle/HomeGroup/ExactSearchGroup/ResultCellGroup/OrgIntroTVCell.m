//
//  OrgIntroTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/4/3.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "OrgIntroTVCell.h"

@implementation OrgIntroTVCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    UIView * margin_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, 13)];
    margin_view.backgroundColor =  RGB(242, 242, 242);
    [self addSubview:margin_view];
    // Initialization code
    for (int i = 0; i < 6; i++)
    {
        UIView * view = [[UIView alloc]
                         initWithFrame:CGRectMake(0, 56 + 26*i, screenWide, 0.5)];
        view.backgroundColor = RGB(228, 229, 230);
        [self addSubview:view];
    }
    
}
- (void)configWithtelephone:(NSString *)phone bed_nums:(NSString *)bed_nums spec:(NSString *)spec special_s:(NSString *)special_s intro:(NSString *)intro{
    if (phone) {
        self.telephone.text = phone;
    }
    if (bed_nums) {
        self.bed_nums.text = bed_nums;
    }
    if (spec) {
        self.spec.text = spec;
    }
    if ([special_s isEqualToString:@"1"]) {
        self.special_service.text = @"可接受异地老人";
    }else if ([special_s isEqualToString:@"2"]){
        self.special_service.text = @"可享受医保定点服务";
    }else if ([special_s isEqualToString:@"1,2"]||[special_s isEqualToString:@"2,1"]){
        self.special_service.text = @"可接受异地老人，享受医保定点服务";
    }else{
        
    }
    if (intro) {
        self.intro.text = intro;
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
