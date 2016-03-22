//
//  SeasonMovingViewCell.m
//  HealthySettle
//
//  Created by yrc on 16/3/21.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "SeasonMovingViewCell.h"
#import "SeasonPageView.h"
#import "SeasonView.h"

#define heights screenHeight/5
@implementation SeasonMovingViewCell {
    NSTimer *_timer;
}
- (UIPageControl *)seaPC {
    if (_seaPC == nil) {
        _seaPC = [[UIPageControl alloc] init];
        _seaPC.numberOfPages = 4;
        _seaPC.currentPageIndicatorTintColor = [UIColor grayColor];
        _seaPC.pageIndicatorTintColor = [UIColor greenColor];
        [_seaPC addTarget:self action:@selector(changeValue) forControlEvents:UIControlEventValueChanged];
    }
    return _seaPC;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.moving_seasonView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWide, heights)];
        [self addSubview:_moving_seasonView];
        _moving_seasonView.contentSize = CGSizeMake(screenWide * 4, heights);
        _moving_seasonView.showsHorizontalScrollIndicator = NO;
        _moving_seasonView.pagingEnabled = YES;
        [self addSubview:self.seaPC];
        [self bringSubviewToFront:_seaPC];
        [_seaPC mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_moving_seasonView);
            make.bottom.equalTo(_moving_seasonView);
            make.size.mas_equalTo(CGSizeMake(screenWide, 7));
            
        }];

        
        _timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];

        self.seasonPO = [[SeasonPageView alloc] initWithFrame:CGRectMake(0, 0, screenWide, heights)];
        self.seasonPT = [[SeasonPageView alloc] initWithFrame:CGRectMake(screenWide, 0, screenWide, heights)];
        self.seasonPTH = [[SeasonPageView alloc] initWithFrame:CGRectMake(screenWide *2, 0, screenWide, heights)];
        self.seasonPF = [[SeasonPageView alloc] initWithFrame:CGRectMake(screenWide * 3, 0, screenWide, heights)];
        [_moving_seasonView addSubview:_seasonPO];
        [_moving_seasonView addSubview:_seasonPT];
        [_moving_seasonView addSubview:_seasonPTH];
        [_moving_seasonView addSubview:_seasonPF];
        [self configContent];
       
        
    }
    return self;
}
-(void)delegateFromController:(UIViewController *)controller {
    _moving_seasonView.delegate = controller;
}


- (void)configContent {
    [_seasonPO.left_View configViewWithimage:[UIImage imageNamed:@"z_02"] season:@"1 月" describ:@"新的开始"];
    [_seasonPO.mid_View configViewWithimage:[UIImage imageNamed:@"z_03"] season:@"2 月" describ:@"春季旅行"];
    [_seasonPO.right_View configViewWithimage:[UIImage imageNamed:@"z_02"] season:@"3 月" describ:@"春节没玩够"];
    [_seasonPT.left_View configViewWithimage:[UIImage imageNamed:@"z_02"] season:@"4 月" describ:@"新的开始"];
    [_seasonPT.mid_View configViewWithimage:[UIImage imageNamed:@"z_02"] season:@"5 月" describ:@"新的开始"];
    [_seasonPTH.left_View configViewWithimage:[UIImage imageNamed:@"z_02"] season:@"6 月" describ:@"新的开始"];
    [_seasonPTH.mid_View configViewWithimage:[UIImage imageNamed:@"z_02"] season:@"7 月" describ:@"新的开始"];
    [_seasonPTH.right_View configViewWithimage:[UIImage imageNamed:@"z_02"] season:@"8月" describ:@"新的开始"];
    [_seasonPT.right_View configViewWithimage:[UIImage imageNamed:@"z_02"] season:@"9 月" describ:@"新的开始"];
    [_seasonPF.left_View configViewWithimage:[UIImage imageNamed:@"z_02"] season:@"10 月" describ:@"新的开始"];
    [_seasonPF.mid_View configViewWithimage:[UIImage imageNamed:@"z_02"] season:@"11月" describ:@"新的开始"];
    [_seasonPF.right_View configViewWithimage:[UIImage imageNamed:@"z_02"] season:@"12月" describ:@"新的开始"];

}

- (void)changeValue {
    CGFloat flo = (_seaPC.currentPage)/1.0;
    CGPoint size = CGPointMake(flo * screenWide, 0);
    [UIView animateWithDuration:1 animations:^{
        _moving_seasonView.contentOffset = size;

    }];
    
}
- (void)changeImage {
    static int i = 0;
    i++;
    _seaPC.currentPage = i;
    
    [self changeValue];
    if (i == 4) {
        i =-1;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _seaPC.currentPage = scrollView.contentOffset.x/screenWide;
}
- (void)removeTimer {
    if (_timer == nil) return;
    [_timer invalidate];
    _timer = nil;
}
-(void)dealloc {
    [self removeTimer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
