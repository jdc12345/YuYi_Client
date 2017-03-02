//
//  YYSectorTableViewCell.h
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/21.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYSectorTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *introduceLabel;
@property (nonatomic, strong) UIButton *appointmentBtn;
@property (nonatomic, strong) UILabel *countLabel;


@property (nonatomic, copy) void(^bannerClick)(BOOL isShopping);
@end
