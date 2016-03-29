//
//  TipGestureView.m
//  ShellMoney
//
//  Created by beike on 3/25/15.
//  Copyright (c) 2015 beik. All rights reserved.
//

#import "ProductTipView.h"

@implementation ProductTipView

- (instancetype)init{
    self = [super init];
    if (self) {
        UIImageView *tipImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_product_tip"]];
        tipImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
        [self addSubview:tipImageView];
        [tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.leading.equalTo(@30);
        }];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tap];
        [self addGestureRecognizer:pan];
        [[[tap.rac_gestureSignal merge:pan.rac_gestureSignal] take:1] subscribeNext:^(id x) {
            [UIView animateWithDuration:0.3f animations:^{
                self.alpha = 0.0f;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }];
    }
    return self;
}

@end
