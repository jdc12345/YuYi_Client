//
//  YYConsultTableViewCell.h
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/23.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYConsultTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *iconV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *introduceLabel;
@property (nonatomic, strong) UILabel *posLabel;

- (void)createDetailView:(NSInteger)lineNum;
- (void)addStarView;
@end
