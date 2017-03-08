//
//  NotficationTableViewCell.h
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/3/8.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotficationTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *iconV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *introduceLabel;
@property (nonatomic, strong) UIView *cardView;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIButton *moreButton;


@property (nonatomic, assign) BOOL isHeight;

- (void)addOtherCell;
@end
