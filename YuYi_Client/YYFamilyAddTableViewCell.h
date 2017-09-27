//
//  YYFamilyAddTableViewCell.h
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/27.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYFamilyAddTableViewCell : UITableViewCell


@property (nonatomic, strong) UIImageView *iconV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *introduceLabel;
@property (nonatomic, strong) UIView *cardView;

@property (nonatomic, strong) UILabel *ageLabel;
@property (nonatomic, strong) UILabel *telNumLabel;
- (void)addOtherCell;


@end
