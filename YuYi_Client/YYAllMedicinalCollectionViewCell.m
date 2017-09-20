//
//  YYAllMedicinalCollectionViewCell.m
//  电商
//
//  Created by 万宇 on 2017/2/21.
//  Copyright © 2017年 万宇. All rights reserved.
//

#import "YYAllMedicinalCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "YYHTTPSHOPConst.h"
@interface YYAllMedicinalCollectionViewCell ()

@property (nonatomic, weak) UIImageView* iconView;
@property (nonatomic, weak) UILabel* nameLabel;
//@property (nonatomic, weak) UILabel* priceLabel;

@end

@implementation YYAllMedicinalCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

-(void)setModel:(YYMedinicalDetailModel *)model{
    _model = model;
    NSString *urlString = [mPrefixUrl stringByAppendingPathComponent:model.picture];
//    NSString *urlString = [NSString stringWithFormat:@"http://192.168.1.42:8080/yuyi%@",model.picture];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:urlString]];
//    self.priceLabel.text = [NSString stringWithFormat:@"%ld",model.price];
    self.nameLabel.text = [NSString stringWithFormat:@"%@",model.drugsName];
}
// 初始化控件
- (void)setupUI
{
    
    // icon
    UIImageView* iconView = [[UIImageView alloc] init];
    iconView.image = [UIImage imageNamed:@""];
    [self.contentView addSubview:iconView];
//    // price
//    UILabel* priceLabel = [[UILabel alloc] init];
//    priceLabel.textColor = [UIColor colorWithHexString:@"e00610"];
//    priceLabel.font = [UIFont systemFontOfSize:15];
//    priceLabel.text = @"¥38";
//    [self.contentView addSubview:priceLabel];
    // name
    UILabel* nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = [UIColor colorWithHexString:@"6a6a6a"];
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.text = @"";
    [self.contentView addSubview:nameLabel];
    
    
    // 自动布局
   
//    [priceLabel mas_makeConstraints:^(MASConstraintMaker* make) {
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
//        make.left.equalTo(iconView);
//    }];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker* make) {
//        make.bottom.equalTo(priceLabel.mas_top).offset(-10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
        make.left.equalTo(iconView);
    }];
    [iconView mas_makeConstraints:^(MASConstraintMaker* make) {
        make.left.offset(10);
        make.bottom.equalTo(nameLabel.mas_top).offset(-15);
        make.height.width.offset(150*kiphone6);
    }];
    self.iconView = iconView;
    self.nameLabel = nameLabel;
}

@end
