//
//  YYSectorTableViewCell.h
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/21.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppointmentModel.h"

@interface YYSectorTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *introduceLabel;
@property (nonatomic, strong) UIButton *appointmentBtn;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UILabel *titleLabel;//级别
@property (nonatomic, strong) AppointmentModel *appointmentModel;
@property (nonatomic, assign) BOOL isMorning;
@property (nonatomic, copy) void(^bannerClick)(BOOL isShopping);
@end
