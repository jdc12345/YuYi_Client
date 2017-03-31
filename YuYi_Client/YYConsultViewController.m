//
//  YYConsultViewController.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/17.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYConsultViewController.h"
#import "UIColor+Extension.h"
#import <Masonry.h>
#import "YYHospitalInfoViewController.h"
#import "YYConsultTableViewCell.h"
#import "HttpClient.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "YYInfomationModel.h"
#import "CcUserModel.h"
#import "RCUserModel.h"

@interface YYConsultViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;


@end

@implementation YYConsultViewController

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH -64 -44 -10) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.indicatorStyle =
        _tableView.rowHeight = kScreenW *77/320.0 +10;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
//        _tableView.bounces = NO;
        //        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        [_tableView registerClass:[YYConsultTableViewCell class] forCellReuseIdentifier:@"YYConsultTableViewCell"];
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
    self.title = @"咨询";
    NSLog(@"sadsadasdasdasdasdasdd--------------------%@",[RCUserModel defaultClient].token);
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self httpRequest];
    // Do any additional setup after loading the view.
}

#pragma mark -
#pragma mark ------------Tableview Delegate----------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YYInfomationModel *infoModel = self.dataSource[indexPath.row];
    YYHospitalInfoViewController* hospitalInfoVC = [[YYHospitalInfoViewController alloc]init];
    hospitalInfoVC.yyInfomationModel = infoModel;
    [self.navigationController pushViewController:hospitalInfoVC animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark -
#pragma mark ------------TableView DataSource----------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80 *kiphone6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYInfomationModel *infoModel = self.dataSource[indexPath.row];
    YYConsultTableViewCell *homeTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"YYConsultTableViewCell" forIndexPath:indexPath];
    [homeTableViewCell createDetailView:2];
    [homeTableViewCell addStarView:infoModel.tell];
    
    //    homeTableViewCell.iconV.image = [UIImage imageNamed:[NSString stringWithFormat:@"cell%ld",(indexPath.row)%2 +1]];
    [homeTableViewCell.iconV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", mPrefixUrl,infoModel.picture]]];
    homeTableViewCell.titleLabel.text = infoModel.hospitalName;
    homeTableViewCell.introduceLabel.text = infoModel.introduction;
    
    CLLocation *loation = [CcUserModel defaultClient].loation;
    //第二个坐标
    CLLocation *hospitalLoation = [[CLLocation alloc] initWithLatitude:infoModel.lat longitude:infoModel.lng];
    CLLocationDistance meters= [loation distanceFromLocation:hospitalLoation];
    
    
    
    homeTableViewCell.posLabel.text = [NSString stringWithFormat:@"%0.1fkm",meters/1000.0];
    
    return homeTableViewCell;
    
}
- (void)httpRequest{
    [[HttpClient defaultClient]requestWithPath:mHospitalInfoList method:0 parameters:nil prepareExecute:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);


        NSArray *rowArray = responseObject[@"rows"];
        for (NSDictionary *dict in rowArray){
            YYInfomationModel *infoModel = [YYInfomationModel mj_objectWithKeyValues:dict];
            [self.dataSource addObject:infoModel];
        }
        UIView *headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 10 *kiphone6)];
        headV.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
        self.tableView.tableHeaderView = headV;
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}


@end
