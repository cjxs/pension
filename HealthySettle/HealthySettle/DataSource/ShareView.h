//
//  ShareView.h
//  HealthySettle
//
//  Created by yrc on 16/4/18.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ShareView : UIView
@property (nonatomic,strong) UIView           * white_view;
@property (nonatomic,strong) UIView           * backgroundView;
@property (nonatomic, weak ) UIViewController *sourceViewController;
@property (nonatomic,strong) NSMutableArray   * some_btns;
+ (ShareView *)showShareViewInViewController:(UIViewController *)viewController;

@end
