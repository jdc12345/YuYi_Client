//
//  YYStateTableViewCell.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/3/21.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYStateTableViewCell.h"
#import "Masonry.h"
#import "UIColor+colorValues.h"
#import "UIImageView+WebCache.h"
#import "YYHTTPSHOPConst.h"


@interface YYStateTableViewCell()

@end
@implementation YYStateTableViewCell

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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
    self.backgroundColor = highlighted ? [UIColor colorWithWhite:0.8 alpha:1] : [UIColor whiteColor];
}


//-(void)setModel:(YYMedinicalDetailModel *)model{
//    _model = model;
//    NSString *urlString = [API_BASE_URL stringByAppendingPathComponent:model.picture];
//    //    NSString *urlString = [NSString stringWithFormat:@"http://192.168.1.42:8080/yuyi%@",model.picture];
//    [self.iconView sd_setImageWithURL:[NSURL URLWithString:urlString]];
//    self.priceLabel.text = [NSString stringWithFormat:@"%ld",model.price];
//    self.nameLabel.text = [NSString stringWithFormat:@"%@",model.drugsName];
//}
// 初始化控件
- (void)setupUI
{
    
    // icon
    UIImageView* iconView = [[UIImageView alloc] init];
    iconView.image = [UIImage imageNamed:@"unselected"];
    [self.contentView addSubview:iconView];
    self.iconView = iconView;
    // time
    UILabel* timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = [UIColor colorWithHexString:@"333333"];
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.text = @"08:10";
    [self.contentView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    // state
    UILabel* stateLabel = [[UILabel alloc] init];
    stateLabel.textColor = [UIColor colorWithHexString:@"333333"];
    stateLabel.font = [UIFont systemFontOfSize:12];
    stateLabel.text = @"药品清单已接收";
    [self.contentView addSubview:stateLabel];
    self.stateLabel = stateLabel;
    // progressBar
    UIView* progressBar = [[UIView alloc] init];
    progressBar.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    [self.contentView addSubview:progressBar];
    self.progressBar = progressBar;
    
    // 自动布局
    [iconView mas_makeConstraints:^(MASConstraintMaker* make) {
        make.left.offset(25);
        make.top.offset(5);
    }];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.equalTo(iconView);
        make.left.equalTo(iconView.mas_right).offset(5);
    }];
    [stateLabel mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.equalTo(timeLabel.mas_bottom).offset(5);
        make.left.equalTo(iconView.mas_right).offset(5);
    }];
    [progressBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconView.mas_bottom).offset(5);
        make.centerX.equalTo(iconView);
        make.width.offset(1);
        make.height.offset(70);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(progressBar.mas_bottom);
    }];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
