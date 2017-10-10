//
//  YYDataAnalyseViewController.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/3/1.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#define bLoodStr  @"半数以上以收缩压升高为主，即单纯收缩期高血压，收缩力≥140mmHg，舒张压＜90mmHg，此与老年人大动脉弹性减退、顺应性下降有关，使脉压增大。流行病学资料显示，单纯收缩压的升高也是心血管病致死的重要危险因素。"
#import "YYDataAnalyseViewController.h"
#import "UIColor+Extension.h"
#import <Masonry.h>
#import "YYTrendView.h"
#import "HttpClient.h"
#import <MJExtension.h>
#import "CcUserModel.h"
#import "YYHomeUserModel.h"

@interface YYDataAnalyseViewController ()<UIScrollViewDelegate>


@property (nonatomic, strong) UIScrollView *trendS;
@property (nonatomic, strong) UIView *bloodView;
@property (nonatomic, strong) UIView *temperature;
@property (nonatomic, weak) UIButton *bloodBtn;
@property (nonatomic, weak) UIButton *temperBtn;
@property (nonatomic, weak) UILabel *greenLabel;


@property (nonatomic, strong) NSMutableArray *bloodpressureList;
@property (nonatomic, strong) NSMutableArray *temperatureList;

@property (nonatomic, strong) NSArray *listlist;

@property (nonatomic, weak) YYTrendView *bloodpressureTrendView;
@property (nonatomic, weak) YYTrendView *temperatureTrendView;


@property (nonatomic, weak) UILabel *statusLabel;
@property (nonatomic, weak) UILabel *statusLabel_temperature;
@property (nonatomic, weak) UILabel *hihgBloodLabel;
@property (nonatomic, weak) UILabel *lowBloodLabel;
@property (nonatomic, weak) UILabel *temperatureLabel;

@end

@implementation YYDataAnalyseViewController
- (NSMutableArray *)temperatureList{
    if (_temperatureList == nil) {
        _temperatureList = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return _temperatureList;
}
- (NSMutableArray *)bloodpressureList{
    if (_bloodpressureList == nil) {
        _bloodpressureList = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return _bloodpressureList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的数据分析";
    [self createSubView];
    
    self.trendS = [[UIScrollView alloc]init];
    self.trendS.contentSize = CGSizeMake(kScreenW *2, kScreenH -64 -44);
    self.trendS.backgroundColor = [UIColor whiteColor];
    self.trendS.pagingEnabled = YES;
    self.trendS.showsHorizontalScrollIndicator = NO;
    self.trendS.delegate = self;
    
    
    [self.view addSubview: self.trendS];
    
    WS(ws);
    [self.trendS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view).with.offset(64 +44);
        make.left.equalTo(ws.view).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW ,kScreenH -64 -44));
    }];
    [self createTrendView];
    [self createTemperatureTrendView];
    [self httpRequest];
    // Do any additional setup after loading the view.
}
- (void)createSubView{
    UIButton *bloodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bloodBtn setTitleColor:[UIColor colorWithHexString:@"23f368"] forState:UIControlStateSelected];
    [bloodBtn setTitleColor:[UIColor colorWithHexString:@"6a6a6a"] forState:UIControlStateNormal];
    bloodBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [bloodBtn setTitle:@"血压" forState:UIControlStateNormal];
    [bloodBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    bloodBtn.selected = YES;
    
    UIButton *temperBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [temperBtn setTitleColor:[UIColor colorWithHexString:@"6a6a6a"] forState:UIControlStateNormal];
    [temperBtn setTitleColor:[UIColor colorWithHexString:@"23f368"] forState:UIControlStateSelected];
    temperBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [temperBtn setTitle:@"体温" forState:UIControlStateNormal];
    [temperBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *grayLine= [[UILabel alloc]init];
    grayLine.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    
    UILabel *greenLine = [[UILabel alloc]init];
    greenLine.backgroundColor = [UIColor colorWithHexString:@"23f368"];
    
    [self.view addSubview:bloodBtn];
    [self.view addSubview:temperBtn];
    [self.view addSubview:grayLine];
    [self.view addSubview:greenLine];
    
    self.bloodBtn = bloodBtn;
    self.temperBtn = temperBtn;
    self.greenLabel = greenLine;
    
    WS(ws);
    [bloodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view).with.offset(64);
        make.left.equalTo(ws.view).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW/2.0 ,44));
    }];
    [temperBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bloodBtn.mas_top).with.offset(0);
        make.left.equalTo(bloodBtn.mas_right).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW/2.0 ,44));
    }];
    
    [grayLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bloodBtn.mas_bottom).with.offset(0);
        make.left.equalTo(ws.view).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW ,0.5));
    }];
    
    [greenLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bloodBtn.mas_bottom).with.offset(0);
        make.left.equalTo(ws.view).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW/2.0 ,2));
    }];
    
    
    
}
- (void)createTrendView{
    self.bloodView = [[UIView alloc]init];
    //information View
    UIView *infoView = [[UIView alloc] init];
    infoView.backgroundColor = [UIColor whiteColor];
    
    NSArray *testDataArray = @[@"129",@"87",@"38℃"];
    NSArray *titleArray = @[@"收缩压(高压)",@"舒张压(低压)",@"体温"];
    NSString *statusTest = @"正常";
    
    
    CGFloat kLabelW = kScreenW /3.0;
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"normal_select"]];
    UILabel *statusLabel = [[UILabel alloc]init];
    statusLabel.text = statusTest;
    statusLabel.font = [UIFont systemFontOfSize:9];
    statusLabel.textColor = [UIColor colorWithHexString:@"25f368"];
    statusLabel.textAlignment = NSTextAlignmentCenter;
    
    [infoView addSubview:imageV];
    [infoView addSubview:statusLabel];
    self.statusLabel = statusLabel;
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoView).with.offset(26.5 *kiphone6);
        make.left.equalTo(infoView).with.offset((kLabelW -17*kiphone6) /2.0);
        make.size.mas_equalTo(CGSizeMake(17 *kiphone6, 17 *kiphone6));
    }];
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageV.mas_bottom).with.offset(5 *kiphone6);
        make.left.equalTo(infoView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(kLabelW, 9));
    }];
    
    
    
    
    for (int i = 0; i < 2; i++) {
        
        // data
        UILabel *test_banner = [[UILabel alloc]init];
        test_banner.text = testDataArray[i];
        test_banner.font = [UIFont systemFontOfSize:15];
        test_banner.textColor = [UIColor colorWithHexString:@"666666"];
        test_banner.textAlignment = NSTextAlignmentCenter;
        
        UILabel *label_banner = [[UILabel alloc]init];
        label_banner.text = titleArray[i];
        label_banner.font = [UIFont systemFontOfSize:9];
        label_banner.textColor = [UIColor colorWithHexString:@"cccccc"];
        label_banner.textAlignment = NSTextAlignmentCenter;
        
        //
        [infoView addSubview:test_banner];
        [infoView addSubview:label_banner];
        
        
        
        [test_banner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(infoView).with.offset(25 *kiphone6);
            make.left.equalTo(infoView).with.offset((i +1) *kLabelW);
            make.size.mas_equalTo(CGSizeMake(kLabelW *kiphone6, 15));
        }];
        [label_banner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(test_banner.mas_bottom).with.offset(10 *kiphone6);
            make.left.equalTo(test_banner);
            make.size.mas_equalTo(CGSizeMake(kLabelW *kiphone6 , 9));
        }];
        if (i == 0) {
            self.hihgBloodLabel = test_banner;
        }else{
            self.lowBloodLabel = test_banner;
        }
        
    }

    [self.bloodView addSubview:infoView];

    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bloodView).with.offset(0 *kiphone6);
        make.left.equalTo(self.bloodView).with.offset(0 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 84 *kiphone6));
    }];
    
    YYTrendView *trendView = [[YYTrendView alloc]init];
    trendView.layer.cornerRadius = 5;
    trendView.clipsToBounds = YES;
    trendView.backgroundColor = [UIColor colorWithHexString:@"8bfad4"];
    
    [self.bloodView addSubview:trendView];
    self.bloodpressureTrendView = trendView;
    [trendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoView.mas_bottom).with.offset(0 *kiphone6);
        make.left.equalTo(self.bloodView).with.offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(kScreenW -20, 270 *kiphone6));
    }];
    
    UILabel *greenLabel = [[UILabel alloc]init];
    greenLabel.backgroundColor = [UIColor colorWithHexString:@"25f368"];
    
    [self.bloodView addSubview:greenLabel];
    [greenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(trendView.mas_bottom).with.offset(30 *kiphone6);
        make.left.equalTo(self.bloodView).with.offset(20 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(3, 11));
    }];
    
    
    UILabel *promptLabel = [[UILabel alloc]init];
    //promptLabel.text = @"正常人体温一般为36～37\n发热分为：\n低热37.3～38";
    promptLabel.numberOfLines = 0;
    promptLabel.textColor = [UIColor colorWithHexString:@"6a6a6a"];
    promptLabel.font = [UIFont systemFontOfSize:11];
    //////////////
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:bLoodStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [bLoodStr length])];
    promptLabel.attributedText = attributedString;
    ;
//    [promptLabel sizeToFit];
    //////////////
    
    [self.bloodView addSubview:promptLabel];
    
    [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(trendView.mas_bottom).with.offset(20 *kiphone6);
        make.left.equalTo(greenLabel.mas_right).with.offset(7 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(kScreenW -50, 77 *kiphone6));
    }];
    

    
    [self.trendS addSubview:self.bloodView];
    [self.bloodView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.trendS).with.offset(0);
        make.left.equalTo(self.trendS).with.offset(0 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(kScreenW *kiphone6, kScreenH - 64 -44));
    }];
    
}
- (void)createTemperatureTrendView{
    self.temperature = [[UIView alloc]init];
    //information View
    UIView *infoView = [[UIView alloc] init];
    infoView.backgroundColor = [UIColor whiteColor];
    
    NSArray *testDataArray = @[@"38℃"];
    NSArray *titleArray = @[@"体温"];
    NSString *statusTest = @"正常";
    
    
    CGFloat kLabelW = kScreenW /2.0;
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"normal_select"]];
    UILabel *statusLabel = [[UILabel alloc]init];
    statusLabel.text = statusTest;
    statusLabel.font = [UIFont systemFontOfSize:9];
    statusLabel.textColor = [UIColor colorWithHexString:@"25f368"];
    statusLabel.textAlignment = NSTextAlignmentCenter;
    self.statusLabel_temperature = statusLabel;
    [infoView addSubview:imageV];
    [infoView addSubview:statusLabel];
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoView).with.offset(26.5 *kiphone6);
        make.left.equalTo(infoView).with.offset((kLabelW -17*kiphone6) /2.0);
        make.size.mas_equalTo(CGSizeMake(17 *kiphone6, 17 *kiphone6));
    }];
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageV.mas_bottom).with.offset(5 *kiphone6);
        make.left.equalTo(infoView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(kLabelW, 9));
    }];
    
    
    
    
    for (int i = 0; i < 1; i++) {
        
        // data
        UILabel *test_banner = [[UILabel alloc]init];
        test_banner.text = testDataArray[i];
        test_banner.font = [UIFont systemFontOfSize:15];
        test_banner.textColor = [UIColor colorWithHexString:@"666666"];
        test_banner.textAlignment = NSTextAlignmentCenter;
        
        UILabel *label_banner = [[UILabel alloc]init];
        label_banner.text = titleArray[i];
        label_banner.font = [UIFont systemFontOfSize:9];
        label_banner.textColor = [UIColor colorWithHexString:@"cccccc"];
        label_banner.textAlignment = NSTextAlignmentCenter;
        
        //
        [infoView addSubview:test_banner];
        [infoView addSubview:label_banner];
        self.temperatureLabel = test_banner;
        
        
        [test_banner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(infoView).with.offset(25 *kiphone6);
            make.left.equalTo(infoView).with.offset((i +1) *kLabelW);
            make.size.mas_equalTo(CGSizeMake(kLabelW *kiphone6, 15));
        }];
        [label_banner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(test_banner.mas_bottom).with.offset(10 *kiphone6);
            make.left.equalTo(test_banner);
            make.size.mas_equalTo(CGSizeMake(kLabelW *kiphone6 , 9));
        }];
        
        
    }
    
    [self.temperature addSubview:infoView];
    
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.temperature).with.offset(0 *kiphone6);
        make.left.equalTo(self.temperature).with.offset(0 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 84 *kiphone6));
    }];
    
    YYTrendView *trendView = [[YYTrendView alloc]init];
    trendView.layer.cornerRadius = 5;
    trendView.clipsToBounds = YES;
    trendView.backgroundColor = [UIColor colorWithHexString:@"8bfad4"];
    
    [self.temperature addSubview:trendView];
    self.temperatureTrendView = trendView;
    
    [trendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoView.mas_bottom).with.offset(0 *kiphone6);
        make.left.equalTo(self.temperature).with.offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(kScreenW -20, 270 *kiphone6));
    }];
    
    UILabel *greenLabel = [[UILabel alloc]init];
    greenLabel.backgroundColor = [UIColor colorWithHexString:@"25f368"];
    
    [self.temperature addSubview:greenLabel];
    [greenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(trendView.mas_bottom).with.offset(30 *kiphone6);
        make.left.equalTo(self.temperature).with.offset(20 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(3, 11));
    }];
    
    
    UILabel *promptLabel = [[UILabel alloc]init];
    //promptLabel.text = @"正常人体温一般为36～37\n发热分为：\n低热37.3～38";
    promptLabel.numberOfLines = 0;
    promptLabel.textColor = [UIColor colorWithHexString:@"6a6a6a"];
    promptLabel.font = [UIFont systemFontOfSize:11];
    //////////////
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"正常人体温一般为36～37℃\n发热分为：\n低热37.3～38℃"];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [@"正常人体温一般为36～37℃\n发热分为：\n低热37.3～38℃" length])];
    promptLabel.attributedText = attributedString;
    ;
    [promptLabel sizeToFit];
    //////////////
    
    [self.temperature addSubview:promptLabel];
    
    [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(trendView.mas_bottom).with.offset(30 *kiphone6);
        make.left.equalTo(greenLabel.mas_right).with.offset(7 *kiphone6);
        //        make.size.mas_equalTo(CGSizeMake(kScreenW -20, 100 *kiphone6));
    }];
    
    
    
    [self.trendS addSubview:self.temperature];
    [self.temperature mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.trendS).with.offset(0);
        make.left.equalTo(self.trendS).with.offset(kScreenW);
        make.size.mas_equalTo(CGSizeMake(kScreenW *kiphone6, kScreenH - 64 -44));
    }];
    
}

- (void)buttonClick:(UIButton *)sender{

    if ([sender.currentTitle isEqualToString:@"血压"]) {
        self.bloodBtn.selected = YES;
        self.temperBtn.selected = NO;

        
        [UIView animateWithDuration:0.3f animations:^{
            self.trendS.contentOffset = CGPointMake(0, 0);
            self.greenLabel.frame = CGRectMake(0, 64+42, kScreenW/2.0, 2);
        }];
    }else{

        self.bloodBtn.selected = NO;
        self.temperBtn.selected = YES;
        
        [UIView animateWithDuration:0.3f animations:^{
            self.trendS.contentOffset = CGPointMake(kScreenW, 0);
            self.greenLabel.frame = CGRectMake(kScreenW/2.0, 64+42, kScreenW/2.0, 2);
        }];
    }
}
- (void)httpRequest{
    
    CcUserModel *userModel = [CcUserModel defaultClient];
    [[HttpClient defaultClient]requestWithPath:[NSString stringWithFormat:@"%@token=%@&humeuserId=%@",mHomeuserMeasure,userModel.userToken,self.userHome_id] method:0 parameters:nil prepareExecute:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *result = responseObject[@"result"];
        YYHomeUserModel *userModel = [YYHomeUserModel mj_objectWithKeyValues:result];
        self.temperatureList = [userModel.temperatureList mutableCopy];
        self.bloodpressureList = [userModel.bloodpressureList mutableCopy];
        NSMutableArray *highBlood = [[NSMutableArray alloc]initWithCapacity:2];
        NSMutableArray *lowBlood = [[NSMutableArray alloc]initWithCapacity:2];
        NSMutableArray *measureDate = [[NSMutableArray alloc]initWithCapacity:2];
        for (NSDictionary *dict  in userModel.bloodpressureList) {
            NSString *str_high = dict[@"systolic"];
            NSString *str_low = dict[@"diastolic"];
            NSString *str_date = dict[@"createTimeString"];
            [highBlood addObject:[NSNumber numberWithFloat:[str_high floatValue]]];
            [lowBlood addObject:[NSNumber numberWithFloat:[str_low floatValue]]];
            [measureDate addObject:str_date];
        }
        [self.bloodpressureTrendView updateBloodTrendDataList:highBlood lowList:lowBlood dateList:measureDate];
        [self.temperatureTrendView updateTempatureTrendDataList:self.temperatureList];
        
        
        // 刷新显示数据
        NSMutableArray *lateData = [[NSMutableArray alloc]initWithCapacity:2];
        
        
        NSDictionary* dict_blood =  self.bloodpressureList.lastObject;
        NSDictionary* dict_temperature =  self.temperatureList.lastObject;
        
        BOOL isEmptyMeasure = NO;
        
        if (self.bloodpressureList.count != 0) {
            [lateData addObject:[NSString stringWithFormat:@"%@",dict_blood[@"systolic"]]];
        }else{
            [lateData addObject:@"0"];
            isEmptyMeasure = YES;
        }
        if (self.bloodpressureList.count != 0) {
            [lateData addObject:[NSString stringWithFormat:@"%@",dict_blood[@"diastolic"]]];
        }else{
            [lateData addObject:@"0"];
            isEmptyMeasure = YES;
        }
        if (self.temperatureList.count != 0) {
            self.statusLabel_temperature.text = @"正常";
            [lateData addObject:[NSString stringWithFormat:@"%@",dict_temperature[@"temperaturet"]]];
        }else{
            [lateData addObject:@"0"];
            self.statusLabel_temperature.text = @"待测";
        }
        
        
        self.hihgBloodLabel.text = lateData[0];
        self.lowBloodLabel.text = lateData[1];
        self.temperatureLabel.text = lateData[2];
        if (isEmptyMeasure) {
            self.statusLabel.text = @"待测";
        }else{
            self.statusLabel.text = @"正常";
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark -
#pragma mark ------------scroll delegate----------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //更新UIPageControl的当前页
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    if (offset.x / bounds.size.width) {
        [self buttonClick:self.temperBtn];
    }else{
        [self buttonClick:self.bloodBtn];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
