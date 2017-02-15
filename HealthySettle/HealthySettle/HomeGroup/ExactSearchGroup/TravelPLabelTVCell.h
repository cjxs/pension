//
//  TravelPLabelTVCell.h
//  HealthySettle
//
//  Created by yrc on 17/2/14.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SelectOneView;
@interface TravelPLabelTVCell : UITableViewCell
{
    SelectOneView * man_view,* woman_view;

}
@property (nonatomic,strong)UILabel  * name_label;
@property (nonatomic,strong)UILabel * phone_label;
@property (nonatomic,strong)UILabel * id_label;
@end
