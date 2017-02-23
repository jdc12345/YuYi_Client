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

@interface YYHomeHeadView()<UIScrollViewDelegate>
@property (nonatomic, assign)CGFloat maxY;

@property (nonatomic, strong)ZYPageControl *pageCtrl;
@end

@implementation YYHomeHeadView

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"123123123");
        
        self.backgroundColor = kColor_DefaultGray;
        [self setViewInHead];
        self.userInteractionEnabled = YES;
         self.frame = CGRectMake(0, 0, kScreenW, 732 *kiphone6);
    }
    return self;
}

- (void)setViewInHead{
    WS(ws);
    // 图片轮播器
    SDCycleScrollView *cycleScrollView2 = [[SDCycleScrollView alloc]init];
    cycleScrollView2.localizationImagesGroup = @[[UIImage imageNamed:@"carinalau1.jpg"],[UIImage imageNamed:@"carinalau2.jpg"],[UIImage imageNamed:@"carinalau3.jpg"],[UIImage imageNamed:@"carinalau4.jpg"]];
    cycleScrollView2.showPageControl = YES;
   
    
    // 按钮banner
    UIView *bannerView = [[UIView alloc]init];
    bannerView.backgroundColor = [UIColor whiteColor];
    
    NSArray *butArray = @[@"shopmall_select",@"appointment"];
    NSArray *labelArray = @[@"医药商城",@"预约挂号"];
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
    iconBanner.backgroundColor = [UIColor whiteColor];
    
    NSArray *iconArray = @[@"LIM_",@"add_normal"];
    NSArray *nameArray = @[@"LIM",@""];
    int userCount = 1;
    
    for (int i = 0; i < userCount+1; i++) {
        
        // icon
        UIButton *button_banner = [UIButton buttonWithType:UIButtonTypeCustom];
        [button_banner setBackgroundImage:[UIImage imageNamed:iconArray[i]] forState:UIControlStateNormal];
        button_banner.layer.cornerRadius = 37/2.0*kiphone6;
        button_banner.clipsToBounds = YES;
        
        
        // title
        UILabel *label_banner = [[UILabel alloc]init];
        label_banner.text = nameArray[i];
        label_banner.font = [UIFont systemFontOfSize:10];
        label_banner.textColor = [UIColor colorWithHexString:@"25f368"];
        label_banner.textAlignment = NSTextAlignmentCenter;
        
        //
        [iconBanner addSubview:button_banner];
        [iconBanner addSubview:label_banner];
        
        //
        CGFloat x_padding = (20 +37) *kiphone6;                              // 偏移量
        if ((userCount +1) %2 == 0) {
            x_padding = kScreenW /2.0 - (37 +10) *kiphone6 *(userCount +1)/2.0 + i *(37 +20) *kiphone6;
        }else{
            x_padding = kScreenW /2.0 - (37 +20) *kiphone6 *(userCount +1)/2.0 + i *(37 +20) *kiphone6;
        }
        
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
    
    //information View
    UIView *infoView = [[UIView alloc] init];
    infoView.backgroundColor = [UIColor whiteColor];
    
    NSArray *testDataArray = @[@"129",@"87",@"38℃"];
    NSArray *titleArray = @[@"收缩压(高压)",@"舒张压(低压)",@"体温"];
    NSString *statusTest = @"正常";
    
    
    CGFloat kLabelW = kScreenW /4.0;
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"normal_select"]];
    UILabel *statusLabel = [[UILabel alloc]init];
    statusLabel.text = statusTest;
    statusLabel.font = [UIFont systemFontOfSize:9];
    statusLabel.textColor = [UIColor colorWithHexString:@"333333"];
    statusLabel.textAlignment = NSTextAlignmentCenter;
    
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
