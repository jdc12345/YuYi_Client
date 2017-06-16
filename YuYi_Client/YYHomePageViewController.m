//
//  YYHomePageViewController.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/17.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.

/**
 
 
 */
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
#import "searchBar.h"
#import "YYSearchTableViewController.h"
#import "YYAllMedicinalViewController.h"
#import "YYMedicinalDetailVC.h"
#import "HttpClient.h"
#import "YYInfomationModel.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "CcUserModel.h"
#import "YYHomeUserModel.h"
#import "SimpleMedicalModel.h"
#import "YYFamilyAccountViewController.h"
#import "JPUSHService.h"
#import "RCUserModel.h"
#import "RCUserModel.h"
@interface YYHomePageViewController ()<UITableViewDataSource, UITableViewDelegate,SDWebImageManagerDelegate,SDWebImageOperation, GYZChooseCityDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *dataHomeSource;
@property (nonatomic, strong) NSMutableArray *medicalHomeSource;
@property (nonatomic, weak) ZYAlertSView *alertView;

@property (nonatomic, weak) UIButton *leftBtn;
@property (nonatomic, weak) YYHomeHeadView *headView;
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

- (NSMutableArray *)dataHomeSource{
    if (_dataHomeSource == nil) {
        _dataHomeSource = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return _dataHomeSource;
}
- (NSMutableArray *)medicalHomeSource{
    if (_medicalHomeSource == nil) {
        _medicalHomeSource = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return _medicalHomeSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"首页";
    [self httpRequestRCToken];
    [JPUSHService setAlias:[CcUserModel defaultClient].telephoneNum callbackSelector:nil object:nil];
    NSLog(@"phone = %@",[CcUserModel defaultClient].telephoneNum);
    [self httpRequest];
    [self httpRequestForMedical];
    
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
    
    homeHeadView.itemClick = ^(NSString *index){
        YYInfoDetailViewController *infoDetail = [[YYInfoDetailViewController alloc]init];
        infoDetail.info_id = index;
        [self.navigationController pushViewController:infoDetail animated:YES];
        
    };
    homeHeadView.addFamily = ^(NSString *index){
        YYFamilyAccountViewController *familyAVC = [[YYFamilyAccountViewController alloc]init];
        [self.navigationController pushViewController:familyAVC animated:YES];
        
    };
  
    self.headView = homeHeadView;
    self.tableView.tableHeaderView = homeHeadView;
    
  
    
    
    
    UIView *headTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenW, 44)];
//    headTitleView.backgroundColor = [UIColor cyanColor];
    // 左侧地址按钮   测
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [leftButton setFrame:CGRectMake(0,0,50 *kiphone6, 15)];
    
    [leftButton setTitle:@"北京" forState:UIControlStateNormal];
    
    [leftButton setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    
    leftButton.titleLabel.font = [UIFont systemFontOfSize:15 *kiphone6];
    
    [leftButton addTarget:self action:@selector(back_click:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
//    self.navigationItem.leftBarButtonItem = leftItem;
    self.leftBtn = leftButton;
    
    // 右侧通知按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightButton setFrame:CGRectMake(0,0,20, 20)];
    
    [rightButton setBackgroundImage:[UIImage imageNamed:@"notfic_select"] forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(back_click_right:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
//    self.navigationItem.rightBarButtonItem = rightItem;
    
    [rightButton sizeToFit];
    
    
//    UIImageView *searchImageV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 300, 26)];
//    searchImageV.image = [UIImage imageNamed:@"search_icon"];
//    
    
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(0, 0, 260 *kiphone6, 26);
    searchBtn.backgroundColor = [UIColor colorWithHexString:@"e5e4e4"];
    searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    [searchBtn setTitleColor:[UIColor colorWithHexString:@"aaa9a9"] forState:UIControlStateNormal];
    [searchBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    //    [button addTarget:self action:@selector(childButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    //    NSDictionary *dict = arr[i];
    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchBtn setTitle:@"搜索所有药品" forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [headTitleView addSubview:leftButton];
    [headTitleView addSubview:rightButton];
    
    
    CcUserModel *model = [CcUserModel defaultClient];
    if (![model.telephoneNum isEqualToString:@"18511694068"]) {
        [headTitleView addSubview:searchBtn];
        [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(headTitleView);
            make.size.mas_equalTo(CGSizeMake(240 *kiphone6 ,30));
        }];
    }
    
    
    
    WS(ws);

    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headTitleView).with.offset(5);
        make.centerY.equalTo(headTitleView);
        make.size.mas_equalTo(CGSizeMake(50 *kiphone6 ,44));
    }];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headTitleView).with.offset(-5);
        make.centerY.equalTo(headTitleView);
        make.size.mas_equalTo(CGSizeMake(20 *kiphone6,20));
    }];
    self.navigationItem.titleView = headTitleView;
    
    
    
    // 首页高德定位
    NSLog(@"首页高德定位");
    [AMapServices sharedServices].apiKey =@"b9c7a79ba8b553ae7aea093517c62ed0";
    
    
    
    
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
        [CcUserModel defaultClient].loation = location;

        
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
        
        YYInfomationModel *infoModel = self.dataSource[indexPath.row];
        YYInfoDetailViewController *infoDetail = [[YYInfoDetailViewController alloc]init];
        infoDetail.info_id = infoModel.info_id;
        [self.navigationController pushViewController:infoDetail animated:YES];
    }else{
        
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark ------------TableView DataSource----------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.dataSource.count;
    }else{
        NSLog(@" ========   %ld    %@",self.medicalHomeSource.count,self.medicalHomeSource);
        return self.medicalHomeSource.count /3;
    }
    
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
        return 166 -21*kiphone6;
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
    whiteView.tag = 200 +section;
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo:)];
    [whiteView addGestureRecognizer:tapGesture];
    
    UILabel *sectionName = [[UILabel alloc]init];
    sectionName.text = title;
    sectionName.textColor = [UIColor colorWithHexString:@"6a6a6a"];
    sectionName.font = [UIFont systemFontOfSize:14];
    
    UIButton *clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [clickButton setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    clickButton.enabled = NO;
//    [clickButton addTarget:self action:@selector(Actiondo:) forControlEvents:UIControlEventTouchUpInside];
//    [clickButton addGestureRecognizer:tapGesture];
    
    [whiteView addSubview:sectionName];
    [whiteView addSubview:clickButton];
    
    [sectionName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(whiteView).with.offset(10 *kiphone6);
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
        if (self.dataSource.count != 0) {
            YYInfomationModel *infoModel = self.dataSource[indexPath.row];
            [homeTableViewCell.iconV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mPrefixUrl,infoModel.picture]]];
            homeTableViewCell.titleLabel.text = infoModel.title;
            homeTableViewCell.introduceLabel.text = infoModel.smalltitle;
        }else{
            homeTableViewCell.iconV.image =  [UIImage imageNamed:[NSString stringWithFormat:@"cell%ld",indexPath.row +1]];
        }
        return homeTableViewCell;
    }else{
     
        YYHomeMedicineTableViewCell *homeTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"YYHomeMedicineTableViewCell" forIndexPath:indexPath];
        
        if (self.medicalHomeSource.count != 0) {
       //     NSArray *smallArray;
            NSMutableArray *bigArray = [[NSMutableArray alloc]initWithCapacity:2];
            if (indexPath.row == 0) {
                for(int i = 0 ;i<3 ;i++){
                    [bigArray addObject:self.medicalHomeSource[i]];
                }
        //        smallArray = [self.medicalHomeSource subarrayWithRange:NSMakeRange(0, 2)];
            }else{
                for(int i = 3 ;i<6 ;i++){
                    [bigArray addObject:self.medicalHomeSource[i]];
                }
          //      smallArray = [self.medicalHomeSource subarrayWithRange:NSMakeRange(3, 5)];
            }
            [homeTableViewCell updateDataList:bigArray];
        }else{
            homeTableViewCell.iconV.image = [UIImage imageNamed:[NSString stringWithFormat:@"cell%ld",indexPath.row +1]];
        
        }
        
        
        [homeTableViewCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        homeTableViewCell.itemClick = ^(NSString *medicalID){
            YYMedicinalDetailVC *medicinaDVC = [[YYMedicinalDetailVC alloc]init];
            medicinaDVC.id = [medicalID integerValue];
            [self.navigationController pushViewController:medicinaDVC animated:YES];
        };
        return homeTableViewCell;
    }
    
}
#pragma mark -
#pragma mark ------------Cancel-----------------------
- (void)cancel{
    
}
#pragma mark -
#pragma mark ------------section click----------------------

- (void)Actiondo:(UITapGestureRecognizer *)tapNum{
    
    NSInteger sectionNum = tapNum.view.tag -200;
    if (sectionNum == 0) {
        

    InfomationViewController *infoVC = [[InfomationViewController alloc]init];
        [self.navigationController pushViewController:infoVC animated:YES];
    }else{
        YYAllMedicinalViewController *medicinalVC = [[YYAllMedicinalViewController alloc]init];
        medicinalVC.id = @"1";
        medicinalVC.categoryName = @"常用药品";
        [self.navigationController pushViewController:medicinalVC animated:YES];
    }
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
#pragma mark -
#pragma mark ------------Search----------------------

-(void)searchBtnClick:(UIButton*)sender{
    YYSearchTableViewController *searchVC = [[YYSearchTableViewController alloc]init];
    searchVC.searchCayegory = 1;
    [self.navigationController pushViewController:searchVC animated:true];
}


#pragma mark -
#pragma mark ------------Http client----------------------

- (void)httpRequest{
    [[HttpClient defaultClient]requestWithPath:mHomepageInfo method:0 parameters:nil prepareExecute:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSArray *rowArray = responseObject[@"rows"];
        for (NSDictionary *dict in rowArray){
            YYInfomationModel *infoModel = [YYInfomationModel mj_objectWithKeyValues:dict];
            [self.dataSource addObject:infoModel];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)httpRequestForUser{
    NSString *userToken = [CcUserModel defaultClient].userToken;
    NSLog(@"%@",userToken);
    [[HttpClient defaultClient]requestWithPath:[NSString stringWithFormat:@"%@%@",mHomeusers,userToken] method:0 parameters:nil prepareExecute:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
    //    NSLog(@"homeUsers = %@",responseObject);
        NSArray *usersList = responseObject[@"result"];
        for (NSDictionary *dict in usersList) {
            YYHomeUserModel *homeUser = [YYHomeUserModel mj_objectWithKeyValues:dict];
            [self.dataHomeSource addObject:homeUser];
        }
     
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)httpRequestForMedical{
    NSString *userToken = [CcUserModel defaultClient].userToken;
    [[HttpClient defaultClient]requestWithPath:mHomeMedical method:0 parameters:nil prepareExecute:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"sadasda %@",responseObject);
        NSArray *medicalList = responseObject[@"rows"];
        for (NSDictionary *dict in medicalList) {
            SimpleMedicalModel *homeUser = [SimpleMedicalModel mj_objectWithKeyValues:dict];
            [self.medicalHomeSource addObject:homeUser];
        }
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
   
    if (self.dataSource.count != 0) {
        [self.headView refreshThisView];
    }
}



- (void)httpRequestRCToken{
    CcUserModel *userModel = [CcUserModel defaultClient];
    [[HttpClient defaultClient]requestWithPath:[NSString stringWithFormat:@"%@%@",mRCtokenUrl,userModel.telephoneNum] method:0 parameters:nil prepareExecute:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        RCUserModel *userModel_rc = [RCUserModel defaultClient];
        userModel_rc.token = responseObject[@"token"];
        userModel_rc.Avatar = responseObject[@"Avatar"];
        userModel_rc.TrueName = responseObject[@"TrueName"];
        userModel_rc.info_id = responseObject[@"id"];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
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
