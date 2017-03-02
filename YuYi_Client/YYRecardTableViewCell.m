//
//  YYRecardTableViewCell.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/24.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYRecardTableViewCell.h"
#import <Masonry.h>
#import "UIColor+Extension.h"

@implementation YYRecardTableViewCell
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
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.text = @"李美丽";
    
    self.seeRecardLabel = [[UILabel alloc]init];
    self.seeRecardLabel.textColor = [UIColor colorWithHexString:@"333333"];
    self.seeRecardLabel.font = [UIFont systemFontOfSize:14];
    self.seeRecardLabel.text = @"病理查看";
    self.seeRecardLabel.textAlignment = NSTextAlignmentRight;
    
    
    [self.contentView addSubview:lineL];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.seeRecardLabel];
    
    
    
    [lineL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).with.offset(20 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 1));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).with.offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(100 *kiphone6, 14 *kiphone6));
    }];
    
    [self.seeRecardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).with.offset(-10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(64 *kiphone6, 14 *kiphone6));
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
