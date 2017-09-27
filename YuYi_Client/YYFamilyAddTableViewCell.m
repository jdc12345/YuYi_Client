//
//  YYFamilyAddTableViewCell.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/27.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYFamilyAddTableViewCell.h"
#import "YYFamilyAccountViewController.h"

@implementation YYFamilyAddTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
        [self createDetailView];
    }
    return self;
}
- (void)createDetailView{
    self.cardView = [[UIView alloc]init];
    self.cardView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.cardView];
    
    [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10 *kiphone6H);
        make.left.offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(kScreenW - 20 *kiphone6, 120 *kiphone6H));
    }];
    
    
    self.iconV = [[UIImageView alloc]init];
    self.iconV.layer.cornerRadius = 50 *kiphone6;
    self.iconV.clipsToBounds = YES;
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = [UIFont fontWithName:kPingFang_S size:14];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    
    self.ageLabel = [[UILabel alloc]init];
    self.ageLabel.font = [UIFont fontWithName:kPingFang_S size:14];
    self.ageLabel.textColor = [UIColor colorWithHexString:@"333333"];

    self.telNumLabel = [[UILabel alloc]init];
    self.telNumLabel.font = [UIFont fontWithName:kPingFang_S size:14];
    self.telNumLabel.textColor = [UIColor colorWithHexString:@"333333"];

    [self.cardView addSubview:self.iconV];
    [self.cardView  addSubview:self.titleLabel];
    [self.cardView addSubview:self.ageLabel];
    [self.cardView  addSubview:self.telNumLabel];
    
    WS(ws);
    [self.iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_cardView);
        make.left.offset(10*kiphone6);
        make.size.mas_equalTo(CGSizeMake(100 *kiphone6, 100 *kiphone6));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.cardView.mas_centerY).offset(-7.5*kiphone6H);
        make.left.equalTo(ws.iconV.mas_right).offset(15 *kiphone6);
    }];
    [self.ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_right).offset(20*kiphone6);
        make.centerY.equalTo(_titleLabel);
    }];
    [self.telNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_titleLabel.mas_bottom).offset(15*kiphone6H);
    }];

    
    
    
}
- (void)addOtherCell{
    self.iconV.layer.cornerRadius = 0;
    WS(ws);
    [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.cardView);
        make.left.equalTo(ws.iconV.mas_right).with.offset(20 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(13 *8 *kiphone6, 13 *kiphone6));
    }];
    self.titleLabel.hidden = YES;
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
