//
//  YYDataAnalysisTVCell.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/9/27.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYDataAnalysisTVCell.h"
#import "YYTrendView.h"

@interface YYDataAnalysisTVCell()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *bloodpressureList;//当前用户血压数据集
@property (nonatomic, strong) NSMutableArray *temperatureList;//当前用户体温数据集
@property (nonatomic, weak) YYTrendView *bloodpressureTrendView;//当前用户血压图表
@property (nonatomic, weak) YYTrendView *temperatureTrendView;//当前用户体温图表
//@property (nonatomic, weak) UILabel *statusLabel;
@property (nonatomic, weak) UIImageView *imageV;//数据是否正常图片
@property (nonatomic, strong) NSMutableArray *labelArray;//显示当前用户高低压和体温的label集

@end

@implementation YYDataAnalysisTVCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];//[UIColor colorWithHexString:@"#f6f6f6"];
        [self createDetailView];
    }
    return self;
}
- (void)createDetailView{
    //图表下信息栏
    UIView *infoView = [[UIView alloc] init];
    infoView.backgroundColor = [UIColor whiteColor];
    
    NSArray *titleArray = @[@"收缩压(高压)",@"舒张压(低压)",@"体温"];
    NSArray *testDataArray = @[@"129",@"87",@"38℃"];
    CGFloat kLabelW = kScreenW /4.0;
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"data_test"]];
    self.imageV = imageV;
    [infoView addSubview:imageV];
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset((kLabelW -40*kiphone6) /2.0);
        make.size.mas_equalTo(CGSizeMake(40 *kiphone6, 40 *kiphone6));
    }];
    
    for (int i = 0; i < 3; i++) {
        
        // data
        UILabel *test_banner = [[UILabel alloc]init];
        test_banner.text = [NSString stringWithFormat:@"%@",testDataArray[i]];
        test_banner.font = [UIFont systemFontOfSize:15];
        test_banner.textColor = [UIColor colorWithHexString:@"666666"];
        test_banner.textAlignment = NSTextAlignmentCenter;
        [self.labelArray addObject:test_banner];
        
        
        
        UILabel *label_banner = [[UILabel alloc]init];
        label_banner.text = titleArray[i];
        label_banner.font = [UIFont systemFontOfSize:9];
        label_banner.textColor = [UIColor colorWithHexString:@"cccccc"];
        label_banner.textAlignment = NSTextAlignmentCenter;
        
        //
        [infoView addSubview:test_banner];
        [infoView addSubview:label_banner];
        
        [test_banner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageV.mas_top);
            make.left.offset((i +1) *kLabelW);
            make.size.mas_equalTo(CGSizeMake(kLabelW *kiphone6, 15));
        }];
        [label_banner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(test_banner.mas_bottom).offset(12 *kiphone6);
            make.left.equalTo(test_banner);
            make.size.mas_equalTo(CGSizeMake(kLabelW *kiphone6 , 9));
        }];
    }
    
    // TrendView
    UIScrollView *scrollTrendView = [[UIScrollView alloc]init];
    scrollTrendView.contentSize = CGSizeMake(kScreenW *2, 280 *kiphone6H);
    scrollTrendView.backgroundColor = [UIColor whiteColor];
    scrollTrendView.pagingEnabled = YES;
    scrollTrendView.showsHorizontalScrollIndicator = NO;
    scrollTrendView.delegate = self;
    
    
    YYTrendView *trendView = [[YYTrendView alloc]init];
    trendView.backgroundColor = [UIColor colorWithHexString:@"30323a"];
    
    YYTrendView *temperature_TrendView = [[YYTrendView alloc]init];
    temperature_TrendView.backgroundColor = [UIColor colorWithHexString:@"30323a"];
    
    [scrollTrendView addSubview:trendView];
    [scrollTrendView addSubview:temperature_TrendView];
    self.bloodpressureTrendView = trendView;
    self.temperatureTrendView = temperature_TrendView;
    
    [trendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 280 *kiphone6H));
    }];
    [temperature_TrendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(kScreenW);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 280 *kiphone6H));
    }];
    [self.contentView addSubview:infoView];
    [self.contentView addSubview:scrollTrendView];
    [scrollTrendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.offset(290 *kiphone6H);
    }];
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollTrendView.mas_bottom);
        make.left.right.offset(0);
        make.height.offset(70*kiphone6H);
    }];
         
}
//赋值
-(void)setPersonalModel:(YYHomeUserModel *)personalModel{
    _personalModel = personalModel;
    self.temperatureList = [NSMutableArray arrayWithArray:personalModel.temperatureList];
    //
    self.bloodpressureList = [NSMutableArray arrayWithArray:personalModel.bloodpressureList];
    
    NSMutableArray *highBlood = [[NSMutableArray alloc]initWithCapacity:2];
    NSMutableArray *lowBlood = [[NSMutableArray alloc]initWithCapacity:2];
    NSMutableArray *measureDate = [[NSMutableArray alloc]initWithCapacity:2];
    for (NSDictionary *dict  in personalModel.bloodpressureList) {
        NSString *str_high = dict[@"systolic"];
        NSString *str_low = dict[@"diastolic"];
        NSString *str_date = dict[@"createTimeString"];
        [highBlood addObject:[NSNumber numberWithFloat:[str_high floatValue]]];//高压数据集
        [lowBlood addObject:[NSNumber numberWithFloat:[str_low floatValue]]];//低压数据集
        [measureDate addObject:str_date];//日期数据集
    }
    [self.bloodpressureTrendView updateBloodTrendDataList:highBlood lowList:lowBlood dateList:measureDate];
    [self.temperatureTrendView updateTempatureTrendDataList:self.temperatureList];
    
    //infomation
    NSMutableArray *lateData = [[NSMutableArray alloc]initWithCapacity:2];
    
    
    NSDictionary* dict_blood =  self.bloodpressureList.lastObject;//显示最后一次测量结果
    NSDictionary* dict_temperature =  self.temperatureList.lastObject;
    
    BOOL isEmptyMeasure = NO;
    
    if (self.bloodpressureList.count != 0) {
        [lateData addObject:dict_blood[@"systolic"]];
    }else{
        [lateData addObject:@"0"];
        isEmptyMeasure = YES;
    }
    if (self.bloodpressureList.count != 0) {
        [lateData addObject:dict_blood[@"diastolic"]];
    }else{
        [lateData addObject:@"0"];
        isEmptyMeasure = YES;
    }
    if (self.temperatureList.count != 0) {
        [lateData addObject:dict_temperature[@"temperaturet"]];
    }else{
        [lateData addObject:@"0"];
        isEmptyMeasure = YES;
    }
    
    //label赋值
    NSArray *testDataArray = lateData;//@[@"129",@"87",@"38℃"];
    for (int i=0; i<self.labelArray.count; i++) {
        UILabel *label = self.labelArray[i];
        label.text = testDataArray[i];
    }
    //图片赋值
    if (isEmptyMeasure) {//空数据，待测
        self.imageV.image = [UIImage imageNamed:@"data_test"];
    }else{
        NSInteger maxP = [dict_blood[@"systolic"] integerValue];//高压
        NSInteger minP = [dict_blood[@"diastolic"] integerValue];//低压
        NSInteger temp = [dict_temperature[@"temperaturet"] integerValue];//体温
        if (temp>36&&temp<37.3&&maxP>90&&maxP<140&&minP>60&&minP<90){//正常
            self.imageV.image = [UIImage imageNamed:@"data_normal"];
        }else{//异常
            self.imageV.image = [UIImage imageNamed:@"data_abnormal"];
        }
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

