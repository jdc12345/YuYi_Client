//
//  YYAppointmentHospitalTVCell.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/9/15.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYAppointmentHospitalTVCell.h"
#import "UIImageView+WebCache.h"
@interface YYAppointmentHospitalTVCell ()

@property (nonatomic, weak) UIImageView* iconView;
@property (nonatomic, weak) UILabel* nameLabel;
@property (nonatomic, weak) UILabel* gradeLabel;

@end
@implementation YYAppointmentHospitalTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}
-(void)setModel:(YYInfomationModel *)model{
    _model = model;
    NSString *urlString = [mPrefixUrl stringByAppendingPathComponent:model.picture];
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:urlString]];
    self.gradeLabel.text = [NSString stringWithFormat:@"%@",model.gradeName];
    self.nameLabel.text = [NSString stringWithFormat:@"%@",model.hospitalName];
}
// 初始化控件
- (void)setupUI
{
    // icon
    UIImageView* iconView = [[UIImageView alloc] init];
    iconView.image = [UIImage imageNamed:@""];
    [self.contentView addSubview:iconView];
    //backView
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    backView.alpha = 0.7;
    [iconView addSubview:backView];
    // name
    UILabel* nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
    nameLabel.font = [UIFont systemFontOfSize:18];
    nameLabel.text = @"涿州市中医院";
    [backView addSubview:nameLabel];
    // grade
    UILabel* gradeLabel = [[UILabel alloc] init];
    gradeLabel.textColor = [UIColor colorWithHexString:@"333333"];
    gradeLabel.font = [UIFont systemFontOfSize:13];
    gradeLabel.text = @"三级甲等";
    [self.contentView addSubview:gradeLabel];
    
    // 自动布局
    [iconView mas_makeConstraints:^(MASConstraintMaker* make) {
        make.left.bottom.top.right.offset(0);
    }];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(65*kiphone6);
    }];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        make.bottom.equalTo(backView.mas_centerY).offset(-6*kiphone6);
        make.centerX.equalTo(backView);
    }];
    [gradeLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.equalTo(backView.mas_centerY).offset(6*kiphone6);
        make.centerX.equalTo(backView);
    }];
    self.iconView = iconView;
    self.nameLabel = nameLabel;
    self.gradeLabel = gradeLabel;
}

@end
