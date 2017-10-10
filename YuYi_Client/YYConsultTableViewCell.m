//
//  YYConsultTableViewCell.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/23.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYConsultTableViewCell.h"
#import <Masonry.h>
#import "UIColor+Extension.h"


@implementation YYConsultTableViewCell

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
//    self.titleLabel.text = @"涿州市中医院";
    
    
    self.introduceLabel = [[UILabel alloc]init];
    self.introduceLabel.numberOfLines = 1;
    self.introduceLabel.textColor = [UIColor colorWithHexString:@"666666"];
    self.introduceLabel.font = [UIFont systemFontOfSize:12];
    self.introduceLabel.text = @"地址：河北省涿州市范阳中路12号";
    
    UIImageView *posImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"consult_address_location"]];
    // [posImageV sizeToFit];
    
    self.posLabel = [[UILabel alloc]init];
    self.posLabel.text = @"5.2km";
    self.posLabel.textColor = [UIColor colorWithHexString:@"666666"];
    self.posLabel.font = [UIFont systemFontOfSize:12];
    CGSize maximumLabelSize = CGSizeMake(60, 12);//labelsize的最大值
    CGSize expectSize = [self.posLabel sizeThatFits:maximumLabelSize];
    
    [self.contentView addSubview:lineL];
    [self.contentView addSubview:self.iconV];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.introduceLabel];
    [self.contentView addSubview:self.posLabel];
    [self.contentView addSubview:posImageV];
    
    
    [lineL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).with.offset(20 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 1));
    }];
    [self.iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(10 *kiphone6);
        make.left.equalTo(self.contentView).with.offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(60 *kiphone6, 60 *kiphone6));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(8.5 *kiphone6);
        make.left.equalTo(self.iconV.mas_right).with.offset(20 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(205 *kiphone6, 15 *kiphone6));
    }];
    [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.iconV.mas_bottom).with.offset(1.5 *kiphone6);
        make.left.equalTo(self.titleLabel.mas_left);
        make.size.mas_equalTo(CGSizeMake(205 *kiphone6, 12 *kiphone6));
    }];
    [self.posLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(expectSize.width, expectSize.height*kiphone6));
    }];
    [posImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.posLabel.mas_left).offset(-5 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(8 *kiphone6, 12 *kiphone6));
    }];
    }
}
- (void)addStarView:(NSString *)telePhone{
    if (!self.doubleLabel) {
        UILabel *starLabel = [[UILabel alloc]init];
        starLabel.text = [NSString stringWithFormat:@"电话：%@",telePhone];
        starLabel.textColor = [UIColor colorWithHexString:@"666666"];
        starLabel.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:starLabel];
        self.doubleLabel = starLabel;
        [starLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10 *kiphone6H);
            make.left.equalTo(self.titleLabel.mas_left);
//            make.size.mas_equalTo(CGSizeMake(200 *kiphone6, 12 *kiphone6));
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
