//
//  SearchOrganTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/4/5.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "SearchOrganTVCell.h"


@implementation SearchOrganTVCell
-(UILabel *)name_la {
    if (!_name_la) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, screenHeight * 0.15-20, screenWide-40, 40)];
        label.font = [UIFont systemFontOfSize:30];
        label.textAlignment = NSTextAlignmentCenter;
        label.adjustsFontSizeToFitWidth = YES;
        label.textColor = [UIColor whiteColor];
        _name_la = label;
        }
    return _name_la;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide , screenHeight * 0.3057)];
        
        [self addSubview:view];
        self.organ_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.032* screenWide, -screenHeight *0.025, screenWide* 0.936, screenHeight * 0.3557)];
        _organ_imageView.backgroundColor = [UIColor redColor];
        view.clipsToBounds = YES;
        [view addSubview:self.organ_imageView];
        [view addSubview:self.name_la];
        
        
        
    }
    return self;
}
-(void)configWithImage:(NSString *)str title:(NSString *)title
{
    if (str)
    {
        [self.organ_imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"banner_p"]];
    }
    if (title) {
        self.name_la.text =  title;
    }
}
- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view {
    CGRect rectInSuperview = [tableView convertRect:self.frame toView:view];
    
    float distanceFromCenter = CGRectGetHeight(view.frame)/2 - CGRectGetMinY(rectInSuperview);
    float difference = CGRectGetHeight(self.organ_imageView.frame) - CGRectGetHeight(self.frame);
    float move = (distanceFromCenter / CGRectGetHeight(view.frame)) * difference;
    
    CGRect imageRect = self.organ_imageView.frame;
    imageRect.origin.y = -(difference/1.2)+move;
    self.organ_imageView.frame = imageRect;
}

@end
