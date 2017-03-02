//
//  YYFamilyAddTableViewCell.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/27.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYFamilyAddTableViewCell.h"
#import <Masonry.h>
#import "UIColor+Extension.h"
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
        make.top.equalTo(self.contentView).with.offset(10 *kiphone6);
        make.left.equalTo(self.contentView).with.offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(kScreenW - 20 *kiphone6, 60 *kiphone6));
    }];
    
    
    self.iconV = [[UIImageView alloc]init];
    self.iconV.layer.cornerRadius = 18.5 *kiphone6;
    self.iconV.clipsToBounds = YES;
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = [UIFont fontWithName:kPingFang_S size:14];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    

    [self.cardView addSubview:self.iconV];
    [self.cardView  addSubview:self.titleLabel];
    
    WS(ws);
    [self.iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.cardView).with.offset(11.5 *kiphone6);
        make.left.equalTo(ws.cardView).with.offset(15 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(37 *kiphone6, 37 *kiphone6));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.cardView);
        make.left.equalTo(ws.iconV.mas_right).with.offset(15 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(200 *kiphone6, 14 *kiphone6));
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
