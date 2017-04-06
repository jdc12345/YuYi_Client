//
//  YYCollectionViewCell.m
//  电商
//
//  Created by 万宇 on 2017/2/20.
//  Copyright © 2017年 万宇. All rights reserved.
//

#import "YYCollectionViewCell.h"
#import "Masonry.h"
#import "UIColor+colorValues.h"
#import "UIImageView+WebCache.h"
#import "YYHTTPSHOPConst.h"

@interface YYCollectionViewCell ()

@property (nonatomic, weak) UIImageView* iconView;
@property (nonatomic, weak) UILabel* nameLabel;
//@property (nonatomic, weak) UILabel* priceLabel;

@end
@implementation YYCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

// 会调用两次.告诉系统是否是高亮状态
// 当手指按下的时候调用一次 参数为yes 表示系统为高亮(赶紧换高亮的状态的图片)
// 当手指抬起的时候调用一次 参数为no 表示系统为不高亮(赶紧换普通的状态的图片)
- (void)setHighlighted:(BOOL)highlighted
{
    //    if (highlighted) {
    //        self.backgroundColor = [UIColor colorWithWhite:0.666 alpha:1];
    //    }
    //    else {
    //        self.backgroundColor = [UIColor whiteColor];
    //    }
    
    self.backgroundColor = highlighted ? [UIColor colorWithWhite:0.8 alpha:1] : [UIColor whiteColor];
}

//- (void)setBusinessType:(ZFBBusinessType*)businessType
//{
//    _businessType = businessType;
//    
//    // 把数据放在控件上
//    self.iconView.image = [UIImage imageNamed:businessType.icon];
//    self.nameLabel.text = businessType.name;
//}
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
    // price
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
    nameLabel.numberOfLines = 2;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:nameLabel];
    
    
    // 自动布局
//    [priceLabel mas_makeConstraints:^(MASConstraintMaker* make) {
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
//        make.centerX.equalTo(self.contentView);
//    }];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker* make) {
//        make.bottom.equalTo(priceLabel.mas_top).offset(-8);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
        make.centerX.equalTo(self.contentView);
        make.right.offset(0);
    }];
    [iconView mas_makeConstraints:^(MASConstraintMaker* make) {
        make.bottom.equalTo(nameLabel.mas_top).offset(-10);
        make.centerX.equalTo(self.contentView);
        //        make.width.offset(self.contentView.frame.size.width*0.7);
        //        make.height.offset(self.contentView.frame.size.height*0.7);
        make.width.height.offset(100*kiphone6);
    }];
    self.iconView = iconView;
    self.nameLabel = nameLabel;
}


@end
