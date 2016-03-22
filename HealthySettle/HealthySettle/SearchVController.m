//
//  SearchVController.m
//  HealthySettle
//
//  Created by yrc on 16/3/22.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "SearchVController.h"

@interface SearchVController ()

@end

@implementation SearchVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBottomPicWithPic:[UIImage imageNamed:@"z_03"] andTitle:@"找。养老院"];

}
- (void)setBottomPicWithPic:(UIImage *)imageP andTitle:(NSString *)string {
    self.view.backgroundColor = [UIColor whiteColor];
    [UIApplication sharedApplication].statusBarHidden = YES;
    self.navigationController.navigationBarHidden = YES;
    UIImageView * topImageV =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,screenWide , screenHeight / 4)];
    topImageV.image = imageP;
    topImageV.alpha = 0.85;
    [self.view addSubview:topImageV];
    
    UILabel * textLabel = [[UILabel alloc] initWithFrame:CGRectMake((screenWide - 200)/2, 20, 200, 40)];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont systemFontOfSize:18];
    textLabel.text = string;
    textLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:textLabel];
    
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
