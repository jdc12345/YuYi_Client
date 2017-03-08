//
//  YYHomePageViewController.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/17.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYHomePageViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MJRefresh.h>
#import "YYHomeHeadView.h"
#import "UIColor+Extension.h"
#import <Masonry.h>
#import "YYHomeNewTableViewCell.h"
#import "YYHomeMedicineTableViewCell.h"
#import "InfomationViewController.h"
#import "YYAppointmentViewController.h"
#import "ViewController.h"
#import "YYInfoDetailViewController.h"
#import "ZYAlertSView.h"
#import "GYZChooseCityController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "NotficationViewController.h"

@interface YYHomePageViewController ()<UITableViewDataSource, UITableViewDelegate,SDWebImageManagerDelegate,SDWebImageOperation, GYZChooseCityDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, weak) ZYAlertSView *alertView;

@property (nonatomic, weak) UIButton *leftBtn;
@property (nonatomic, strong) AMapLocationManager *locationManager2;

@end

@implementation YYHomePageViewController

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.indicatorStyle =
        _tableView.rowHeight = kScreenW *77/320.0 +10;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        //        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        [_tableView registerClass:[YYHomeNewTableViewCell class] forCellReuseIdentifier:@"YYHomeNewTableViewCell"];
        [_tableView registerClass:[YYHomeMedicineTableViewCell class] forCellReuseIdentifier:@"YYHomeMedicineTableViewCell"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [self.view addSubview:_tableView];
        [self.view sendSubviewToBack:_tableView];
        
    }
    return _tableView;
}
- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"首页";
    
    
    YYHomeHeadView *homeHeadView = [[YYHomeHeadView alloc]init];
    homeHeadView.bannerClick = ^(BOOL isShopping){
        if (isShopping) {
            NSLog(@"跳转到医药商城");

            [self.navigationController pushViewController:[[ViewController alloc]init] animated:true];


        }else{
            YYAppointmentViewController *appiontmentVC = [[YYAppointmentViewController alloc]init];
            [self.navigationController pushViewController:appiontmentVC animated:YES];
        }
    };
    self.tableView.tableHeaderView = homeHeadView;
    
  
    
    
    // 左侧地址按钮
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [leftButton setFrame:CGRectMake(0,0,50, 15)];
    
    [leftButton setTitle:@"北京" forState:UIControlStateNormal];
    
    [leftButton setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    
    leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [leftButton addTarget:self action:@selector(back_click:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    self.leftBtn = leftButton;
    
    // 右侧通知按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightButton setFrame:CGRectMake(0,0,20, 20)];
    
    [rightButton setBackgroundImage:[UIImage imageNamed:@"notfic_select"] forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(back_click_right:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [rightButton sizeToFit];
    
    
    UIImageView *searchImageV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 300, 26)];
    searchImageV.image = [UIImage imageNamed:@"search_icon"];
    self.navigationItem.titleView = searchImageV;
    
    
    
    // 首页高德定位
    NSLog(@"首页高德定位");
    [AMapServices sharedServices].apiKey =@"1ed56a722c410ad36180cd7272d9ae7f";
    
    
    
    
    self.locationManager2 = [[AMapLocationManager alloc]init];
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager2 setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //   定位超时时间，最低2s，此处设置为2s
    self.locationManager2.locationTimeout =2;
    //   逆地理请求超时时间，最低2s，此处设置为2s
    self.locationManager2.reGeocodeTimeout = 2;
    
    [self.locationManager2 requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        NSLog(@"location:%@", location);
        
        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode.district);
            if(!regeocode.district){
                [leftButton setTitle:@"无定位" forState:UIControlStateNormal];
            }else{
             [leftButton setTitle:regeocode.district forState:UIControlStateNormal];
            }
        }
        
    }];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark ------------TableView Delegate----------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 ) {
        YYInfoDetailViewController *infoDetail = [[YYInfoDetailViewController alloc]init];
        [self.navigationController pushViewController:infoDetail animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark ------------TableView DataSource----------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50 *kiphone6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0000000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 110 *kiphone6;
    }else{
        return 166 *kiphone6;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *title;
    if (section == 0) {
        title =  @"资讯";
    }else{
        title = @ "常用药品";
    }
    UIView *sectionHView = [[UIView alloc]init];
    sectionHView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    
    UIView *whiteView = [[UIView alloc]init];
    whiteView.backgroundColor = [UIColor whiteColor];
    
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo:)];
    tapGesture.numberOfTapsRequired = 1;
    [whiteView addGestureRecognizer:tapGesture];
    
    UILabel *sectionName = [[UILabel alloc]init];
    sectionName.text = title;
    sectionName.textColor = [UIColor colorWithHexString:@"6a6a6a"];
    sectionName.font = [UIFont systemFontOfSize:14];
    
    UIButton *clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [clickButton setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [clickButton addTarget:self action:@selector(Actiondo:) forControlEvents:UIControlEventTouchUpInside];
    
    [whiteView addSubview:sectionName];
    [whiteView addSubview:clickButton];
    
    [sectionName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(whiteView).with.offset(13 *kiphone6);
        make.left.equalTo(whiteView).with.offset(20 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(64, 14));
    }];
    
    [clickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(whiteView).with.offset(0);
        make.right.equalTo(whiteView).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(40 *kiphone6, 40 *kiphone6));
    }];
    
    
    
    [sectionHView addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sectionHView).with.offset(10*kiphone6);
        make.left.equalTo(sectionHView);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 40*kiphone6));
    }];
    // sectionHView.frame = CGRectMake(0, 0, kScreenW, 44 *kiphone6);
    return sectionHView;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 0)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        YYHomeNewTableViewCell *homeTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"YYHomeNewTableViewCell" forIndexPath:indexPath];
        [homeTableViewCell createDetailView:2];
        homeTableViewCell.iconV.image = [UIImage imageNamed:[NSString stringWithFormat:@"cell%ld",indexPath.row +1]];
        homeTableViewCell.backgroundColor = [UIColor cyanColor];
        return homeTableViewCell;
    }else{
        YYHomeMedicineTableViewCell *homeTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"YYHomeMedicineTableViewCell" forIndexPath:indexPath];
        homeTableViewCell.iconV.image = [UIImage imageNamed:[NSString stringWithFormat:@"cell%ld",indexPath.row +1]];
        homeTableViewCell.backgroundColor = [UIColor cyanColor];
        return homeTableViewCell;
    }
    
}
#pragma mark -
#pragma mark ------------Cancel-----------------------
- (void)cancel{
    
}
#pragma mark -
#pragma mark ------------section click----------------------

- (void)Actiondo:(NSInteger)sectionNum{
    InfomationViewController *infoVC = [[InfomationViewController alloc]init];
    [self.navigationController pushViewController:infoVC animated:YES];
}
- (void)back_click:(UIButton *)sender{
    GYZChooseCityController *cityPickerVC = [[GYZChooseCityController alloc] init];
    [cityPickerVC setDelegate:self];
    
    //    cityPickerVC.locationCityID = @"1400010000";
    //    cityPickerVC.commonCitys = [[NSMutableArray alloc] initWithArray: @[@"1400010000", @"100010000"]];        // 最近访问城市，如果不设置，将自动管理
    //    cityPickerVC.hotCitys = @[@"100010000", @"200010000", @"300210000", @"600010000", @"300110000"];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
        
    }];
}
- (void)back_click_right:(UIButton *)sender{
    NotficationViewController *noteVC = [[NotficationViewController alloc]init];
    [self.navigationController pushViewController:noteVC animated:YES];
}
#pragma mark - GYZCityPickerDelegate
- (void) cityPickerController:(GYZChooseCityController *)chooseCityController didSelectCity:(GYZCity *)city
{
    [self.leftBtn setTitle:city.cityName forState:UIControlStateNormal];
    [chooseCityController dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void) cityPickerControllerDidCancel:(GYZChooseCityController *)chooseCityController
{
    [self.leftBtn setTitle:chooseCityController.locationCityID forState:UIControlStateNormal];
    [chooseCityController dismissViewControllerAnimated:YES completion:^{
    }];
}

// 取消吸顶 顶部悬停

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
