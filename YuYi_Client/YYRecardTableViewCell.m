//
//  YYRecardTableViewCell.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/24.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYRecardTableViewCell.h"
@interface YYRecardTableViewCell()
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *departmentLabel;
@property (nonatomic, strong) UIImageView *nextImageV;
@property (nonatomic, strong) UILabel *hospitalLabel;
@property (nonatomic, strong) UILabel *medicalrecordLabel;
@end
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
-(void)setModel:(RecardModel *)model{
    _model = model;
    NSString *time = [model.createTimeString substringToIndex:10];
    self.timeLabel.text = time;
    self.departmentLabel.text = model.departmentName;
    self.hospitalLabel.text = model.hospitalName;
    self.medicalrecordLabel.text = model.medicalrecord;
    
}
- (void)createDetailView{
    
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    
    UIView *leftBackView = [[UIView alloc]init];
    leftBackView.backgroundColor = [UIColor colorWithHexString:@"e5f6fb"];
    //采集时间label
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.textColor = [UIColor colorWithHexString:@"1ebeec"];
    timeLabel.font = [UIFont systemFontOfSize:15];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.numberOfLines = 0;
    self.timeLabel = timeLabel;
    self.timeLabel.text = @"2017 09-25";
    
    UIView *rightBackView = [[UIView alloc]init];
    rightBackView.backgroundColor = [UIColor whiteColor];
    
    //科室label
    self.departmentLabel = [[UILabel alloc]init];
    self.departmentLabel.textColor = [UIColor colorWithHexString:@"333333"];
    self.departmentLabel.font = [UIFont systemFontOfSize:14];
    self.departmentLabel.text = @"科室";
    
    //医院label
    self.hospitalLabel = [[UILabel alloc]init];
    self.hospitalLabel.textColor = [UIColor colorWithHexString:@"999999"];
    self.hospitalLabel.font = [UIFont systemFontOfSize:14];
    self.hospitalLabel.text = @"医院";
//    self.hospitalLabel.textAlignment = NSTextAlignmentRight;
    
    //记录label
    self.medicalrecordLabel = [[UILabel alloc]init];
    self.medicalrecordLabel.textColor = [UIColor colorWithHexString:@"999999"];
    self.medicalrecordLabel.font = [UIFont systemFontOfSize:12];
    self.medicalrecordLabel.text = @"医院.............................";
    
    //详情label
    UILabel *detailLabel = [[UILabel alloc]init];
    detailLabel.textColor = [UIColor colorWithHexString:@"999999"];
    detailLabel.font = [UIFont systemFontOfSize:12];
    detailLabel.text = @"详情";
    
    //nextImage
    UIImageView *nextImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rightarrow_mine"]];
    
    [self.contentView addSubview:leftBackView];
    [leftBackView addSubview:timeLabel];
    [self.contentView addSubview:rightBackView];
    [rightBackView addSubview:self.departmentLabel];
    [rightBackView addSubview:self.hospitalLabel];
    [rightBackView addSubview:self.medicalrecordLabel];
    [rightBackView addSubview:detailLabel];
    [rightBackView addSubview:nextImage];
    
    [leftBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(10*kiphone6H);
        make.size.mas_equalTo(CGSizeMake(75*kiphone6, 75*kiphone6H));
    }];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.centerY.offset(0);
    }];
    
    [rightBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftBackView.mas_right);
        make.top.offset(10*kiphone6H);
        make.right.offset(-10*kiphone6);
        make.bottom.offset(0);
    }];
    [self.departmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(10*kiphone6);
    }];
    
    [self.hospitalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10*kiphone6);
        make.right.offset(-10*kiphone6);
    }];
    
    [nextImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10*kiphone6);
        make.bottom.offset(-10*kiphone6);
        make.width.offset(nextImage.image.size.width);
        make.height.offset(nextImage.image.size.height);
    }];
    
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(nextImage.mas_left).offset(-5);
        make.centerY.equalTo(nextImage);
        make.width.offset(25);
    }];
    
    [self.medicalrecordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10*kiphone6);
        make.centerY.equalTo(nextImage);
        make.right.equalTo(detailLabel.mas_left).offset(-20);
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
