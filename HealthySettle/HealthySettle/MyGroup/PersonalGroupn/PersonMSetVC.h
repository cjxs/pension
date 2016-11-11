//
//  PersonMSetVC.h
//  HealthySettle
//
//  Created by yrc on 16/11/10.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PersonMSDelegate <NSObject>

-(void)updateView;

@end
@interface PersonMSetVC : UIViewController
@property (strong, nonatomic  )  UITextField *text_Input;
@property (weak, nonatomic  )    UIButton    *change_btn;
@property (strong,nonatomic)NSString * vc_type;
@property (nonatomic,weak)id <PersonMSDelegate>  delegate;

@end
