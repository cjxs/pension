//
//  ShowTVCell.m
//  HealthySettle
//
//  Created by yrc on 16/4/3.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "ShowTVCell.h"

@implementation ShowTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIView * margin_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWide, 13)];
    margin_view.backgroundColor =  RGB(242, 242, 242);
    [self addSubview:margin_view];
    [self.left_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(screenHeight * 0.122));
    }];

    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)configWithTitle:(NSString *)title
            imageArray:(NSArray *)array
                  text:(NSString *)text
{
    if (title)
    {
        self.title_label.text = title;
    }
    if (array)
    {   NSMutableArray * arr = [NSMutableArray arrayWithCapacity:0];
        for (NSString * str in array) {
            NSString *  str2 = [NSString stringWithFormat:@"%@/upload/group/%@",BASEURL,str];
            NSString * str3 = [str2 stringByReplacingOccurrencesOfString:@"," withString:@"/"];
            [arr addObject:str3];
        }
        switch (array.count) {
            case 0:
               
                break;
            case 1:
                [self.left_imageView sd_setImageWithURL:[NSURL URLWithString:arr[0]] placeholderImage:[UIImage imageNamed:@"list_p"]];
                
                break;
            case 2:
                [self.left_imageView sd_setImageWithURL:[NSURL URLWithString:arr[0]] placeholderImage:[UIImage imageNamed:@"list_p"]];
                 [self.mid_imageView sd_setImageWithURL:[NSURL URLWithString:arr[1]] placeholderImage:[UIImage imageNamed:@"list_p"]];
                
                break;
            default:
                [self.left_imageView sd_setImageWithURL:[NSURL URLWithString:arr[0]] placeholderImage:[UIImage imageNamed:@"list_p"]];
                [self.mid_imageView sd_setImageWithURL:[NSURL URLWithString:arr[1]] placeholderImage:[UIImage imageNamed:@"list_p"]];
                [self.right_imageView sd_setImageWithURL:[NSURL URLWithString:arr[2]] placeholderImage:[UIImage imageNamed:@"list_p"]];
                break;
        }
    }
    if (text)
    {
        UILabel * label = [[UILabel alloc] init];
        label.text = text;
        UIFont * fnt = [UIFont fontWithName:text size:8];
        label.font = fnt;
        label.font = [UIFont systemFontOfSize:10];
        CGFloat  height =[label.text boundingRectWithSize:
                               CGSizeMake(screenWide - 20, CGFLOAT_MAX)
                                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                    attributes:[NSDictionary dictionaryWithObjectsAndKeys:label.font,NSFontAttributeName, nil] context:nil].size.height;
        label.frame = CGRectMake(10, 125, screenWide - 20, height);
        label.numberOfLines = 0;
        label.textColor = RGB(158, 159, 159);
        [self addSubview:label];
    }
}

@end
