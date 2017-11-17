//
//  YYMemberTableViewCell.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/22.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYMemberTableViewCell.h"

@implementation YYMemberTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];//[UIColor colorWithHexString:@"#f6f6f6"];
        [self createDetailView:2];
    }
    return self;
}
- (void)createDetailView:(NSInteger)lineNum{
    //..邪恶的分割线
    UILabel *lineL = [[UILabel alloc]init];
    lineL.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    
    UILabel *lineL2 = [[UILabel alloc]init];
    lineL2.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    
    self.iconV = [[UIImageView alloc]init];
    self.iconV.image = [UIImage imageNamed:@"cell1"];
    self.iconV.layer.cornerRadius = 20 *kiphone6;
    self.iconV.clipsToBounds = YES;
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.text = @"涿州市中医院";
    
    [self addSubview:lineL];
    [self addSubview:lineL2];
    [self addSubview:self.iconV];
    [self addSubview:self.titleLabel];
    
    [lineL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).with.offset(0 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 1));
    }];
    [lineL2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(60 *kiphone6);
        make.left.equalTo(self.contentView).with.offset(0 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 1));
    }];
    [self.iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10 *kiphone6);
        make.left.equalTo(self.contentView).offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(40 *kiphone6, 40 *kiphone6));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconV.mas_centerY);
        make.left.equalTo(self.iconV.mas_right).offset(15 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(205 *kiphone6, 15 *kiphone6));
    }];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
