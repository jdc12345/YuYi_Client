//
//  YYInfomationTVCell.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/9/21.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYInfomationTVCell.h"
#import "UIImageView+WebCache.h"
@interface YYInfomationTVCell ()

@property (nonatomic, weak) UIImageView* iconView;
@property (nonatomic, weak) UILabel* nameLabel;
//@property (nonatomic, weak) UILabel* gradeLabel;

@end
@implementation YYInfomationTVCell
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
//    self.gradeLabel.text = [NSString stringWithFormat:@"%@",model.gradeName];
    self.nameLabel.text = [NSString stringWithFormat:@"%@",model.title];
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
    backView.backgroundColor = [UIColor colorWithHexString:@"474d5b"];
    backView.alpha = 0.6;
    [iconView addSubview:backView];
    // name
    UILabel* nameLabel = [[UILabel alloc] init];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.text = @"涿州市中医院";
    [backView addSubview:nameLabel];

    // 自动布局
    [iconView mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.offset(0);
        make.left.offset(20*kiphone6);
        make.right.offset(-20*kiphone6);
        make.bottom.offset(-15*kiphone6);
    }];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(40*kiphone6);
    }];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        make.centerY.equalTo(backView);
        make.left.offset(10*kiphone6);
        make.right.offset(-10*kiphone6);
    }];

    self.iconView = iconView;
    self.nameLabel = nameLabel;
}

@end
