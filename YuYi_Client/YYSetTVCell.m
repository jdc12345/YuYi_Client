//
//  YYSetTVCell.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/9/28.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYSetTVCell.h"


@implementation YYSetTVCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createDetailView];
    }
    return self;
}
- (void)createDetailView{
    
    self.iconV = [[UIImageView alloc]init];
    self.iconV.image = [UIImage imageNamed:@"rightarrow_mine"];
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = [UIFont fontWithName:kPingFang_S size:13];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    [self.contentView addSubview:line];
    
    [self.contentView addSubview:self.iconV];
    [self.contentView  addSubview:self.titleLabel];
    
    [self.iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.offset(-10 *kiphone6);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(10 *kiphone6);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(1);
    }];
    
}


@end
