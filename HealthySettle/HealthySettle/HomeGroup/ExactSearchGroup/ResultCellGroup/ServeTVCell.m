//
//  ServeTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/4/3.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "ServeTVCell.h"

@implementation ServeTVCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
{
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIView * margin_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, 13)];
        margin_view.backgroundColor =  RGB(242, 242, 242);
        [self addSubview:margin_view];
        UIView * view = [[UIView alloc]
                         initWithFrame:CGRectMake(screenWide /2, 16, 1, 25)];
        view.backgroundColor = RGB(250, 251, 252);
        [self addSubview:view];
        NSArray * array =@[@"通用服务",@"收费服务"];
        UIView * line_view =[[UIView alloc]
                             initWithFrame:CGRectMake(0, 42, screenWide, 1)];
        line_view.backgroundColor = RGB(250, 251, 252);
        [self addSubview:line_view];
        for (int i = 0; i < 2; i++)
        {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(screenWide /2 *i, 13, screenWide/2, 29);
            [btn setTitle:array[i]
                 forState:UIControlStateNormal];
            if (i == 0)
            {
                [btn setTitleColor:[UIColor blackColor]
                          forState:UIControlStateNormal];
            }else
            {
                [btn setTitleColor:RGB(196, 196, 196)
                          forState:UIControlStateNormal];
            }
            [btn addTarget:self
                    action:@selector(showSelectViewWithbtn:)
          forControlEvents:UIControlEventTouchUpInside];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [self addSubview:btn];
            
        }
           }
    return self;
}
-(void)configwithCommon:(NSString *)common charge:(NSString *)charge{
    if (common) {
        self.common_t = common;
    }
    if (charge) {
        self.charge_t = charge;
    }
    [self showCommonServe];
}
-(void)showSelectViewWithbtn:(UIButton *)btn
{
    for (UIButton * button in self.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]
            && button.frame.origin.x != btn.frame.origin.x )
        {
            button.enabled = YES;
            [button setTitleColor:RGB(196, 196, 196)
                         forState:UIControlStateNormal];
        }
    }
    btn.enabled = NO;
    [btn setTitleColor:[UIColor blackColor]
              forState:UIControlStateNormal];
    if (btn.frame.origin.x == 0)
    {
        [self showCommonServe];
    }else
    {
        [self showTollServe];
    }
}
-(void)showCommonServe
{
    if (_tollServe_view)
    {

        [_tollServe_view removeFromSuperview];
        _tollServe_view = nil;
    }
    if (!_commonServe_view) {
        _commonServe_view = [[UIWebView alloc]
                             initWithFrame:CGRectMake(15, 43, screenWide-30, self.frame.size.height-80)];
        isLoadingFinished = NO;
        [_commonServe_view setScalesPageToFit:NO];

        [_commonServe_view loadHTMLString:self.common_t baseURL:nil];
        [_commonServe_view setHidden:YES];
        _commonServe_view.delegate = self;


    }
        [self addSubview:_commonServe_view];
}
- (void)showTollServe
{
    if (_commonServe_view)
    {
        [_commonServe_view removeFromSuperview];
        _commonServe_view = nil;
       
    }
    if (!_tollServe_view) {
        _tollServe_view = [[UIWebView alloc]
                           initWithFrame:CGRectMake(15, 43, screenWide-30 , self.frame.size.height-80)];
        [_tollServe_view loadHTMLString:self.charge_t baseURL:nil];
    }
   
    [self addSubview:_tollServe_view];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //若已经加载完成，则显示webView并return
    if(isLoadingFinished)
    {
        [webView setHidden:NO];
        return;
    }
    
    //js获取body宽度
    NSString *bodyWidth= [webView stringByEvaluatingJavaScriptFromString: @"document.body.scrollWidth "];
    
    int widthOfBody = [bodyWidth intValue];
    
    //获取实际要显示的html
    
    NSString *html;
    html = webView == _commonServe_view? [self htmlAdjustWithPageWidth:widthOfBody
                                                                  html:_common_t
                                                               webView:webView]:[self htmlAdjustWithPageWidth:widthOfBody
                                                                                                         html:_charge_t
                                                                                                      webView:webView];
    
    //设置为已经加载完成
    isLoadingFinished = YES;
    //加载实际要现实的html
    [webView loadHTMLString:html baseURL:nil];
}

//获取宽度已经适配于webView的html。这里的原始html也可以通过js从webView里获取
- (NSString *)htmlAdjustWithPageWidth:(CGFloat )pageWidth
                                 html:(NSString *)html
                              webView:(UIWebView *)webView
{
    NSMutableString *str = [NSMutableString stringWithString:html];
    //计算要缩放的比例
    CGFloat initialScale = webView.frame.size.width/pageWidth;
    //将</head>替换为meta+head
    NSString *stringForReplace = [NSString stringWithFormat:@"<meta name=\"viewport\" content=\" initial-scale=%f, minimum-scale=0.1, maximum-scale=2.0, user-scalable=yes\"></head>",initialScale];
    
    NSRange range =  NSMakeRange(0, str.length);
    //替换
    [str replaceOccurrencesOfString:@"</head>" withString:stringForReplace options:NSLiteralSearch range:range];
    return str;
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
