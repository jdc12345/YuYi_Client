//
//  YYHomeMedicineTableViewCell.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/20.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYHomeMedicineTableViewCell.h"
#import <Masonry.h>
#import "UIColor+Extension.h"

@implementation YYHomeMedicineTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createDetailView];
    }
    return self;
}
- (void)createDetailView{
    
    NSArray *imageList = @[@"medicine",@"medicine",@"medicine"];
    NSArray *nameList = @[@"999感冒灵",@"999感冒灵",@"999感冒灵"];
    NSArray *prictList = @[@"38",@"38",@"38"];
    CGFloat buttonW = kScreenW /3.0;
    //..邪恶的分割线
    UILabel *lineL = [[UILabel alloc]init];
    lineL.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    [self.contentView addSubview:lineL];
    [lineL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).with.offset(20 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 1));
    }];
    
    for (int i = 0; i <3; i++) {
        
        UIView *medicineV = [[UIView alloc]init];
        medicineV.tag = 100 +i;
        
        self.iconV = [[UIImageView alloc]init];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.textColor = [UIColor colorWithHexString:@"6a6a6a"];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.priceLabel = [[UILabel alloc]init];
        self.priceLabel.textColor = [UIColor colorWithHexString:@"e00610"];
        self.priceLabel.font = [UIFont systemFontOfSize:15];
        self.priceLabel.textAlignment = NSTextAlignmentCenter;
        
        
        
        [medicineV addSubview:self.iconV];
        [medicineV addSubview:self.titleLabel];
        [medicineV addSubview:self.priceLabel];
        
        [self.iconV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(medicineV).with.offset(10 *kiphone6);
            make.left.equalTo(medicineV).with.offset(10 *kiphone6);
            make.size.mas_equalTo(CGSizeMake(100 *kiphone6 , 100 *kiphone6));
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconV.mas_bottom).with.offset(10);
            make.left.equalTo(medicineV);
            make.size.mas_equalTo(CGSizeMake(buttonW, 15));
        }];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).with.offset(6);
            make.left.equalTo(medicineV);
            make.size.mas_equalTo(CGSizeMake(buttonW, 15));
        }];
        
        self.iconV.image = [UIImage imageNamed:@"medicine"];
        self.titleLabel.text = @"999感冒灵";
        self.priceLabel.text = @"¥38";
        
        
        
        [self.contentView addSubview:medicineV];
        [medicineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView).with.offset(i *buttonW);
            make.size.mas_equalTo(CGSizeMake(buttonW, 166 *kiphone6));
        }];
    }
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
