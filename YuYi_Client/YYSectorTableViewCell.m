//
//  YYSectorTableViewCell.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/21.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYSectorTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation YYSectorTableViewCell

-(void)setAppointmentModel:(AppointmentModel *)appointmentModel{
    _appointmentModel = appointmentModel;
    [self.iconV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mPrefixUrl,appointmentModel.avatar]]];//[UIImage imageNamed:[NSString stringWithFormat:@"cell%ld",(indexPath.row)%2 +1]];
    self.nameLabel.text = appointmentModel.trueName;
    self.titleLabel.text = appointmentModel.title;
    if (self.isMorning) {
        self.countLabel.text = [NSString stringWithFormat:@"余号%@",appointmentModel.beforNum];
    }else{
        self.countLabel.text = [NSString stringWithFormat:@"余号%@",appointmentModel.afterNum];
    }
}
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
    
    //..backview
    UIView *backview = [[UIView alloc]init];
    backview.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backview];
    
    [backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(10*kiphone6);
        make.right.bottom.offset(-10*kiphone6);
    }];
    
    self.iconV = [[UIImageView alloc]init];
    self.iconV.image = [UIImage imageNamed:@"cell1"];
    [backview addSubview:self.iconV];
 
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.textColor = [UIColor colorWithHexString:@"6a6a6a"];
    self.nameLabel.font = [UIFont fontWithName:@"PingFangSC-Medium"size:18];
    self.nameLabel.text = @"李美丽";
    [backview addSubview:self.nameLabel];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"6a6a6a"];
    self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium"size:15];
    self.titleLabel.text = @"主任医师";
    [backview addSubview:self.titleLabel];
    
    self.introduceLabel = [[UILabel alloc]init];
    self.introduceLabel.numberOfLines = 0;
    self.introduceLabel.textColor = [UIColor colorWithHexString:@"6a6a6a"];
    self.introduceLabel.font = [UIFont systemFontOfSize:14];
    self.introduceLabel.text = @"擅长：哮喘的规范化诊断与治疗，慢性阻塞性肺病机械治疗";
    [backview addSubview:self.introduceLabel];
    
    self.appointmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.appointmentBtn.backgroundColor = [UIColor colorWithHexString:@"05b1f7"];
    self.appointmentBtn.layer.cornerRadius = 17.5 *kiphone6;
    self.appointmentBtn.clipsToBounds = YES;
    [self.appointmentBtn addTarget:self action:@selector(appointmentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backview addSubview:self.appointmentBtn];
    
    [self.iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15 *kiphone6);
        make.left.offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(85 *kiphone6, 110 *kiphone6));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconV.mas_top).offset(10 *kiphone6);
        make.left.equalTo(self.iconV.mas_right).offset(10 *kiphone6);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(15 *kiphone6);
        make.left.equalTo(self.iconV.mas_right).offset(10 *kiphone6);
    }];
    [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.iconV.mas_bottom);
        make.left.equalTo(self.iconV.mas_right).offset(10 *kiphone6);
        make.right.offset(-15 *kiphone6);
//        make.height.mas_equalTo(30);
    }];
    [self.appointmentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconV.mas_bottom).offset(15 *kiphone6);
        make.right.offset(-10 *kiphone6);
        make.left.offset(10 *kiphone6);
        make.height.offset(33*kiphone6);
    }];
    
    UILabel *texttxet = [[UILabel alloc]init];
    texttxet.text = @"挂号";
    texttxet.textColor = [UIColor colorWithHexString:@"fefbfb"];
    texttxet.font = [UIFont systemFontOfSize:15];
    texttxet.textAlignment = NSTextAlignmentCenter;
    
    UILabel *countLabel = [[UILabel alloc]init];
    countLabel.text = @"余号32";
    countLabel.textColor = [UIColor colorWithHexString:@"fefbfb"];
    countLabel.font = [UIFont systemFontOfSize:10];
    countLabel.textAlignment = NSTextAlignmentCenter;
    self.countLabel = countLabel;
        
    [self.appointmentBtn addSubview:texttxet];
    [self.appointmentBtn addSubview:countLabel];
    
    WS(ws);
    [texttxet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.appointmentBtn);
        make.right.equalTo(ws.appointmentBtn.mas_centerX).offset(-5);
    }];
    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.appointmentBtn);
        make.left.equalTo(ws.appointmentBtn.mas_centerX).offset(5);
    }];

}
- (void)appointmentBtnClick:(UIButton *)sender{
    self.bannerClick(YES);
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
