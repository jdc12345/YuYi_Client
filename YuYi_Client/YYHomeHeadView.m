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

@property (nonatomic, strong) ZYPageControl *pageCtrl;
@property (nonatomic, strong) NSMutableArray *imagesList;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView2;

@property (nonatomic, strong) NSMutableArray *userList;
@property (nonatomic, strong) NSMutableArray *bloodpressureList;
@property (nonatomic, strong) NSMutableArray *temperatureList;

@property (nonatomic, strong) NSArray *listlist;

@property (nonatomic, weak) YYTrendView *bloodpressureTrendView;
@property (nonatomic, weak) YYTrendView *temperatureTrendView;
@property (nonatomic, weak) UILabel *statusLabel;

@property (nonatomic, strong) UIView *iconBanner;

@property (nonatomic, assign) BOOL isFull;
@property (nonatomic, strong) NSMutableArray *labelArray;

//@property (nonatomic, assign) NSInteger userCount;


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
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.userInteractionEnabled = YES;
         self.frame = CGRectMake(0, 0, kScreenW, 732 *kiphone6);
        self.isFull = NO;
        [self httpRequestForUser];
    }
    return self;
}

- (void)setViewInHead{
    WS(ws);
    // 图片轮播器
    SDCycleScrollView *cycleScrollView2 = [[SDCycleScrollView alloc]init];
    cycleScrollView2.showPageControl = YES;
    cycleScrollView2.delegate = self;
    cycleScrollView2.imageURLStringsGroup  = self.listlist;
   
    self.cycleScrollView2 = cycleScrollView2;
    
    // 按钮banner
    UIView *bannerView = [[UIView alloc]init];
    bannerView.backgroundColor = [UIColor whiteColor];
    
    NSArray *butArray = @[@"shopmall_select",@"appointment"];
    NSArray *labelArray = @[@"我的药品",@"预约挂号"];
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
        
        //
        CGFloat x_padding = 0;                              // 偏移量
        if (i == 1) {
            x_padding = kScreenW /2.0;
        }
        [button_banner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bannerView).with.offset(12 *kiphone6);
            make.left.equalTo(bannerView).with.offset((kScreenW - 53 *2 *kiphone6)/4.0 +x_padding );
            make.size.mas_equalTo(CGSizeMake(53 *kiphone6, 53 *kiphone6));
        }];
        [label_banner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button_banner.mas_bottom).with.offset(10 *kiphone6);
            make.left.equalTo(bannerView).with.offset((kScreenW - 64 *2 *kiphone6)/4.0 +x_padding );
            make.size.mas_equalTo(CGSizeMake(64 , 14));
        }];
        
        
    }
    
    // 用户icon banner
    UIView *iconBanner = [[UIView alloc]init];
    self.iconBanner = iconBanner;
    iconBanner.backgroundColor = [UIColor whiteColor];
    iconBanner.userInteractionEnabled = YES;
    
    if (self.userList.count < 6) {
        YYHomeUserModel *addModel = [[YYHomeUserModel alloc]init];
        addModel.avatar = @"add_normal";
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
//        UIButton *button_banner = [UIButton buttonWithType:UIButtonTypeCustom];
//        [button_banner setBackgroundImage:icon_user forState:UIControlStateNormal];
        button_banner.layer.cornerRadius = 37/2.0*kiphone6;
        button_banner.clipsToBounds = YES;
        
        
        // title
        UILabel *label_banner = [[UILabel alloc]init];
        label_banner.text = userModel.trueName;
        label_banner.font = [UIFont systemFontOfSize:10];
        label_banner.tag = 150+i;
        if (i != 0) {
            label_banner.textColor = [UIColor colorWithHexString:@"333333"];
        }else{
            label_banner.textColor = [UIColor colorWithHexString:@"25f368"];}
        label_banner.textAlignment = NSTextAlignmentCenter;
        
        //
        [iconBanner addSubview:button_banner];
        [iconBanner addSubview:label_banner];
        
        //
        CGFloat x_padding = (20 +37) *kiphone6;                              // 偏移量
//        if ((self.userList.count) %2 == 0) {
//            x_padding = kScreenW /2.0 - (37 +10) *kiphone6 *(self.userList.count)/2.0 + i *(37 +20) *kiphone6;
//        }else{
//            x_padding = kScreenW /2.0 - (37 +20) *kiphone6 *(self.userList.count)/2.0 + i *(37 +20) *kiphone6;
//        }
        x_padding = (kScreenW -37*(self.userList.count) -10*(self.userList.count -1))/2.0 +57*(i) -18.5;
        
        [button_banner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(iconBanner).with.offset(15 *kiphone6);
            make.left.equalTo(iconBanner).with.offset(x_padding);
            make.size.mas_equalTo(CGSizeMake(37 *kiphone6, 37 *kiphone6));
        }];
        [label_banner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button_banner.mas_bottom).with.offset(5 *kiphone6);
            make.left.equalTo(button_banner);
            make.size.mas_equalTo(CGSizeMake(37 *kiphone6 , 10));
        }];
        
        
        }
//    }
    
    //information View
    UIView *infoView = [[UIView alloc] init];
    infoView.backgroundColor = [UIColor whiteColor];
    
    
    NSArray *titleArray = @[@"收缩压(高压)",@"舒张压(低压)",@"体温"];
    NSString *statusTest = @"正常";
    NSMutableArray *lateData = [[NSMutableArray alloc]initWithCapacity:2];
    
    
    NSDictionary* dict_blood =  self.bloodpressureList.lastObject;
    NSDictionary* dict_temperature =  self.temperatureList.lastObject;
    
    if (self.bloodpressureList.count != 0) {
        [lateData addObject:dict_blood[@"systolic"]];
    }else{
        [lateData addObject:@"0"];
    }
    if (self.bloodpressureList.count != 0) {
        [lateData addObject:dict_blood[@"diastolic"]];
    }else{
        [lateData addObject:@"0"];
    }
    if (self.temperatureList.count != 0) {
        [lateData addObject:dict_temperature[@"temperaturet"]];
    }else{
        [lateData addObject:@"0"];
    }
    
    
    
    
    
    
    NSArray *testDataArray = lateData;//@[@"129",@"87",@"38℃"];

    
    
    CGFloat kLabelW = kScreenW /4.0;
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"normal_select"]];
    UILabel *statusLabel = [[UILabel alloc]init];
    statusLabel.text = statusTest;
    statusLabel.font = [UIFont systemFontOfSize:9];
    statusLabel.textColor = [UIColor colorWithHexString:@"333333"];
    statusLabel.textAlignment = NSTextAlignmentCenter;
    
    self.statusLabel = statusLabel;
    [infoView addSubview:imageV];
    [infoView addSubview:statusLabel];
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoView).with.offset(12 *kiphone6);
        make.left.equalTo(infoView).with.offset((kLabelW -17*kiphone6) /2.0);
        make.size.mas_equalTo(CGSizeMake(17 *kiphone6, 17 *kiphone6));
    }];
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageV.mas_bottom).with.offset(10 *kiphone6);
        make.left.equalTo(infoView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(kLabelW, 9));
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
            make.top.equalTo(infoView).with.offset(15 *kiphone6);
            make.left.equalTo(infoView).with.offset((i +1) *kLabelW);
            make.size.mas_equalTo(CGSizeMake(kLabelW *kiphone6, 15));
        }];
        [label_banner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(test_banner.mas_bottom).with.offset(10 *kiphone6);
            make.left.equalTo(test_banner);
            make.size.mas_equalTo(CGSizeMake(kLabelW *kiphone6 , 9));
        }];
        
        
    }
    
    //..邪恶的分割线
    UILabel *lineL = [[UILabel alloc]init];
    lineL.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    
    UILabel *lineL_bottom = [[UILabel alloc]init];
    lineL_bottom.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    
    [infoView addSubview:lineL];
    [infoView addSubview:lineL_bottom];
    
    [lineL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoView);
        make.left.equalTo(infoView).with.offset(20 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(kScreenW -40 *kiphone6, 1));
    }];
    [lineL_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(infoView);
        make.left.equalTo(infoView).with.offset(20 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(kScreenW - 40 *kiphone6, 1));
    }];
    
    
    // TrendView
    UIScrollView *scrollTrendView = [[UIScrollView alloc]init];
    scrollTrendView.contentSize = CGSizeMake(kScreenW *2, 300 *kiphone6);
    scrollTrendView.backgroundColor = [UIColor whiteColor];
    scrollTrendView.pagingEnabled = YES;
    scrollTrendView.showsHorizontalScrollIndicator = NO;
    scrollTrendView.delegate = self;
    
    
    YYTrendView *trendView = [[YYTrendView alloc]init];
    trendView.layer.cornerRadius = 5;
    trendView.clipsToBounds = YES;
    trendView.backgroundColor = [UIColor colorWithHexString:@"8bfad4"];
    
    YYTrendView *temperature_TrendView = [[YYTrendView alloc]init];
    temperature_TrendView.layer.cornerRadius = 5;
    temperature_TrendView.clipsToBounds = YES;
    temperature_TrendView.backgroundColor = [UIColor colorWithHexString:@"8bfad4"];
    
    [scrollTrendView addSubview:trendView];
    [scrollTrendView addSubview:temperature_TrendView];
    self.bloodpressureTrendView = trendView;
    self.temperatureTrendView = temperature_TrendView;
    
    [trendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollTrendView).with.offset(10 *kiphone6);
        make.left.equalTo(scrollTrendView).with.offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(kScreenW -20, 270 *kiphone6));
    }];
    [temperature_TrendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollTrendView).with.offset(10 *kiphone6);
        make.left.equalTo(scrollTrendView).with.offset(10 *kiphone6 +kScreenW);
        make.size.mas_equalTo(CGSizeMake(kScreenW -20, 270 *kiphone6));
    }];
    //创建UIPageControl
    _pageCtrl = [[ZYPageControl alloc] init];  //创建UIPageControl，位置在下方。
    _pageCtrl.numberOfPages = 2;//总的图片页数
    _pageCtrl.currentPage = 0; //当前页
    _pageCtrl.dotImage = [UIImage imageNamed:@"pageControl-normal"];
    _pageCtrl.currentDotImage = [UIImage imageNamed:@"pageControl-select"];
    _pageCtrl.dotSize = CGSizeMake(15, 5);
    [_pageCtrl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];  //用户点击UIPageControl的响应函数
    
    
    
    
    //
    [self addSubview:cycleScrollView2];
    [self addSubview:bannerView];
    [self addSubview:iconBanner];
    [self addSubview:infoView];
    [self addSubview:scrollTrendView];
    [self addSubview:_pageCtrl];
    
    
    // 页面自动布局
    [cycleScrollView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws).with.offset(0);
        make.left.equalTo(ws).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 175 *kiphone6));
    }];
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cycleScrollView2.mas_bottom).with.offset(10);
        make.left.equalTo(ws).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 100 *kiphone6));
    }];
    [iconBanner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bannerView.mas_bottom).with.offset(10);
        make.left.equalTo(ws).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 77 *kiphone6));
    }];
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconBanner.mas_bottom).with.offset(0);
        make.left.equalTo(ws).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 60 *kiphone6));
    }];
    [scrollTrendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoView.mas_bottom).with.offset(0);
        make.left.equalTo(ws).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 300 *kiphone6));
    }];
    [_pageCtrl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(scrollTrendView).with.offset(0);
        make.centerX.equalTo(ws.mas_centerX).with.offset(20 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(40 *kiphone6, 10 *kiphone6));
    }];
    
    [self bringSubviewToFront:_pageCtrl];
    
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
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [_pageCtrl setCurrentPage:offset.x / bounds.size.width];
}

#pragma mark -
#pragma mark ------------banner button----------------------
- (void)bannerButtonClick:(UIButton *)sender{
    if (sender.tag == 130) {
        NSLog(@"医药商场");
        self.bannerClick(YES);
    }else{
        NSLog(@"预约挂号");
        self.bannerClick(NO);
    }
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    YYHeadViewModel *headModel = self.imagesList [index];
    self.itemClick(headModel.info_id);
}
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

- (void)httpRequestForUser{
    
    // 用户列表
    NSString *tokenStr = [CcUserModel defaultClient].userToken;
    [[HttpClient defaultClient]requestWithPath:[NSString stringWithFormat:@"%@token=%@",mUserAndMeasureInfo,tokenStr] method:0 parameters:nil prepareExecute:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@",responseObject);
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
        YYHomeUserModel *userModel = self.userList[0];
//        self.bloodpressureList = userModel.bloodpressureList;
        self.temperatureList = userModel.temperatureList;
//
        self.bloodpressureList = userModel.bloodpressureList;
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
        
        if (self.bloodpressureTrendView) {
            [self refreshIconBanner];
        }else{
            [self setViewInHead];
            [self httpRequest];
        }
        [self.bloodpressureTrendView updateBloodTrendDataList:highBlood lowList:lowBlood dateList:measureDate];
        [self.temperatureTrendView updateTempatureTrendDataList:self.temperatureList];
    // [];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];

}
- (void)changeUserData:(UITapGestureRecognizer *)tapGest{
   
    NSInteger labelTag = (tapGest.view.tag+10);
    if(labelTag == 149 +self.userList.count &&!self.isFull){
        self.addFamily(@"addFamily");
    }else{
    UILabel *label = (UILabel *)[self.iconBanner viewWithTag:labelTag];
    if(![label.textColor isEqual:[UIColor colorWithHexString:@"25f368"]]){
//        NSLog(@"%ld  == %ld",self.userList.count -1,labelTag);
        for (int i = 0; i<self.userList.count -1 ; i++) {
            UILabel *label2 = (UILabel *)[self.iconBanner viewWithTag:150 +i];
            if (labelTag == label2.tag) {
                label2.textColor = [UIColor colorWithHexString:@"25f368"];
            }
            else{
                label2.textColor = [UIColor colorWithHexString:@"333333"];
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
            self.temperatureList = userModel.temperatureList;
            self.bloodpressureList = userModel.bloodpressureList;
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
                self.statusLabel.text = @"待测";
            }else{
                self.statusLabel.text = @"正常";
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
- (void)refreshThisView{
    [self httpRequestForUser];
}
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
        addModel.avatar = @"add_normal";
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
        if (i == userCount && !self.isFull) {
            button_banner.image = [UIImage  imageNamed:userModel.avatar];
        }else{
            [button_banner sd_setImageWithURL:url];
        }
        //        UIButton *button_banner = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [button_banner setBackgroundImage:icon_user forState:UIControlStateNormal];
        button_banner.layer.cornerRadius = 37/2.0*kiphone6;
        button_banner.clipsToBounds = YES;
        
        
        // title
        UILabel *label_banner = [[UILabel alloc]init];
        label_banner.text = userModel.trueName;
        label_banner.font = [UIFont systemFontOfSize:10];
        label_banner.tag = 150+i;
        if (i != 0) {
            label_banner.textColor = [UIColor colorWithHexString:@"333333"];
        }else{
            label_banner.textColor = [UIColor colorWithHexString:@"25f368"];}
        label_banner.textAlignment = NSTextAlignmentCenter;
        
        //
        [iconBanner addSubview:button_banner];
        [iconBanner addSubview:label_banner];
        
        //
        CGFloat x_padding = (20 +37) *kiphone6;                              // 偏移量
//        if ((userCount +1) %2 == 0) {
//            x_padding = kScreenW /2.0 - (37 +10) *kiphone6 *(userCount +1)/2.0 + i *(37 +20) *kiphone6;
//        }else{
//            x_padding = kScreenW /2.0 - (37 +20) *kiphone6 *(userCount +1)/2.0 + i *(37 +20) *kiphone6;
//        }
        x_padding = (kScreenW -37*(self.userList.count) -10*userCount)/2.0 +57*(i) -18.5;
        NSLog(@"左侧偏移量%g userCount = %ld",x_padding,self.userList.count);
        [button_banner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(iconBanner).with.offset(15 *kiphone6);
            make.left.equalTo(iconBanner).with.offset(x_padding);
            make.size.mas_equalTo(CGSizeMake(37 *kiphone6, 37 *kiphone6));
        }];
        [label_banner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button_banner.mas_bottom).with.offset(5 *kiphone6);
            make.left.equalTo(button_banner);
            make.size.mas_equalTo(CGSizeMake(37 *kiphone6 , 10));
        }];
        
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
