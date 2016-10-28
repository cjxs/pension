//
//  TabbarController.m
//  HealthySettle
//
//  Created by yrc on 16/3/17.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "TabbarController.h"
#import "HomeViewController.h"
#import "CustomerViewController.h"
#import "SearchTVController.h"
#import "MineViewController.h"
#import "LoginOrRegisViewController.h"
@interface TabbarController ()

@end

@implementation TabbarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    UINavigationController * homeNaVC =[[UINavigationController alloc]
                                        initWithRootViewController:homeVC];
    homeNaVC.tabBarItem.title = @"首页";
    homeNaVC.tabBarItem.image = [UIImage imageNamed:@"home_g"];
    
    SearchTVController * searchVC = [[SearchTVController alloc] init];
    UINavigationController *searchNaVC = [[UINavigationController alloc]
                                          initWithRootViewController:searchVC];
    searchNaVC.tabBarItem.title = @"发现";
    searchNaVC.tabBarItem.image = [UIImage imageNamed:@"found_g"];
    
    CustomerViewController * customerVC = [[CustomerViewController alloc] init];
    UINavigationController *customerNaVC = [[UINavigationController alloc]
                                            initWithRootViewController:customerVC];
    customerNaVC.tabBarItem.title = @"客服";
    customerNaVC.tabBarItem.image = [UIImage imageNamed:@"call_g"];
    
    MineViewController * mineVC = [[MineViewController alloc] init];
    UINavigationController * mineNaVC = [[UINavigationController alloc]
                                         initWithRootViewController:mineVC];
    mineNaVC.tabBarItem.title = @"我的";
    mineNaVC.tabBarItem.image = [UIImage imageNamed:@"my_g"];
    
    
    
    CGRect frame = CGRectMake(0, 0, screenWide, 48);
    
     UIView *v = [[UIView alloc]initWithFrame:frame];
    
     [v setBackgroundColor:RGB(255, 255, 255)];
    
    [self.tabBar insertSubview:v atIndex:0];
    self.tabBar.tintColor = RGB(229, 0, 0);
    
    
     
    self.viewControllers = @[homeNaVC, searchNaVC,customerNaVC, mineNaVC];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
