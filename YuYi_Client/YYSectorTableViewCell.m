//
//  YYSectorTableViewCell.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/21.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYSectorTableViewCell.h"
#import <Masonry.h>
#import "UIColor+Extension.h"

@implementation YYSectorTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];//[UIColor colorWithHexString:@"#f6f6f6"];
        [self createDetailView];
    }
    return self;
}
- (void)createDetailView{
    
    //..邪恶的分割线
    UILabel *lineL = [[UILabel alloc]init];
    lineL.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    
    self.iconV = [[UIImageView alloc]init];
    self.iconV.image = [UIImage imageNamed:@"cell1"];
    self.iconV.layer.cornerRadius = 37.5 *kiphone6;
    self.iconV.clipsToBounds = YES;
    
    self.appointmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.appointmentBtn.backgroundColor = [UIColor colorWithHexString:@"25f368"];
//    self.appointmentBtn =
    self.appointmentBtn.layer.cornerRadius = 27.5 *kiphone6;
    self.appointmentBtn.clipsToBounds = YES;
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"6a6a6a"];
    self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium"size:15];
    self.titleLabel.text = @"李美丽";
    
    
    self.introduceLabel = [[UILabel alloc]init];
    self.introduceLabel.numberOfLines = 2;
    self.introduceLabel.textColor = [UIColor colorWithHexString:@"6a6a6a"];
    self.introduceLabel.font = [UIFont systemFontOfSize:12];
    self.introduceLabel.text = @"擅长：哮喘的规范化诊断与治疗，慢性阻塞性肺病机械治疗";
    
    
    [self.contentView addSubview:lineL];
    [self.contentView addSubview:self.iconV];
    [self.contentView addSubview:self.appointmentBtn];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.introduceLabel];
    
    
    [lineL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).with.offset(20 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 1));
    }];
    [self.iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(22.5 *kiphone6);
        make.left.equalTo(self.contentView).with.offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(75 *kiphone6, 75 *kiphone6));
    }];
    [self.appointmentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconV.mas_top).with.offset(10 *kiphone6);
        make.right.equalTo(self.contentView).with.offset(20 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(55 *kiphone6, 55 *kiphone6));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(42 *kiphone6);
        make.left.equalTo(self.iconV.mas_right).with.offset(15 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(45 *kiphone6, 15 *kiphone6));
    }];
    [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.iconV.mas_bottom);
        make.left.equalTo(self.iconV.mas_right).with.offset(15 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(205 *kiphone6, 30 *kiphone6));
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
