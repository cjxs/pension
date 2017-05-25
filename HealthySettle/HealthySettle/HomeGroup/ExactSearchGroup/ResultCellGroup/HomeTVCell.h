//
//  HomeTVCell.h
//  HealthySettle
//
//  Created by yrc on 16/4/1.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HomeCellDelegate
-(void)cellShowPriceDetail:(UIButton *)btn;//1.1定义协议与方法
- (void)fillInOrderController:(UIButton *)btn;
@end

@interface HomeTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *organ_imageView;
@property (weak, nonatomic) IBOutlet UIButton    *priceDetail_btn;
@property (weak, nonatomic) IBOutlet UILabel     *price_label;
@property (weak, nonatomic) IBOutlet UIButton    *reserve_btn;
@property (weak, nonatomic) IBOutlet UILabel *room_type;
@property (weak, nonatomic) IBOutlet UILabel *catered_l;
@property (weak, nonatomic) IBOutlet UILabel *bed_type;
@property (weak, nonatomic) IBOutlet UILabel *size_l;
@property (weak, nonatomic) IBOutlet UILabel *live_num;
@property (weak,nonatomic)id<HomeCellDelegate>delegate;

-(void)configWithdic:(NSDictionary*)dic show:(NSString *)show;
@end
