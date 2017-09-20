//
//  NotficationTableViewCell.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/3/8.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "NotficationTableViewCell.h"
#import <Masonry.h>
#import "UIColor+Extension.h"

@implementation NotficationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    }
    return self;
}
- (void)setIsHeight:(BOOL)isHeight{
    _isHeight = isHeight;
    [self createDetailView];
}
- (void)createDetailView{
    CGFloat rowH ;
    if (self.isHeight) {
        rowH = 150;
    }else{
        rowH = 120;
    }
    
    self.cardView = [[UIView alloc]init];
    self.cardView.backgroundColor = [UIColor whiteColor];
    self.cardView.layer.shadowColor = [UIColor colorWithHexString:@"d5d5d5"].CGColor;
    self.cardView.layer.shadowRadius = 1 *kiphone6;
    self.cardView.layer.shadowOffset = CGSizeMake(1, 1);
    self.cardView.layer.shadowOpacity = 1;
    self.cardView.layer.masksToBounds = true;
    self.cardView.layer.cornerRadius = 5;
    [self.contentView addSubview:self.cardView];
    
    [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(kScreenW - 20 *kiphone6, rowH *kiphone6));
    }];
    
    
    self.iconV = [[UIImageView alloc]init];
//    self.iconV.layer.cornerRadius = 25 *kiphone6;
//    self.iconV.clipsToBounds = YES;
//    [self.iconV sizeToFit];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel.textColor = [UIColor colorWithHexString:@"888888"];
    self.timeLabel.text = @"12:05";
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    
    
    
    UILabel *lineL = [[UILabel alloc]init];
    lineL.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    
    self.introduceLabel = [[UILabel alloc]init];
    self.introduceLabel.font = [UIFont systemFontOfSize:12];
    self.introduceLabel.textColor = [UIColor colorWithHexString:@"333333"];
    self.introduceLabel.numberOfLines = 2;
    
    
    
    
    [self.cardView addSubview:self.iconV];
    [self.cardView  addSubview:self.titleLabel];
    [self.cardView addSubview:self.timeLabel];
    [self.cardView addSubview:lineL];
    [self.cardView addSubview:self.introduceLabel];
    
    
    WS(ws);
    [self.iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.cardView).with.offset(14 *kiphone6);
        make.left.equalTo(ws.cardView).with.offset(15 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(32 *kiphone6, 32 *kiphone6));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.cardView).with.offset(23 *kiphone6);
        make.left.equalTo(ws.iconV.mas_right).with.offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(64 , 14 ));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.iconV.mas_centerY);
        make.right.equalTo(ws.cardView.mas_right).with.offset(-15 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(64 , 12 ));
    }];
    
    
    [lineL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.cardView).with.offset(60 *kiphone6);
        make.left.equalTo(ws.cardView).with.offset(15 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(kScreenW - 15 *kiphone6, 1 *kiphone6));
    }];
    
    
    
    [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineL.mas_bottom).with.offset(15 *kiphone6);
        make.left.equalTo(ws.iconV.mas_left);
        make.size.mas_equalTo(CGSizeMake( kScreenW - 50 *kiphone6, 30));
    }];
    
    
    if (self.isHeight) {
        UILabel *lineL2 = [[UILabel alloc]init];
        lineL2.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
        
        [self.cardView addSubview:lineL2];
        
        [lineL2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(ws.cardView).with.offset(-30 *kiphone6);
            make.left.equalTo(ws.cardView).with.offset(15 *kiphone6);
            make.size.mas_equalTo(CGSizeMake(kScreenW - 15 *kiphone6, 1 *kiphone6));
        }];
        
        self.moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.moreButton setTitle:@"查看更多" forState:UIControlStateNormal];
        [self.moreButton setTitleColor:[UIColor colorWithHexString:@"25f368"] forState:UIControlStateNormal];
        self.moreButton.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [self.cardView addSubview:self.moreButton];
        
        
        [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(ws.cardView);
            make.left.equalTo(ws.cardView);
            make.size.mas_equalTo(CGSizeMake(kScreenW - 20 *kiphone6, 30 *kiphone6));
        }];
    }
    
    
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
