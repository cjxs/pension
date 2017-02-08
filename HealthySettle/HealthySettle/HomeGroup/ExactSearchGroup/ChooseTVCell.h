//
//  ChooseTVCell.h
//  HealthySettle
//
//  Created by yrc on 17/1/5.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PPNumberButton;

@protocol UpdatePriceDelegate <NSObject>

-(void)updatePriceWithNumber:(NSInteger )number;
@end

@interface ChooseTVCell : UITableViewCell{
    UILabel * date_label;
}
@property (nonatomic,strong)PPNumberButton * number_btn;
@property (nonatomic,strong)UILabel * address_label;
@property (nonatomic,weak) id<UpdatePriceDelegate> delegate;
-(void)configWithArray:(NSArray *)arr area_city:(NSString *)area_city;

@end
