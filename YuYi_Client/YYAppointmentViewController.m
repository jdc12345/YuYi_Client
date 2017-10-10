//
//  YYAppointmentViewController.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/21.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYAppointmentViewController.h"
//#import "YYHomeNewTableViewCell.h"
#import "YYSectionViewController.h"
#import "YYSearchTableViewController.h"
#import "HttpClient.h"
#import <MJExtension.h>
#import "YYInfomationModel.h"
//#import <UIImageView+WebCache.h>
#import "YYAppointmentHospitalTVCell.h"

@interface YYAppointmentViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation YYAppointmentViewController

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.indicatorStyle =
        _tableView.rowHeight = kScreenW *77/320.0 +10;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        //        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        [_tableView registerClass:[YYAppointmentHospitalTVCell class] forCellReuseIdentifier:@"YYAppointmentHospitalTVCell"];
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
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
    self.title = @"预约挂号";
    [self httpRequest];
    self.view.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 70 *kiphone6)];
    headView.backgroundColor = [UIColor whiteColor];
//    UIImageView *imageV =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_icon"]];
////    [headView addSubview:imageV];
//    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(headView).with.offset(20 *kiphone6);
//        make.left.equalTo(headView).with.offset(20 *kiphone6);
//        make.size.mas_equalTo(CGSizeMake((kScreenW -40*kiphone6), 30 *kiphone6));
//    }];
    
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    searchBtn.frame = CGRectMake(0, 0, 260 *kiphone6, 26);
    searchBtn.backgroundColor = [UIColor colorWithHexString:@"e5e4e4"];
    searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    [searchBtn setTitleColor:[UIColor colorWithHexString:@"aaa9a9"] forState:UIControlStateNormal];
    [searchBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    //    [button addTarget:self action:@selector(childButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    //    NSDictionary *dict = arr[i];
    [searchBtn setImage:[UIImage imageNamed:@"firstPage_search"] forState:UIControlStateNormal];
    [searchBtn setTitle:@"搜索所有医院" forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.layer.masksToBounds = true;
    searchBtn.layer.cornerRadius = 15*kiphone6;
    [headView addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(20 *kiphone6);
        make.size.mas_equalTo(CGSizeMake((kScreenW -40*kiphone6), 30 *kiphone6));
    }];
    self.tableView.tableHeaderView = headView;
}

#pragma mark -
#pragma mark ------------Tableview Delegate----------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YYInfomationModel *infoModel = self.dataSource[indexPath.row];
    YYSectionViewController *sectionVC = [[YYSectionViewController alloc]init];
    sectionVC.info_id = infoModel.info_id;
    [self.navigationController pushViewController:sectionVC animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark -
#pragma mark ------------TableView DataSource----------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataSource.count == 0) {
        return 1;
    }else{
        return self.dataSource.count;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 215 *kiphone6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYAppointmentHospitalTVCell *hosptalTVCell = [tableView dequeueReusableCellWithIdentifier:@"YYAppointmentHospitalTVCell" forIndexPath:indexPath];
    if (self.dataSource.count != 0) {
        YYInfomationModel *infoModel = self.dataSource[indexPath.row];
        hosptalTVCell.model = infoModel;
 
    }
    return hosptalTVCell;
}
-(void)searchBtnClick:(UIButton*)sender{
    YYSearchTableViewController *searchVC = [[YYSearchTableViewController alloc]init];
    searchVC.searchCayegory = 1;
    [self.navigationController pushViewController:searchVC animated:true];
//    [self.navigationController pushViewController:[[YYSearchTableViewController alloc]init] animated:true];
}
#pragma mark -
#pragma mark ------------Http client----------------------
- (void)httpRequest{
    [[HttpClient defaultClient]requestWithPath:mHospitalInfoList method:0 parameters:nil prepareExecute:^{
        
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
