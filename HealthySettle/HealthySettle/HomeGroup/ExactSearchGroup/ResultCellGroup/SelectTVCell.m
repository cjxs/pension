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
    UIView * margin_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, 13)];
    margin_view.backgroundColor =  RGB(242, 242, 242);
    [self addSubview:margin_view];
    return self;
}

-(void)configWithDic:(NSDictionary *)dic num1:(NSMutableString *)num1 num2:(NSMutableString *)num2 num3:(NSMutableString *)num3 num4:(NSMutableString*)num4{
    _num_1 = num1;
    _num_2 = num2;
    _num_3 = num3;
    _num_4 = num4;
    _dic = [NSDictionary dictionaryWithDictionary:dic];
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
                              initWithFrame:CGRectMake(0, screenHeight * 0.02+screenHeight * 0.123 *(i+1), screenWide, 1)];
        line_view.backgroundColor = RGB(245, 245, 245);
        [self addSubview:line_view];
        UILabel * label = [[UILabel alloc]
                           initWithFrame:CGRectMake(screenWide * 0.02, screenHeight *0.028 +screenHeight * 0.123 * i, screenWide * 0.18, screenHeight * 0.045)];
        label.adjustsFontSizeToFitWidth = YES;
        switch (i) {
            case 0:
                label.text = @"护理级别";
                break;
            case 1:
                label.text = @"护理明细";
                break;
            case 2:
                label.text = @"床位选择";
                break;
            default:
                label.text = @"餐饮选择";
                break;
        }
        [self addSubview:label];
    }
    [self fundButtonWithArray:type_Arr andHeight:screenHeight * 0.075 Wide:screenWide /(type_Arr.count+2)];

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
                    action:@selector(selectFirstNurseBtn:)
          forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            if ([_num_1 intValue]== i)
            {
                [self selectFirstNurseBtn:btn];
            }
        }
        
    }
}
-(void)selectFirstNurseBtn:(UIButton *)button
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
        for (UIView * view in self.subviews)
        {
            if ([view isKindOfClass:[UIButton class]]
                && view.tag>=400 )
            {
                UIButton * btn = (UIButton *)view;
                [btn removeFromSuperview];
            }
        }
        _num_1 =  [NSMutableString stringWithFormat:@"%ld",button.tag-300];
        [self addSomeBtnsWithnum:_num_1];
        [self totalPrice];
    }
}

-(void)addSomeBtnsWithnum:(NSMutableString *)num{
    
    NSString * str_a = type_Arr[[num intValue]];
    NSDictionary * Dic = _dic[str_a][@"tag"];
    
    type_b = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary * dic in Dic[type_2arr[1]]) {
        [type_b addObject:dic];//护理明细字典数
    }
    type_c = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary * dic  in Dic[type_2arr[2]]) {
        [type_c addObject:dic];//床位选择
    }
    type_a = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary  * dic in Dic[type_2arr[0]]) {
        [type_a addObject:dic];//组餐饮选择
    }
    if (_num_2.intValue > (type_b.count - 1)) {
        _num_2 = [NSMutableString stringWithFormat:@"0"];
    }
    if (_num_3.intValue > type_c.count -1) {
        _num_3 = [NSMutableString stringWithFormat:@"0"];
    }
    if (_num_4.intValue > type_a.count -1) {
        _num_4 = [NSMutableString stringWithFormat:@"0"];
    }
    [self fundPriceButtonWithArray:type_b andHeight:screenHeight * 0.198 Wide:screenWide /(type_b.count+2) title:@"hu"]; //添加护理  2
    [self fundPriceButtonWithArray:type_c andHeight:screenHeight * 0.321 Wide:screenWide /(type_c.count+2) title:@"chuang"]; //添加住宿   6
    [self fundPriceButtonWithArray:type_a andHeight:screenHeight * 0.444 Wide:screenWide /(type_a.count+2) title:@"ying"];  //添加饮食  4
}
-(void)fundPriceButtonWithArray:(NSMutableArray *)array
                 andHeight:(CGFloat)height
                      Wide:(CGFloat)wide title:(NSString *)title
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
            switch ([title length]) {
                case 2:
                    if (i == [_num_2 intValue]){
                        [self selectNurseBtn:btn];
                    }
                    break;
                case 6:
                    if (i == [_num_3 intValue]){
                        [self selectNurseBtn:btn];
                    }
                    break;
                case 4:
                    if (i == [_num_4 intValue]){
                        [self selectNurseBtn:btn];
                    }
                    break;
                default:
                    break;
            }
        }
        
    }
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
        if (button.frame.origin.y < 63) {
            
        }else if (button.frame.origin.y <153){
            _num_2 =  [NSMutableString stringWithFormat:@"%ld",button.tag-400];
            
        }else if (button.frame.origin.y <243){
            _num_3 = [NSMutableString stringWithFormat:@"%ld",button.tag-400];
            
        }else if (button.frame.origin.y<333){
            _num_4 = [NSMutableString stringWithFormat:@"%ld",button.tag-400];
        }else{
            
        }
             [self totalPrice];
    }
    
}
-(void)totalPrice{
    NSInteger pri_b = 0;
    NSInteger pri_c = 0;
    NSInteger pri_a = 0;
    
    if (type_b && type_c && type_a) {
        pri_b =  _num_3.intValue > type_c.count-1 ? [type_c[0][@"tag_price"] integerValue]:[type_c[[_num_3 intValue]][@"tag_price"] integerValue];
        pri_c = _num_4.intValue > type_a.count-1 ?[type_a[0][@"tag_price"] integerValue]:[type_a[[_num_4 intValue]][@"tag_price"] integerValue];
        pri_a = [_num_2 intValue] > [type_b count]-1? [type_b[0][@"tag_price"] integerValue]:[type_b[[_num_2 intValue]][@"tag_price"] integerValue];
        [self.delegate updatePriceWithNumber:pri_a+pri_b+pri_c];
        self.spec_array = [NSMutableArray arrayWithArray:@[type_Arr[_num_1.intValue],type_b[_num_2.intValue][@"tag_name"],type_c[_num_3.intValue][@"tag_name"],type_a[_num_4.intValue][@"tag_name"]]];
        [self.delegate rememberSelectWithnum1:_num_1 num2:_num_2 num3:_num_3 num4:_num_4 arr:self.spec_array];

    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
