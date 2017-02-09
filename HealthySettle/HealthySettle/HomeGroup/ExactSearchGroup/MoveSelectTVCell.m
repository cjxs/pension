//
//  MoveSelectTVCell.m
//  HealthySettle
//
//  Created by yrc on 17/1/6.
//  Copyright © 2017年 yrc. All rights reserved.
//

#import "MoveSelectTVCell.h"

@implementation MoveSelectTVCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView * line_view0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, screenHeight * 0.01499)];
        line_view0.backgroundColor = GRAYCOLOR;
        [self addSubview:line_view0];
        
        self.backgroundColor = WHITECOLOR;

        
        NSArray * array = @[@"产品详情", @"行程介绍", @"费用明细",@"优惠信息",@"预订须知"];
        for (int i = 0; i < array.count; i++)
        {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i *screenWide*0.936 /array.count + screenWide *0.032, screenHeight * 0.015, screenWide*0.936 /array.count, screenHeight * 0.06295);
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            btn.tag = 500 + i;
            [btn setTitle:array[i]
                 forState:UIControlStateNormal];
            [btn addTarget:self
                    action:@selector(changeDataOfbtn:)
          forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            UIView * label = [[UIView alloc]
                              initWithFrame:CGRectMake(i *screenWide*0.936 /array.count + screenWide *0.032, screenHeight * 0.08095-2, screenWide*0.936 /array.count, 1)];
            label.clipsToBounds = YES;
            label.layer.cornerRadius = 3;
            [self addSubview:label];
            if (i == 0)
            {
                [btn setTitleColor:[UIColor redColor]
                          forState:UIControlStateNormal];
                label.backgroundColor = [UIColor redColor];
            }else
            {
                [btn setTitleColor:[UIColor blackColor]
                          forState:UIControlStateNormal];
                label.backgroundColor = [UIColor whiteColor];
            }

        }
            UIView * line_view = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight * 0.08095 -1, screenWide, 1)];
            line_view.backgroundColor = GRAYCOLOR;
            [self addSubview:line_view];
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, screenHeight * 0.08095, screenWide-20, screenHeight * 0.6)];
        [self addSubview:_webView];
        
        

        
        
        
    }
    return self;
}
-(void)configWithStr:(NSString *)str{
    [_webView loadHTMLString:str baseURL:[NSURL URLWithString:BASEURL]];
    _webView.delegate = self;
    _webView.scrollView.bounces = NO;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"var anchors = document.getElementsByTagName('img');for (var i = 0; i < anchors.length; i++) {anchors[i].width=%.0lf;};",screenWide-30]];

}
- (void)changeDataOfbtn:(UIButton *)btn {
    
    if (number_btn != btn.tag - 500) {
        number_btn = btn.tag-500;
        
        [self changeColorForAll];
        [btn setTitleColor:[UIColor redColor]
                  forState:UIControlStateNormal];
        for (UIView *view in self.subviews)
        {
            if (view.frame.size.height == 1&&
                view.frame.origin.x == btn.frame.origin.x)
            {
                view.backgroundColor = [UIColor redColor];
            }
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(updateDataWithWave:)]) {
            [self.delegate updateDataWithWave:number_btn];
        }
        
        
        
    }
}
-(void)changeColorForAll{
    for (int i = 0;i < self.subviews.count;i++) {
        if ([self.subviews[i] isKindOfClass:[UIButton class]]) {
            UIButton * btn = self.subviews[i];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }else{
            UIView * view = self.subviews[i];
            if (view.frame.size.height == 1) {
                view.backgroundColor = WHITECOLOR;
            }
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
