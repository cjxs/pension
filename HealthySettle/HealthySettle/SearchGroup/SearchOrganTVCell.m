//
//  SearchOrganTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/4/5.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "SearchOrganTVCell.h"

@implementation SearchOrganTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, screenHeight * 0.33)];
        view.clipsToBounds = YES;
        
        [self addSubview:view];
        self.organ_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -screenHeight *0.025, 375, screenHeight * 0.38)];
        [view addSubview:self.organ_imageView];
        
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        label.font = [UIFont systemFontOfSize:30];
        label.textColor = [UIColor whiteColor];
        label.text = @"我的家乡";
        [view addSubview:label];
        
    }
    return self;
}
-(void)configWithImage:(UIImage *)image
{
    if (image)
    {
        self.organ_imageView.image = image;
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
