//
//  YYHomeNewTableViewCell.h
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/20.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYHomeNewTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *introduceLabel;

- (void)createDetailView:(NSInteger)lineNum;
- (void)addStarView;
@end