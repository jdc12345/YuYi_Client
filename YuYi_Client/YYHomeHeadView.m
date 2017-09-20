//
//  YYHomeHeadView.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/17.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//dasdasdas

#import "YYHomeHeadView.h"
#import <SDCycleScrollView.h>
#import <Masonry.h>
#import "UIColor+Extension.h"
#import "YYTrendView.h"
#import "ZYPageControl.h"
#import "HttpClient.h"
#import "YYHeadViewModel.h"
#import <MJExtension.h>
#import "CcUserModel.h"
#import "YYHomeUserModel.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <UIImage+AFNetworking.h>
#import "YYFamilyAccountViewController.h"
@interface YYHomeHeadView()<UIScrollViewDelegate, SDCycleScrollViewDelegate>
@property (nonatomic, assign)CGFloat maxY;

//@property (nonatomic, strong) ZYPageControl *pageCtrl;
@property (nonatomic, strong) NSMutableArray *imagesList;//轮播器图片数据
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView2;//轮播器

@property (nonatomic, strong) NSMutableArray *userList;//用户列表
@property (nonatomic, strong) NSMutableArray *bloodpressureList;//当前用户血压数据集
@property (nonatomic, strong) NSMutableArray *temperatureList;//当前用户体温数据集

//@property (nonatomic, strong) NSArray *listlist;

@property (nonatomic, weak) YYTrendView *bloodpressureTrendView;//当前用户血压图表
@property (nonatomic, weak) YYTrendView *temperatureTrendView;//当前用户体温图表
@property (nonatomic, weak) UILabel *statusLabel;
@property (nonatomic, weak) UIImageView *imageV;//数据是否正常图片
@property (nonatomic, strong) UIView *iconBanner;//用户图像列表

@property (nonatomic, assign) BOOL isFull;//是否达到最多的六个人
@property (nonatomic, strong) NSMutableArray *labelArray;//显示当前用户高低压和体温的label集

//@property (nonatomic, assign) NSInteger userCount;
@property (nonatomic, strong) YYHomeUserModel *curruntUserModel;//当前用户数据

@end

@implementation YYHomeHeadView
- (NSMutableArray *)imagesList{
    if (_imagesList == nil) {
        _imagesList = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return _imagesList;
}
- (NSMutableArray *)userList{
    if (_userList == nil) {
        _userList = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return _userList;
}
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
- (NSMutableArray *)labelArray{
    if (_labelArray == nil) {
        _labelArray = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return _labelArray;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"123123123");
        
        self.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
        
        self.userInteractionEnabled = YES;
         self.frame = CGRectMake(0, 0, kScreenW, 740 *kiphone6);
        self.isFull = NO;
        [self httpRequestForUser];
    }
    return self;
}
// 首页用户列表和测量数据(该接口只返回第一个人的具体测量数据，其他人的需要单独请求)
- (void)httpRequestForUser{
    
    // 用户列表
    NSString *tokenStr = [CcUserModel defaultClient].userToken;
    [[HttpClient defaultClient]requestWithPath:[NSString stringWithFormat:@"%@token=%@",mUserAndMeasureInfo,tokenStr] method:0 parameters:nil prepareExecute:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        // app版本
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        // app build版本
        NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
        
        NSString *app_AllVersion = [NSString stringWithFormat:@"%@.%@",app_Version,app_build];
        CcUserModel *ccModel = [CcUserModel defaultClient];
        NSLog(@"我要改的接口%@ ,%@%@",responseObject,app_Version,app_build);
        if ([responseObject[@"isPending"] isEqualToString:@"1"] && [responseObject[@"version"] isEqualToString:app_AllVersion]) {
            ccModel.isPending = @"1";
            NSLog(@"正在审核");
        }
        
        [self.userList removeAllObjects];
        NSArray *result = responseObject[@"result"];
        for (NSDictionary *dict in result) {
            YYHomeUserModel *userModel = [YYHomeUserModel mj_objectWithKeyValues:dict];
            [self.userList addObject:userModel];
        }
        if (self.userList.count == 6) {
            self.isFull = YES;
        }else{
            self.isFull = NO;
        }
        YYHomeUserModel *userModel;
        if (self.userList.count >0&&!self.curruntUserModel){//第一次加载
            userModel = self.userList[0];
            self.curruntUserModel = userModel;
        }else if(self.userList.count >0&&self.curruntUserModel){//刷新
            for (YYHomeUserModel *uModel in self.userList) {
                if ([uModel.info_id isEqualToString:self.curruntUserModel.info_id]) {
                    userModel = self.curruntUserModel;
                }
            }
        }
        
        //        self.bloodpressureList = userModel.bloodpressureList;
        self.temperatureList = [NSMutableArray arrayWithArray:userModel.temperatureList];
        //
        self.bloodpressureList = [NSMutableArray arrayWithArray:userModel.bloodpressureList];
        
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
        
        if (self.bloodpressureTrendView) {//页面重新出现时候
            [self refreshIconBanner];//更新用户列表
        }else{
            [self setViewInHead];//布局UI
            [self httpRequest];//请求轮播图数据
        }
        [self.bloodpressureTrendView updateBloodTrendDataList:highBlood lowList:lowBlood dateList:measureDate];
        [self.temperatureTrendView updateTempatureTrendDataList:self.temperatureList];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
- (void)setViewInHead{
    WS(ws);
    // 图片轮播器
    SDCycleScrollView *cycleScrollView2 = [[SDCycleScrollView alloc]init];
    cycleScrollView2.showPageControl = YES;
    cycleScrollView2.delegate = self;
//    cycleScrollView2.imageURLStringsGroup  = self.listlist;
   
    self.cycleScrollView2 = cycleScrollView2;
    
    // 按钮banner
    UIView *bannerView = [[UIView alloc]init];
    bannerView.backgroundColor = [UIColor whiteColor];
    
    NSArray *butArray = @[@"firstPage_registration",@"firstPage_drug"];
    NSArray *labelArray = @[@"预约挂号",@"我的药品"];
    CcUserModel *ccModel = [CcUserModel defaultClient];
    for (int i = 0; i <2; i++) {
        
        // icon
        UIButton *button_banner = [UIButton buttonWithType:UIButtonTypeCustom];
        [button_banner setBackgroundImage:[UIImage imageNamed:butArray[i]] forState:UIControlStateNormal];
        button_banner.tag = i +130;
        [button_banner addTarget:self action:@selector(bannerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        // title
        UILabel *label_banner = [[UILabel alloc]init];
        label_banner.text = labelArray[i];
        label_banner.font = [UIFont systemFontOfSize:14];
        label_banner.textColor = [UIColor colorWithHexString:@"6a6a6a"];
        label_banner.textAlignment = NSTextAlignmentCenter;
        
        //
        [bannerView addSubview:button_banner];
        [bannerView addSubview:label_banner];
        if ([ccModel.isPending isEqualToString:@"1"]) {
            button_banner.hidden = YES;
            label_banner.hidden = YES;
        }
        //
        CGFloat x_padding = 0;                              // 偏移量
        if (i == 1) {
            x_padding = kScreenW /2.0;
        }
        [button_banner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(12 *kiphone6);
            make.left.offset((kScreenW - 65 *2 *kiphone6)/4.0 +x_padding );
            make.size.mas_equalTo(CGSizeMake(65 *kiphone6, 65 *kiphone6));
        }];
        [label_banner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button_banner.mas_bottom).offset(10 *kiphone6);
            make.left.offset((kScreenW - 65 *2 *kiphone6)/4.0 +x_padding );
            make.size.mas_equalTo(CGSizeMake(65*kiphone6 , 14));
        }];
    }
    // banner中间分割线
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    [bannerView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(10*kiphone6);
        make.bottom.offset(-10*kiphone6);
        make.width.offset(1/[UIScreen mainScreen].scale);
    }];
    // 用户icon banner
    UIView *iconBanner = [[UIView alloc]init];
    self.iconBanner = iconBanner;
    iconBanner.backgroundColor = [UIColor whiteColor];
    iconBanner.userInteractionEnabled = YES;
    
    if (self.userList.count < 6) {
        YYHomeUserModel *addModel = [[YYHomeUserModel alloc]init];
        addModel.avatar = @"firstPage_add";
        addModel.trueName = @"";
        [self.userList addObject:addModel];
    }
//    NSInteger userCount = self.userList.count -1;
    for (int i = 0; i < self.userList.count; i++) {
//        if (i != userCount) {
            YYHomeUserModel *userModel = self.userList[i];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mPrefixUrl,userModel.avatar]];
//        UIImage *icon_user = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    
        // icon
            
        UIImageView *button_banner = [[UIImageView alloc]init];
        button_banner.userInteractionEnabled = YES;
        button_banner.tag = 140 +i;
        
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeUserData:)];
        
        [button_banner addGestureRecognizer:tapGest];
        if (i == self.userList.count -1 && !self.isFull) {
            button_banner.image = [UIImage  imageNamed:userModel.avatar];
        }else{
            [button_banner sd_setImageWithURL:url];
        }
        button_banner.layer.cornerRadius = 35/2.0*kiphone6;
        button_banner.clipsToBounds = YES;
        
        
        // title
        UILabel *label_banner = [[UILabel alloc]init];
        label_banner.text = userModel.trueName;
        label_banner.font = [UIFont systemFontOfSize:10];
        label_banner.tag = 150+i;
        //
        [iconBanner addSubview:button_banner];
        [iconBanner addSubview:label_banner];

        CGFloat x_padding = (kScreenW -35*(self.userList.count) -25*(self.userList.count -1)-12)/2.0 +60*(i) -17.5+12;
        if (![userModel.info_id isEqualToString:self.curruntUserModel.info_id]) {
            label_banner.textColor = [UIColor whiteColor];
            [button_banner mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(15 *kiphone6);
                make.left.offset(x_padding);
                make.size.mas_equalTo(CGSizeMake(35 *kiphone6, 35 *kiphone6));
            }];
        }else{//处于当前选中的用户头像
            label_banner.textColor = [UIColor colorWithHexString:@"1dbeec"];
            button_banner.layer.cornerRadius = 23.5*kiphone6;
            [button_banner mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(9 *kiphone6);
                make.left.offset(x_padding);
                make.size.mas_equalTo(CGSizeMake(47 *kiphone6, 47 *kiphone6));
            }];
        }
        [label_banner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button_banner.mas_bottom).with.offset(5 *kiphone6);
            make.centerX.equalTo(button_banner);
        }];
            label_banner.textAlignment = NSTextAlignmentCenter;
        
        //
//        CGFloat x_padding = (20 +35) *kiphone6;                              // 偏移量
//        if ((self.userList.count) %2 == 0) {
//            x_padding = kScreenW /2.0 - (37 +10) *kiphone6 *(self.userList.count)/2.0 + i *(37 +20) *kiphone6;
//        }else{
//            x_padding = kScreenW /2.0 - (37 +20) *kiphone6 *(self.userList.count)/2.0 + i *(37 +20) *kiphone6;
//        }
        
        
        }
//    }
    
    //information View
    UIView *infoView = [[UIView alloc] init];
    infoView.backgroundColor = [UIColor whiteColor];
    
    
    NSArray *titleArray = @[@"收缩压(高压)",@"舒张压(低压)",@"体温"];
//    NSString *statusTest = @"正常";
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
    
//    if (self.temperatureList.count != 0) {
//        [lateData addObject:dict_temperature[@"temperaturet"]];
//    }else{
//        [lateData addObject:@"0"];
//        isEmptyMeasure = YES;
//    }
//    if (self.bloodpressureList.count != 0) {
//        [lateData addObject:dict_blood[@"systolic"]];//收缩压
//    }else{
//        [lateData addObject:@"0"];
//    }
//    if (self.bloodpressureList.count != 0) {
//        [lateData addObject:dict_blood[@"diastolic"]];//舒张压
//    }else{
//        [lateData addObject:@"0"];
//    }
//    if (self.temperatureList.count != 0) {
//        [lateData addObject:dict_temperature[@"temperaturet"]];
//    }else{
//        [lateData addObject:@"0"];
//    }
    
   
    NSArray *testDataArray = lateData;//@[@"129",@"87",@"38℃"];

 
    CGFloat kLabelW = kScreenW /4.0;
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"data_normal"]];
    self.imageV = imageV;
    if (isEmptyMeasure) {
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
//    imageV.backgroundColor = [UIColor colorWithHexString:@"1bdeec"];
//    imageV.layer.masksToBounds = true;
//    imageV.layer.cornerRadius = 20*kiphone6;
//    UILabel *statusLabel = [[UILabel alloc]init];
//    statusLabel.text = statusTest;
//    statusLabel.font = [UIFont systemFontOfSize:13];
//    statusLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
//    statusLabel.textAlignment = NSTextAlignmentCenter;
//    
//    self.statusLabel = statusLabel;
    [infoView addSubview:imageV];
//    [imageV addSubview:statusLabel];
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset((kLabelW -40*kiphone6) /2.0);
        make.size.mas_equalTo(CGSizeMake(40 *kiphone6, 40 *kiphone6));
    }];
//    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.offset(0);
//    }];
    
  
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
    
    //..邪恶的分割线
//    UILabel *lineL = [[UILabel alloc]init];
//    lineL.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
//    
//    UILabel *lineL_bottom = [[UILabel alloc]init];
//    lineL_bottom.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
//    
//    [infoView addSubview:lineL];
//    [infoView addSubview:lineL_bottom];
//    
//    [lineL mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(infoView);
//        make.left.equalTo(infoView).with.offset(20 *kiphone6);
//        make.size.mas_equalTo(CGSizeMake(kScreenW -40 *kiphone6, 1));
//    }];
//    [lineL_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(infoView);
//        make.left.equalTo(infoView).with.offset(20 *kiphone6);
//        make.size.mas_equalTo(CGSizeMake(kScreenW - 40 *kiphone6, 1));
//    }];
    
    // TrendView
    UIScrollView *scrollTrendView = [[UIScrollView alloc]init];
    scrollTrendView.contentSize = CGSizeMake(kScreenW *2, 290 *kiphone6);
    scrollTrendView.backgroundColor = [UIColor whiteColor];
    scrollTrendView.pagingEnabled = YES;
    scrollTrendView.showsHorizontalScrollIndicator = NO;
    scrollTrendView.delegate = self;
    
    
    YYTrendView *trendView = [[YYTrendView alloc]init];
//    trendView.layer.cornerRadius = 5;
//    trendView.clipsToBounds = YES;
    trendView.backgroundColor = [UIColor colorWithHexString:@"30323a"];
    
    YYTrendView *temperature_TrendView = [[YYTrendView alloc]init];
//    temperature_TrendView.layer.cornerRadius = 5;
//    temperature_TrendView.clipsToBounds = YES;
    temperature_TrendView.backgroundColor = [UIColor colorWithHexString:@"30323a"];
    
    [scrollTrendView addSubview:trendView];
    [scrollTrendView addSubview:temperature_TrendView];
    self.bloodpressureTrendView = trendView;
    self.temperatureTrendView = temperature_TrendView;
    
    [trendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(10*kiphone6);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 290 *kiphone6));
    }];
    [temperature_TrendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10*kiphone6);
        make.left.offset(kScreenW);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 290 *kiphone6));
    }];
    //创建UIPageControl
//    _pageCtrl = [[ZYPageControl alloc] init];  //创建UIPageControl，位置在下方。
//    _pageCtrl.numberOfPages = 2;//总的图片页数
//    _pageCtrl.currentPage = 0; //当前页
//    _pageCtrl.dotImage = [UIImage imageNamed:@"pageControl-normal"];
//    _pageCtrl.currentDotImage = [UIImage imageNamed:@"pageControl-select"];
//    _pageCtrl.dotSize = CGSizeMake(15, 5);
//    [_pageCtrl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];  //用户点击UIPageControl的响应函数
  
    //
    [self addSubview:cycleScrollView2];
    [self addSubview:bannerView];
    [self addSubview:iconBanner];
    [self addSubview:infoView];
    [self addSubview:scrollTrendView];
//    [self addSubview:_pageCtrl];
    
    
    // 页面自动布局
    [cycleScrollView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 175 *kiphone6));
    }];
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cycleScrollView2.mas_bottom).with.offset(10*kiphone6);
        make.left.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 110 *kiphone6));
    }];
    [iconBanner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bannerView.mas_bottom).with.offset(10*kiphone6);
        make.left.equalTo(ws).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 77 *kiphone6));
    }];
    [scrollTrendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconBanner.mas_bottom);
        make.left.equalTo(ws).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 300 *kiphone6));
    }];
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollTrendView.mas_bottom).with.offset(0);
        make.left.equalTo(ws).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 70 *kiphone6));
    }];
//    [scrollTrendView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(infoView.mas_bottom).with.offset(0);
//        make.left.equalTo(ws).with.offset(0);
//        make.size.mas_equalTo(CGSizeMake(kScreenW, 300 *kiphone6));
//    }];
//    [_pageCtrl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(scrollTrendView).with.offset(0);
//        make.centerX.equalTo(ws.mas_centerX).with.offset(20 *kiphone6);
//        make.size.mas_equalTo(CGSizeMake(40 *kiphone6, 10 *kiphone6));
//    }];
    
//    [self bringSubviewToFront:_pageCtrl];
    
}
- (void)pageTurn:(UIPageControl*)sender
{
    //令UIScrollView做出相应的滑动显示
//    CGSize viewSize = helpScrView.frame.size;
//    CGRect rect = CGRectMake(sender.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
//    [helpScrView scrollRectToVisible:rect animated:YES];
}
#pragma mark -
#pragma mark ------------scroll delegate----------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //更新UIPageControl的当前页
//    CGPoint offset = scrollView.contentOffset;
//    CGRect bounds = scrollView.frame;
//    [_pageCtrl setCurrentPage:offset.x / bounds.size.width];
}

#pragma mark -
#pragma mark ------------banner button----------------------
- (void)bannerButtonClick:(UIButton *)sender{
    if (sender.tag == 130) {
        NSLog(@"我的药品");
        self.bannerClick(NO);
    }else{
        NSLog(@"预约挂号");
        self.bannerClick(YES);
    }
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    YYHeadViewModel *headModel = self.imagesList [index];
    self.itemClick(headModel.info_id);
}
//请求轮播图数据
- (void)httpRequest{
    [[HttpClient defaultClient]requestWithPath:mHomepageImages method:0 parameters:nil prepareExecute:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = responseObject[@"result"][@"rows"];
        NSMutableArray *imageList = [[NSMutableArray alloc]initWithCapacity:2];
        for (NSDictionary *dict in array) {
            YYHeadViewModel *headModel = [YYHeadViewModel mj_objectWithKeyValues:dict];
            [self.imagesList addObject:headModel];
            
            [imageList addObject:[NSString stringWithFormat:@"%@%@",mPrefixUrl,headModel.picture]];
        }
        
        self.cycleScrollView2.imageURLStringsGroup  = imageList;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

//点击用户头像手势事件
- (void)changeUserData:(UITapGestureRecognizer *)tapGest{
   
    NSInteger labelTag = (tapGest.view.tag+10);
    if(labelTag == 149 +self.userList.count &&!self.isFull){//点击的是添加按钮
        self.addFamily(@"addFamily");
    }else{
    UILabel *label = (UILabel *)[self.iconBanner viewWithTag:labelTag];
    if(![label.textColor isEqual:[UIColor colorWithHexString:@"1dbeec"]]){//点击的view不是当前显示的用户的头像
        for (int i = 0; i<self.userList.count -1 ; i++) {
            UILabel *label2 = (UILabel *)[self.iconBanner viewWithTag:150 +i];
            UIImageView *iconView = (UIImageView *)[self.iconBanner viewWithTag:140 +i];
            if (labelTag == label2.tag) {//点击的用户
                label2.textColor = [UIColor colorWithHexString:@"1dbeec"];
                iconView.layer.cornerRadius = 23.5*kiphone6;
                [iconView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.height.offset(47*kiphone6);
                    make.top.offset(9*kiphone6);
                }];
                
            }
            else{
                label2.textColor = [UIColor whiteColor];
                iconView.layer.cornerRadius = 17.5*kiphone6;
                [iconView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.height.offset(35*kiphone6);
                    make.top.offset(15*kiphone6);
                }];
            }
        }
        // 更改数据。http://192.168.1.55:8081/yuyi/homeuser/findOne.do?token=6DD620E22A92AB0AED590DB66F84D064&humeuserId=10
        YYHomeUserModel *userModel =  self.userList[labelTag - 150];
        NSString *tokenStr = [CcUserModel defaultClient].userToken;
        [[HttpClient defaultClient]requestWithPath:[NSString stringWithFormat:@"%@token=%@&humeuserId=%@",mHomeuserMeasure,tokenStr,userModel.info_id] method:0 parameters:nil prepareExecute:^{
            
        } success:^(NSURLSessionDataTask *task, id responseObject) {
//            NSLog(@"%@",responseObject);

            // 刷新走势图
            NSDictionary *result = responseObject[@"result"];
            YYHomeUserModel *userModel = [YYHomeUserModel mj_objectWithKeyValues:result];
            self.curruntUserModel = userModel;//更换当前用户数据模型
            self.temperatureList = [NSMutableArray arrayWithArray:userModel.temperatureList];
            self.bloodpressureList = [NSMutableArray arrayWithArray:userModel.bloodpressureList];
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
            if (isEmptyMeasure) {
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
            for(int i = 0 ; i<3 ;i++){
               UILabel *label = self.labelArray[i];
                label.text = [NSString stringWithFormat:@"%@",lateData[i]];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    }
}
//公开的方法,在父view切换时候会调用
- (void)refreshThisView{
    [self httpRequestForUser];
}
//刷新用户列表view
- (void)refreshIconBanner{
    NSArray *subViews = [self.iconBanner subviews];

    for (UIView *view in subViews) {
        [view removeFromSuperview];
    }
    UIView *iconBanner = self.iconBanner;
//    self.iconBanner = iconBanner;
//    iconBanner.backgroundColor = [UIColor whiteColor];
//    iconBanner.userInteractionEnabled = YES;
    if (self.userList.count < 6) {
        YYHomeUserModel *addModel = [[YYHomeUserModel alloc]init];
        addModel.avatar = @"firstPage_add";
        addModel.trueName = @"";
        [self.userList addObject:addModel];
    }

    NSInteger userCount = self.userList.count -1;
    for (int i = 0; i < userCount+1; i++) {
        //        if (i != userCount) {
        YYHomeUserModel *userModel = self.userList[i];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mPrefixUrl,userModel.avatar]];
        //        UIImage *icon_user = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        
        // icon
        
        UIImageView *button_banner = [[UIImageView alloc]init];
        button_banner.userInteractionEnabled = YES;
        button_banner.tag = 140 +i;
        
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeUserData:)];
        
        [button_banner addGestureRecognizer:tapGest];
        if (i == self.userList.count -1 && !self.isFull) {//加号按钮
            button_banner.image = [UIImage  imageNamed:userModel.avatar];
        }else{
            [button_banner sd_setImageWithURL:url];
        }
        button_banner.layer.cornerRadius = 35/2.0*kiphone6;
        button_banner.clipsToBounds = YES;
        
        
        // title
        UILabel *label_banner = [[UILabel alloc]init];
        label_banner.text = userModel.trueName;
        label_banner.font = [UIFont systemFontOfSize:10];
        label_banner.tag = 150+i;
        //
        [iconBanner addSubview:button_banner];
        [iconBanner addSubview:label_banner];
        
        CGFloat x_padding = (kScreenW -35*(self.userList.count) -25*(self.userList.count -1)-12)/2.0 +60*(i) -17.5+12;
        if (![userModel.info_id isEqualToString:self.curruntUserModel.info_id]) {
            label_banner.textColor = [UIColor whiteColor];
            [button_banner mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(15 *kiphone6);
                make.left.offset(x_padding);
                make.size.mas_equalTo(CGSizeMake(35 *kiphone6, 35 *kiphone6));
            }];
        }else{//处于当前选中的用户头像
            label_banner.textColor = [UIColor colorWithHexString:@"1dbeec"];
            button_banner.layer.cornerRadius = 23.5*kiphone6;
            [button_banner mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(9 *kiphone6);
                make.left.offset(x_padding);
                make.size.mas_equalTo(CGSizeMake(47 *kiphone6, 47 *kiphone6));
            }];
        }
        [label_banner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button_banner.mas_bottom).with.offset(5 *kiphone6);
            make.centerX.equalTo(button_banner);
        }];
        label_banner.textAlignment = NSTextAlignmentCenter;
}
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
