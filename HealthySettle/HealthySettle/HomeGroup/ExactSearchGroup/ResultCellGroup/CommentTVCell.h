//
//  CommentTVCell.h
//  HealthySettle
//
//  Created by yrc on 16/4/2.
//  Copyright © 2016年 yrc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTVCell : UITableViewCell
@property (weak, nonatomic  ) IBOutlet UILabel  *goodRadio_label;
@property (weak, nonatomic  ) IBOutlet UILabel  *commentNumber_label;
@property (weak, nonatomic  ) IBOutlet UIButton *commentNow_btn;
@property (weak, nonatomic  ) IBOutlet UILabel  *goodComment_label;
@property (weak, nonatomic  ) IBOutlet UILabel  *midComment_label;
@property (weak, nonatomic  ) IBOutlet UILabel  *badComment_label;
@property (nonatomic, strong) UIProgressView * goodPro_view;
@property (nonatomic, strong) UIProgressView * badPro_view;
@property (nonatomic, strong) UIProgressView * midPro_view;

@end
