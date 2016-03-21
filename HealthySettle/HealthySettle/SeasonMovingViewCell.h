//
//  SeasonMovingViewCell.h
//  HealthySettle
//
//  Created by yrc on 16/3/21.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SeasonPageView;
@interface SeasonMovingViewCell : UITableViewCell
@property (nonatomic, strong)SeasonPageView * seasonPO,*seasonPT,*seasonPTH,*seasonPF;
@property (nonatomic, strong)UIScrollView * moving_seasonView;
@property (nonatomic, strong)UIPageControl * seaPC;
-(void)delegateFromController:(UIViewController *)controller;
@end
