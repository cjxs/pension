//
//  PriSeleView.m
//  HealthySettle
//
//  Created by yrc on 16/4/9.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "PriSeleView.h"
#import "NMRangeSlider.h"

@implementation PriSeleView
-(instancetype)init {
    self =[super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        UIView * view =[[UIView alloc]initWithFrame:self.bounds];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        tap.numberOfTapsRequired = 1;
        [view addGestureRecognizer:tap];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.5;
        [self addSubview:view];
        priSele_view = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight , screenWide, 0.35 * screenHeight)];
        priSele_view.backgroundColor = RGB(248, 248, 248);
        [self addSubview:priSele_view];
        UILabel * title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight * 0.066)];
        title_label.text = @"价格区间";
        title_label.font = [UIFont systemFontOfSize:14];
        title_label.textAlignment = NSTextAlignmentCenter;
        [priSele_view addSubview:title_label];
        
        UILabel * line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, screenHeight * 0.067, screenWide, screenHeight * 0.001)];
        line1.backgroundColor = RGB(240, 240, 240);
        [priSele_view addSubview:line1];
        
        UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.05, screenHeight * 0.07, 60, screenHeight * 0.05)];
        title.text = @"价格";
        title.font = [UIFont systemFontOfSize:13];
        [priSele_view addSubview:title];
        
        NMRangeSlider * pri_slider = [[NMRangeSlider alloc] initWithFrame:CGRectMake(screenWide * 0.05, screenHeight * 0.15, screenWide * 0.9, 5)];
        pri_slider.minimumRange = 0.25;
        pri_slider.minimumValue = 0.0;
        pri_slider.maximumValue = 1.0;
        pri_slider.stepValue = 0.25;

        pri_slider.lowerHandleImageNormal = [UIImage imageNamed:@"choose_"];
        pri_slider.upperHandleImageNormal = [UIImage imageNamed:@"choose_"];
        NSArray * array = @[@"¥ 0",@"¥ 2000",@"¥ 3000",@"¥ 5000",@"不限"];
        [priSele_view addSubview:pri_slider];
        for (int i = 0; i < 5; i++) {
            UILabel * labelP = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.85/4 * i + screenWide * 0.062, screenHeight * 0.185, 10, 20)];
            labelP.text =@"•";
            labelP.font = [UIFont systemFontOfSize:18];
            [priSele_view addSubview:labelP];
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(screenWide * 0.85/4 * i - screenWide * 0.031, screenHeight * 0.21, screenWide /5, screenHeight * 0.05)];
            label.text = array[i];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:10];
            [priSele_view addSubview:label];
            
        }
        UILabel * lin2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(priSele_view.frame) - screenHeight * 0.069, screenWide, screenHeight * 0.002)];
        lin2.backgroundColor = RGB(249, 177, 178);
        [priSele_view addSubview:lin2];
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, CGRectGetHeight(priSele_view.frame)  - screenHeight * 0.067 , screenWide, screenHeight * 0.067);
        [btn setTitleColor:RGB(223, 11, 23) forState:UIControlStateNormal];
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        btn.backgroundColor = RGB(254, 254, 254);
        [btn addTarget:self action:@selector(tryanslog) forControlEvents:UIControlEventTouchUpInside];
        [priSele_view addSubview:btn];
        self.firm_btn = btn;
        [UIView animateWithDuration:0.3f animations:^{
            priSele_view.frame = CGRectMake(0, screenHeight * 0.65 , screenWide, 0.35 * screenHeight);
        }];
    }
    return self;
}
- (void)tryanslog {
}

-(void)dismiss {
    [UIView animateWithDuration:0.3f animations:^{
       priSele_view.frame = CGRectMake(0, screenHeight , screenWide, 0.35 * screenHeight);
    }];
  [self performSelector:@selector(remove) withObject:nil afterDelay:0.3f];
  
}
- (void)remove {
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    
    [self removeFromSuperview];
}
   /* default 0.0
@property(assign, nonatomic) float minimumValue;

// default 1.0
@property(assign, nonatomic) float maximumValue;

// default 0.0. This is the minimum distance between between the upper and lower values
@property(assign, nonatomic) float minimumRange;

// default 0.0 (disabled)
@property(assign, nonatomic) float stepValue;

// If NO the slider will move freely with the tounch. When the touch ends, the value will snap to the nearest step value
// If YES the slider will stay in its current position until it reaches a new step value.
// default NO
@property(assign, nonatomic) BOOL stepValueContinuously;

// defafult YES, indicating whether changes in the sliders value generate continuous update events.
@property(assign, nonatomic) BOOL continuous;

// default 0.0. this value will be pinned to min/max
@property(assign, nonatomic) float lowerValue;

// default 1.0. this value will be pinned to min/max
@property(assign, nonatomic) float upperValue;

// center location for the lower handle control
@property(readonly, nonatomic) CGPoint lowerCenter;

// center location for the upper handle control
@property(readonly, nonatomic) CGPoint upperCenter;


// Images, these should be set before the control is displayed.
// If they are not set, then the default images are used.
// eg viewDidLoad


//Probably should add support for all control states... Anyone?

@property(retain, nonatomic) UIImage* lowerHandleImageNormal;
@property(retain, nonatomic) UIImage* lowerHandleImageHighlighted;

@property(retain, nonatomic) UIImage* upperHandleImageNormal;
@property(retain, nonatomic) UIImage* upperHandleImageHighlighted;

@property(retain, nonatomic) UIImage* trackImage;

@property(retain, nonatomic) UIImage* trackBackgroundImage;


//Setting the lower/upper values with an animation :-)
- (void)setLowerValue:(float)lowerValue animated:(BOOL) animated;

- (void)setUpperValue:(float)upperValue animated:(BOOL) animated;

- (void) setLowerValue:(float) lowerValue upperValue:(float) upperValue animated:(BOOL)animated;
*／


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
