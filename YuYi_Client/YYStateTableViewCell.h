//
//  YYStateTableViewCell.h
//  YuYi_Client
//
//  Created by 万宇 on 2017/3/21.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYStateTableViewCell : UITableViewCell
@property (nonatomic, weak) UIImageView* iconView;
@property (nonatomic, weak) UILabel* stateLabel;
@property (nonatomic, weak) UILabel* timeLabel;
@property (nonatomic, weak) UIView* progressBar;
@end
