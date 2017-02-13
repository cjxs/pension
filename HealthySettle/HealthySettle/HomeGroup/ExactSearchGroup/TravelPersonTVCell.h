//
//  TravelPersonTVCell.h
//  HealthySettle
//
//  Created by yrc on 17/2/10.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SelectOneView;

@interface TravelPersonTVCell : UITableViewCell{
    int man;
    SelectOneView * man_view,* woman_view;
}
@property (nonatomic,strong)UITextField * name_field;
@property (nonatomic,strong)UITextField * phone_field;
@property (nonatomic,strong)UITextField * id_field;
@property (nonatomic,strong)UIButton * add_person_btn;
@end
