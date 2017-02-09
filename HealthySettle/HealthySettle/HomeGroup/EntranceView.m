//
//  EntranceView.m
//  HealthySettle
//
//  Created by yrc on 16/12/29.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "EntranceView.h"

@implementation EntranceView

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
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(0.072 * wide, 0.293*height, 0.490* wide, 0.286 * height)];
        _title_label.textColor = [UIColor colorWithHexString:@"#191919"];
        _text_label = [[UILabel alloc] initWithFrame:CGRectMake(0.072 * wide, 0.579 * height, 0.490*wide, 0.286 * height)];
        _text_label.textColor = DARKBROWNCOLOR;
        _image_view = [[UIImageView alloc] initWithFrame:CGRectMake(0.634 * wide, 0.133 * height, 0.293 * wide, 0.293 * wide)];
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
