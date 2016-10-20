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

@end

@interface SelectTVCell : UITableViewCell
{
    NSMutableArray * type_Arr;
    NSMutableArray * type_2arr;
    int num_1;
    int num_2;
    int num_3;
    int num_4;
    NSDictionary * _dic;
    NSMutableArray* type_a;
    NSMutableArray* type_b;
    NSMutableArray* type_c;
    
}
@property (nonatomic,strong)UILabel * title_label;
@property (nonatomic,weak) id<UpdatePriceDelegate> delegate;
-(void)configWithDic:(NSDictionary *)dic;

@end
