//
//  SelectTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/4/2.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "SelectTVCell.h"
@implementation SelectTVCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

-(void)configWithDic:(NSDictionary *)dic{
    type_Arr = [NSMutableArray arrayWithCapacity:0];
    for (NSString * key in dic) {
        [type_Arr addObject:key];
    }
    type_2arr = [NSMutableArray arrayWithCapacity:0];
    for (NSString * str in dic[type_Arr[0]][@"tag"]) {
        [type_2arr addObject:str];
        
    }

       for (int i = 0; i < 4; i++)
    {
        UIView * line_view = [[UIView alloc]
                              initWithFrame:CGRectMake(0, screenHeight * 0.123 *(i+1), screenWide, 1)];
        line_view.backgroundColor = RGB(245, 245, 245);
        [self addSubview:line_view];
        UILabel * label = [[UILabel alloc]
                           initWithFrame:CGRectMake(screenWide * 0.02, screenHeight *0.008 +screenHeight * 0.123 * i, screenWide * 0.18, screenHeight * 0.045)];
        label.adjustsFontSizeToFitWidth = YES;
        if (i==0) {
            label.text = @"护理级别";
        }else{
            label.text = type_2arr[i-1];

        }
        [self addSubview:label];
    }
    [self fundButtonWithArray:type_Arr andHeight:screenHeight * 0.055 Wide:screenWide /(type_Arr.count+2)];
    num_1 = 0;
    _dic = [NSDictionary dictionaryWithDictionary:dic];
    [self addSomeBtnsWithnum:num_1];

}
-(void)fundPriceButtonWithArray:(NSMutableArray *)array
                 andHeight:(CGFloat)height
                      Wide:(CGFloat)wide
{
    if (array) {
        for (int i = 0; i < array.count; i++)
        {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(screenWide * 0.02 + wide * (i * 1.2), height, wide, screenHeight *0.05);
            [btn setTitle:array[i][@"tag_name"]
                 forState:UIControlStateNormal];
            btn.backgroundColor = RGB(244,245, 246);
            [btn setTitleColor:RGB(127, 128, 129)
                      forState:UIControlStateNormal];
            btn.tag = 400 + i;
            btn.titleLabel.font = [UIFont systemFontOfSize:11];
            btn.clipsToBounds = YES;
            btn.layer.cornerRadius = 5;
            [btn addTarget:self
                    action:@selector(selectNurseBtn:)
          forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            if (i == 0)
            {
                [self selectNurseBtn:btn];
            }
        }
        
    }
}
-(void)fundButtonWithArray:(NSMutableArray *)array//添加上就不用动了
                 andHeight:(CGFloat)height
                      Wide:(CGFloat)wide
{
    if (array) {
        for (int i = 0; i < array.count; i++)
        {
            
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(screenWide * 0.02 + wide * (i * 1.2), height, wide, screenHeight *0.05);
            [btn setTitle:array[i]
                 forState:UIControlStateNormal];
            btn.backgroundColor = RGB(244,245, 246);
            [btn setTitleColor:RGB(127, 128, 129)
                      forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:11];
            btn.tag = 300 + i;
            btn.clipsToBounds = YES;
            btn.layer.cornerRadius = 5;
            [btn addTarget:self
                    action:@selector(selectNurseBtn:)
          forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            if (i == 0)
            {
                [self selectNurseBtn:btn];
            }
        }

    }
}
-(void)addSomeBtnsWithnum:(int)num{

    type_a = [NSMutableArray arrayWithCapacity:0];
    NSString * str_a = type_Arr[num];
    NSDictionary * Dic = _dic[str_a][@"tag"];
    for (NSDictionary  * dic in Dic[type_2arr[0]]) {
        [type_a addObject:dic];//护理明细字典数组
    }
    type_b = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary * dic in Dic[type_2arr[1]]) {
        [type_b addObject:dic];//床位选择
        
    }
    type_c = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary * dic  in Dic[type_2arr[2]]) {
        [type_c addObject:dic];//餐饮选择
    }
    [self fundPriceButtonWithArray:type_a andHeight:screenHeight * 0.178 Wide:screenWide /(type_a.count+2)];  //添加护理
    [self fundPriceButtonWithArray:type_b andHeight:screenHeight * 0.301 Wide:screenWide /(type_b.count+2)]; //添加床位
    [self fundPriceButtonWithArray:type_c andHeight:screenHeight * 0.424 Wide:screenWide /(type_c.count+2)]; //添加餐饮

}
-(void)selectNurseBtn:(UIButton *)button
{
    if ( button.currentTitleColor == [UIColor whiteColor]) {
        
    }else{
        for (UIView * view in self.subviews)
        {
            if ([view isKindOfClass:[UIButton class]]
                && view.frame.origin.y == button.frame.origin.y )
            {
                UIButton * btn = (UIButton *)view;
                btn.backgroundColor = RGB(244,245, 246);
                [btn setTitleColor:RGB(127, 128, 129)
                          forState:UIControlStateNormal];
            }
        }
        button.backgroundColor = RGB(229, 12, 24);
        [button setTitleColor:[UIColor whiteColor]
                     forState:UIControlStateNormal];
        if (button.frame.origin.y <50) {
            for (UIView * view in self.subviews)
            {
                if ([view isKindOfClass:[UIButton class]]
                    && view.tag>=400 )
                {
                    UIButton * btn = (UIButton *)view;
                    [btn removeFromSuperview];
                }
            }
            num_1 = button.tag-300;
            [self addSomeBtnsWithnum:num_1];
        }else if (button.frame.origin.y <140){
            num_2 = button.tag - 400;
            
        }else if (button.frame.origin.y <230){
            num_3 = button.tag - 400;
            
        }else if (button.frame.origin.y<320){
            num_4 = button.tag - 400;
        }else{
            
        }
         if (button.frame.origin.y >50) {
            [self totalPrice];
         }
    }
    
}
-(void)totalPrice{
    NSInteger pri_a = [type_a[num_2][@"tag_price"] integerValue];
    NSInteger pri_b = [type_b[num_3][@"tag_price"] integerValue];
    NSInteger pri_c = [type_c[num_4][@"tag_price"] integerValue];
    
    [self.delegate updatePriceWithNumber:pri_a+pri_b+pri_c];

    
}
- (void)awakeFromNib {
    [super awakeFromNib];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
