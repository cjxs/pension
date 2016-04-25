//
//  GuideController.m
//  HealthySettle
//
//  Created by yrc on 16/4/6.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "GuideVController.h"

@interface GuideVController ()

@end

@implementation GuideVController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)initGuideWithArray:(NSArray *)array {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight)];
    [scrollView setContentSize:CGSizeMake(screenWide * array.count, 0)];
    [scrollView setPagingEnabled:YES];
    [scrollView setBounces:NO];
    for (int i = 0; i < array.count; i++) {
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(screenWide *i, 0, screenWide, screenHeight)];
        [imageview setImage:[UIImage imageNamed:array[i]]];
        if (i == array.count - 1) {
            imageview.userInteractionEnabled = YES;
            UIButton * btn = [UIButton buttonWithType: UIButtonTypeCustom];
            btn.frame = CGRectMake(screenWide * 0.392, screenHeight * 0.843, screenWide * 0.216, screenHeight * 0.036);
            [btn setBackgroundImage:[UIImage imageNamed:@"Guide_btn"] forState:UIControlStateNormal];
            [imageview addSubview:btn];
            _enter_btn = btn;
        }
        [scrollView addSubview:imageview];
    }
    
    [self.view addSubview:scrollView];
  
}
- (void)didReceiveMemoryWarning {
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
