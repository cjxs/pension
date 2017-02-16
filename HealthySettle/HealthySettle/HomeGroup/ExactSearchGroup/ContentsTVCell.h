//
//  ContentsTVCell.h
//  HealthySettle
//
//  Created by yrc on 17/2/10.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentsTVCell : UITableViewCell
@property (nonatomic,strong)UITextField * name_field;
@property (nonatomic,strong)UITextField * phone_field;
@property (nonatomic,strong)UIButton * add_person_btn;
-(void)configWithname:(NSString *)name phone:(NSString *)phone;
@end
