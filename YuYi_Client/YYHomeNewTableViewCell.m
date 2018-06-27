//
//  YYHomeNewTableViewCell.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/20.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYHomeNewTableViewCell.h"
//#import <Masonry.h>
//#import "UIColor+Extension.h"

@implementation YYHomeNewTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];//[UIColor colorWithHexString:@"#f6f6f6"];
        // [self createDetailView];
    }
    return self;
}
- (void)createDetailView:(NSInteger)lineNum{
    if (!self.iconV) {
        
    
    //..邪恶的分割线
    UILabel *lineL = [[UILabel alloc]init];
    lineL.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    
    self.iconV = [[UIImageView alloc]init];
    self.iconV.image = [UIImage imageNamed:@"cell1"];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.text = @"涿州市中医院";
    
    self.introduceLabel = [[UILabel alloc]init];
    self.introduceLabel.numberOfLines = lineNum;
    self.introduceLabel.textColor = [UIColor colorWithHexString:@"888888"];
    self.introduceLabel.font = [UIFont systemFontOfSize:12];
    self.introduceLabel.text = @"";//@"涿州北大医院是集医疗，科研，预防，保健，康复为一体的现代化新型医院，是涿州市民工人的惠民医院。涿州北大医院以服务人民为宗旨";
        
    [self.contentView addSubview:lineL];
    [self.contentView addSubview:self.iconV];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.introduceLabel];
    
    [lineL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).with.offset(20 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 1));
    }];
    [self.iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(15 *kiphone6);
        make.left.equalTo(self.contentView).with.offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(130 *kiphone6, 80 *kiphone6));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(15 +5 *kiphone6);
        make.left.equalTo(self.iconV.mas_right).with.offset(15 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(205 *kiphone6, 15 *kiphone6));
    }];
    [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.iconV.mas_bottom);
        make.left.equalTo(self.iconV.mas_right).with.offset(15 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(205 *kiphone6, 15 *lineNum));
    }];
    }    
}
- (void)addStarView{
    if (!self.starLabel) {
        

    UILabel *starLabel = [[UILabel alloc]init];
    starLabel.text = @"";
    starLabel.textColor = [UIColor colorWithHexString:@"686868"];
    starLabel.font = [UIFont systemFontOfSize:13];
    
    [self addSubview:starLabel];
    self.starLabel = starLabel;
    [starLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(10 *kiphone6);
        make.left.equalTo(self.titleLabel.mas_left).with.offset(0 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(60 , 13 *kiphone6));
    }];
    }
    
}
- (void)setLineNum:(NSInteger)lineNum{
    self.introduceLabel.numberOfLines = lineNum;
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
