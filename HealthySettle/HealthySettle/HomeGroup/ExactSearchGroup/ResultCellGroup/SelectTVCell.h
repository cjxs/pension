//
//  SelectTVCell.h
//  HealthySettle
//
//  Created by yrc on 16/4/2.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UpdatePriceDelegate <NSObject>

-(void)updatePriceWithNumber:(NSInteger )number;
-(void)rememberSelectWithnum1:(NSMutableString *)num1 num2:(NSMutableString *)num2 num3:(NSMutableString *)num3 num4:(NSMutableString *)num4;
@end

@interface SelectTVCell : UITableViewCell
{
    NSMutableArray * type_Arr;
    NSMutableArray * type_2arr;
    NSMutableString * _num_1;
    NSMutableString * _num_2;
    NSMutableString * _num_3;
    NSMutableString * _num_4;
    NSDictionary * _dic;
    NSMutableArray* type_a;
    NSMutableArray* type_b;
    NSMutableArray* type_c;
    
}
@property (nonatomic,strong)UILabel * title_label;
@property (nonatomic,weak) id<UpdatePriceDelegate> delegate;
@property (nonatomic,strong)NSMutableArray * spec_array;
-(void)configWithDic:(NSDictionary *)dic num1:(NSMutableString *)num1 num2:(NSMutableString *)num2 num3:(NSMutableString *)num3 num4:(NSMutableString*)num4;
@end
