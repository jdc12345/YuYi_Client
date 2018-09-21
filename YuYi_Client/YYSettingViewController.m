//
//  YYSettingViewController.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/24.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYSettingViewController.h"
#import "YYHomeNewTableViewCell.h"
#import "YYSectionViewController.h"
#import "YYPersonalTableViewCell.h"
#import "YYRecardTableViewCell.h"
//#import "YYPInfomationTableViewCell.h"
#import "YYFeedbackViewController.h"
#import "YYAboutUSViewController.h"
#import "YYContactViewController.h"
#import "CcUserModel.h"
#import "YYLogInVC.h"
#import "YYSetTVCell.h"
#import "YYBindingTelNumVC.h"

@interface YYSettingViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSArray *iconList;

@end

@implementation YYSettingViewController


- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces = NO;
        _tableView.indicatorStyle =
        _tableView.rowHeight = kScreenW *77/320.0 +10;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[YYSetTVCell class] forCellReuseIdentifier:@"YYSetTVCell"];
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
    self.title = @"设置";
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    
    
    self.dataSource = [[NSMutableArray alloc]initWithArray:@[@[@"联系我们",@"意见反馈",@"关于我们"],@[@"退出"]]];
    self.iconList =@[@[@"18511694068",@"男",@"布依族",@"24"],@[@"黑龙江哈尔滨",@"程序员",@"未婚"],@[@"2016-10-23"]];
    
    
    [self tableView];
//    UIButton *sureBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
//    sureBtn.layer.cornerRadius = 1.5 *kiphone6;
//    sureBtn.layer.borderWidth = 0.5 *kiphone6;
//    sureBtn.layer.borderColor = [UIColor colorWithHexString:@"e00610"].CGColor;
//    sureBtn.clipsToBounds = YES;
//    [sureBtn setTitle:@"退出登陆" forState:UIControlStateNormal];
//    sureBtn.backgroundColor = [UIColor clearColor];
//    [sureBtn setTitleColor:[UIColor colorWithHexString:@"e00610"] forState:UIControlStateNormal];
//    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
//    //     [sureBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
//    [sureBtn addTarget:self action:@selector(buttonClick1:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.view addSubview:sureBtn];
    // Do any additional setup after loading the view.
}


#pragma mark -
#pragma mark ------------Tableview Delegate----------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            YYContactViewController *contactVC = [[YYContactViewController alloc]init];
            [self.navigationController pushViewController:contactVC animated:YES];
            
        }else if(indexPath.row == 1){
            YYFeedbackViewController *feedVC = [[YYFeedbackViewController alloc]init];
            [self.navigationController pushViewController:feedVC animated:YES];
        }else if(indexPath.row == 2){
            YYAboutUSViewController *aboutVC = [[YYAboutUSViewController alloc]init];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }else if(indexPath.row == 3){
//            YYBindingTelNumVC *aboutVC = [[YYBindingTelNumVC alloc]init];
//            [self.navigationController pushViewController:aboutVC animated:YES];
        }
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"你确定退出吗" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            CcUserModel *userModel = [CcUserModel defaultClient];
            [userModel removeUserInfo];//清除本地存储
            [CcUserModel defaultClient];//清除缓存
            YYLogInVC *logVC = [[YYLogInVC alloc]init];
            [self.navigationController presentViewController:logVC animated:true completion:nil];
        }];
        
        [alert addAction:cancelAction];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
   
    
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark -
#pragma mark ------------TableView DataSource----------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *section_row = self.dataSource[section];
    return section_row.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40 *kiphone6H;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10 *kiphone6H;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 10)];
    headerView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    
    return headerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYSetTVCell *homeTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"YYSetTVCell" forIndexPath:indexPath];
    
    homeTableViewCell.titleLabel.text = self.dataSource[indexPath.section][indexPath.row];
//    homeTableViewCell.titleLabel.textColor = [UIColor colorWithHexString:@"666666"];
//    homeTableViewCell.seeRecardLabel.text = @"";
    //    homeTableViewCell.iconV.image = [UIImage imageNamed:self.iconList[indexPath.row]];
    
    return homeTableViewCell;
    
}


@end
