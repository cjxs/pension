//
//  CustomerViewController.m
//  HealthySettle
//
//  Created by yrc on 16/3/17.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "CustomerViewController.h"
#import "HYMDatePicker.h"
@interface CustomerViewController ()<HYMDatePickerDelegate>
@property (strong, nonatomic) HYMDatePicker *datePicker;
@property (strong, nonatomic) UILabel *timeLabel;
@end

@implementation CustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.datePicker = [[HYMDatePicker alloc] init];
//    self.datePicker.delegateDiy = self;
//    self.datePicker.frame = CGRectMake(0, 300, self.view.frame.size.width, self.view.frame.size.height*0.5);
//    [self.view addSubview:self.datePicker];
//    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
//    self.timeLabel.center = CGPointMake(self.view.center.x, self.view.center.y*1.25);
//    self.timeLabel.textColor = [UIColor redColor];
//    self.timeLabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:self.timeLabel];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 200);
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(pickViewAppear) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)pickViewAppear {
    HYMDatePicker * datePicker = [[HYMDatePicker alloc] init];
    datePicker.frame = CGRectMake(0, 300, self.view.frame.size.width, self.view.frame.size.height*0.5);
//    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_fivthView.mas_bottom);
//        make.bottom.equalTo(self.view.mas_bottom);
//        make.leading.equalTo(_fivthView.mas_leading);
//        make.width.equalTo (@(screenWide));
//    }];
    datePicker.delegateDiy = self;
    [self.view addSubview:datePicker];
    [self.view bringSubviewToFront:datePicker];
}

- (void)currentSelectedDate:(NSDate *)a{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSLog(@"选中的时间 %@",[formatter stringFromDate:a]);
    self.timeLabel.text = [formatter stringFromDate:a];
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
