//
//  NewsView.m
//  HealthySettle
//
//  Created by yrc on 16/12/29.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "NewsView.h"

@implementation NewsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WHITECOLOR;
        CGFloat wide = frame.size.width;
        CGFloat height = frame.size.height;
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(0.072 * wide, 0.11*height, 0.549* wide, 0.39 * height)];
             _title_label.textColor = [UIColor colorWithHexString:@"#191919"];
        _text_label = [[UILabel alloc] initWithFrame:CGRectMake(0.072 * wide, 0.5 * height, 0.549*wide, 0.39 * height)];
        _text_label.textColor = DARKBROWNCOLOR;
        _image_view = [[UIImageView alloc] initWithFrame:CGRectMake(0.693 * wide, 0.1 * height, 0.234 * wide, 0.234 * wide)];
        [self addSubview:_title_label];
        [self addSubview:_text_label];
        [self addSubview:_image_view];
        if (IS_IPHONE6EARLY) {
            _title_label.font = [UIFont systemFontOfSize:16];
            _text_label.font = [UIFont systemFontOfSize:9];
            
        }else if(IS_IPHONE6){
            _title_label.font = [UIFont systemFontOfSize:16];
            _text_label.font = [UIFont systemFontOfSize:11];
            
        }else{
            _title_label.font = [UIFont systemFontOfSize:18];
            _text_label.font = [UIFont systemFontOfSize:12];
            
        }

    }
    return self;
}
-(void)configWithtitle:(NSString *)title text:(NSString *)text imageName:(NSString *)imageName gesture:(UITapGestureRecognizer *)gesture{
    _title_label.text = title;
    _text_label.text = text;
    _image_view.image = [UIImage imageNamed:imageName];
    if (gesture) {
        [self addGestureRecognizer:gesture];
    }
}

@end
