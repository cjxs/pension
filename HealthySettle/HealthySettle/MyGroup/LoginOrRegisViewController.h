//
//  LoginOrRegisViewController.h
//  HealthySettle
//
//  Created by yrc on 16/7/18.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UserDataDelegate <NSObject>

-(void)updateUserData;

@end
@interface LoginOrRegisViewController : UIViewController
@property (nonatomic,weak)id<UserDataDelegate> delegate;




@end
