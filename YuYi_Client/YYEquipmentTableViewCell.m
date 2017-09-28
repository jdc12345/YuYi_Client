//
//  YYEquipmentTableViewCell.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/27.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYEquipmentTableViewCell.h"
#import <Masonry.h>
#import "UIColor+Extension.h"

@implementation YYEquipmentTableViewCell

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
    self.cardView.layer.cornerRadius = 7.5;
    
    [self.contentView addSubview:self.cardView];
    
    [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20 *kiphone6H);
        make.left.offset(10 *kiphone6);
        make.right.offset(-10 *kiphone6);
        make.height.offset(100 *kiphone6H);
    }];
    
    
    self.iconV = [[UIImageView alloc]init];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = [UIFont fontWithName:kPingFang_S size:15];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    
    
    
    self.introduceLabel = [[UILabel alloc]init];
    self.introduceLabel.font = [UIFont systemFontOfSize:13];
    self.introduceLabel.textColor = [UIColor colorWithHexString:@"999999"];
    
    
    [self.cardView addSubview:self.iconV];
    [self.cardView  addSubview:self.titleLabel];
    [self.cardView addSubview:self.introduceLabel];
//    [self.cardView addSubview:lineLabel];
    
    WS(ws);
    [self.iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.centerX.equalTo(self.cardView.mas_left).offset(35 *kiphone6);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.cardView.mas_centerY).offset(-2.5 *kiphone6);
        make.left.equalTo(ws.iconV.mas_right).offset(20 *kiphone6);
    }];
    [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.cardView.mas_centerY).offset(2.5 *kiphone6);
        make.left.equalTo(ws.iconV.mas_right).offset(20 *kiphone6);
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
- (void)connectEquipment{
    UIButton *sureBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
//    sureBtn.layer.cornerRadius = 1.5 *kiphone6;
//    sureBtn.layer.borderWidth = 0.5 *kiphone6;
//    sureBtn.layer.borderColor = [UIColor colorWithHexString:@"25f368"].CGColor;
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    sureBtn.clipsToBounds = YES;
    [sureBtn setTitle:@"连接设备" forState:UIControlStateNormal];
    sureBtn.backgroundColor = [UIColor whiteColor];
    [sureBtn setTitleColor:[UIColor colorWithHexString:@"1ebeec"] forState:UIControlStateNormal];
//    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [sureBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [sureBtn addTarget:self action:@selector(buttonClick1:) forControlEvents:UIControlEventTouchUpInside];

    [self.cardView addSubview:sureBtn];
    
    WS(ws);
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.cardView);
        make.right.equalTo(ws.cardView).with.offset(-10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(60 *kiphone6, 20 *kiphone6));
    }];
    
    self.connectBtn = sureBtn;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)buttonClick:(UIButton *)button{
    [button setBackgroundColor:[UIColor colorWithHexString:@"25f368"]];
}
-(void)buttonClick1:(UIButton *)button{
    [button setBackgroundColor:[UIColor whiteColor]];

    
}


@end
