//
//  PersonDataVController.h
//  HealthySettle
//
//  Created by yrc on 16/3/30.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ExitLoginDelegate <NSObject>

-(void)exitLogin;

@end
@interface PersonDataVController : UIViewController
@property (nonatomic, strong) NSString    * titleName;
@property (nonatomic,strong ) UITableView * tableView;
@property (nonatomic, strong) NSString    * type_next;
@property (nonatomic,weak) id<ExitLoginDelegate> delegate;
@end

