//
//  YYPInfomationTableViewCell.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/24.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYPInfomationTableViewCell.h"
#import <Masonry.h>
#import "UIColor+Extension.h"


@implementation YYPInfomationTableViewCell
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
    self.seeRecardLabel.textAlignment = NSTextAlignmentRight;
    
    self.editInfoText = [[UITextField alloc]init];
    self.editInfoText.textColor = [UIColor colorWithHexString:@"333333"];
    self.editInfoText.font = [UIFont systemFontOfSize:14];
    self.editInfoText.textAlignment = NSTextAlignmentRight;
    self.editInfoText.hidden = YES;
    
    
    [self.contentView addSubview:lineL];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.seeRecardLabel];
    [self.contentView addSubview:self.editInfoText];
    
    
    
    [lineL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 1));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).with.offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(100, 14 *kiphone6));
    }];
    
    [self.seeRecardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).with.offset(-10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(200 *kiphone6, 14 *kiphone6));
    }];
    [self.editInfoText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).with.offset(-10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(200 , 14 *kiphone6));
    }];
}
- (void)setType:(NSString *)cellType{
    if ([cellType isEqualToString:@"cellbounce"]) {
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bounceCellClick)];
        [self.seeRecardLabel addGestureRecognizer:tapGest];
    }else if([cellType isEqualToString:@"celltextfield"]){
        self.seeRecardLabel.hidden = YES;
        self.editInfoText.hidden = NO;
    }
}
- (void)bounceCellClick{
    self.sexClick(@"123");
    // self.seeRecardLabel.text = sex;
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
