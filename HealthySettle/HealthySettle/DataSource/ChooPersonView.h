//
//  ChooPersonView.h
//  HealthySettle
//
//  Created by yrc on 17/2/20.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYLUser;

@interface ChooPersonView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSArray * data_arr;
@property (nonatomic,strong)UITableView * select_view;
@property (nonatomic,copy) void(^selected)(YYLUser * user);
- (void)addFirstView;
@end
