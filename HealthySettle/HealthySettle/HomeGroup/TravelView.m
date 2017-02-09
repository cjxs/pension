//
//  TravelView.m
//  HealthySettle
//
//  Created by yrc on 16/12/29.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "TravelView.h"

@implementation TravelView

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
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(0.072 * wide, 0.146*height, 0.85* wide, 0.143 * height)];
        _title_label.textColor = [UIColor colorWithHexString:@"#191919"];
        _text_label = [[UILabel alloc] initWithFrame:CGRectMake(0.072 * wide, 0.289 * height, 0.85*wide, 0.143 * height)];
        _text_label.textColor = DARKBROWNCOLOR;
        _image_view = [[UIImageView alloc] initWithFrame:CGRectMake(0.106 * wide, 0.432 * height, 0.786 * wide, 0.566 * height)];
        [self addSubview:_title_label];
        [self addSubview:_text_label];
        [self addSubview:_image_view];
        if (IS_IPHONE5EARLY || IS_IPHONE5) {
            _title_label.font = [UIFont systemFontOfSize:16];
            _text_label.adjustsFontSizeToFitWidth = YES;
            
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
