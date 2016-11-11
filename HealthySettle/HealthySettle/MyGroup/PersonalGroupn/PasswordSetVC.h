//
//  PasswordSetVC.h
//  HealthySettle
//
//  Created by yrc on 16/11/10.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PaySetDelegate <NSObject>

-(void)updateView;

@end
@interface PasswordSetVC : UIViewController
@property (strong, nonatomic  )  UITextField *fresh_passInput;
@property (strong, nonatomic  )  UITextField *refresh_passInput;
@property (weak, nonatomic  )    UIButton    *changePass_btn;
@property (nonatomic,weak)id <PaySetDelegate>  delegate;
@end

