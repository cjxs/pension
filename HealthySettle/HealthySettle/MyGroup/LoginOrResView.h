//
//  LoginOrResView.h
//  HealthySettle
//
//  Created by yrc on 16/4/12.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginOrResView : UIView {
    UIView * bg_view;
}
@property (nonatomic,assign)NSInteger view_type;
@property (nonatomic,strong)UITextField * number_field,* passWord_field,*test_field;
@property (nonatomic,strong)UIButton * reSetpass_btn,*getTest_btn;
@property (nonatomic,strong)UIButton * regis_btn, *login_btn;
-(void)addSelfSubView;

@end
