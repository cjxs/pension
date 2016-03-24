//
//  SetTableViewCell.m
//  HealthySettle
//
//  Created by yrc on 16/3/18.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import "SetTableViewCell.h"
#import "TempView.h"


@implementation SetTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.tempThingV = [[TempView alloc] initWithFrame:CGRectMake(10, 5, screenWide/4, 40) withMark:[UIImage imageNamed:@"z_03"] andTitle:@" "];
        
        self.tempThingV.explainTitle.textColor =  [UIColor blackColor];
        self.tempThingV.backgroundColor = [UIColor whiteColor];
        [self addSubview:_tempThingV.markImageV];
        [self addSubview:_tempThingV.explainTitle];

        UIImageView * dirToRight = [[UIImageView alloc] initWithFrame:CGRectMake(screenWide-25, 10, 15, 20)];
        [self addSubview:dirToRight];
        dirToRight.image = [UIImage imageNamed:@"z_02"];//想有的小尖头的图片
        self.informationLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenWide -105, 10, 70, 20)];
        self.informationLabel.textAlignment = NSTextAlignmentRight;
        self.informationLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_informationLabel];
        UILabel * lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,screenHeight/9 * 0.6, screenWide, 0.5)];
        lineLabel.backgroundColor = [UIColor grayColor];
        [self addSubview:lineLabel];
    }
    return self;
}
- (void)setThingsWithName:(NSString *)stringQ Image:(UIImage *)imageB number:(NSString *)stringH {
    self.tempThingV.markImageV.image = imageB;
    self.tempThingV.explainTitle.text = stringQ;
    self.informationLabel.text = stringH;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
