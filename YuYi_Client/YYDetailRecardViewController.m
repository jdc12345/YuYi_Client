//
//  YYDetailRecardViewController.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/24.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYDetailRecardViewController.h"
#import "UIColor+Extension.h"
#import "YYHomeNewTableViewCell.h"
#import <Masonry.h>
#import "YYSectionViewController.h"
#import "YYPersonalTableViewCell.h"
#import "YYRecardTableViewCell.h"
#import "YYPInfomationTableViewCell.h"
#import "HttpClient.h"
#import "CcUserModel.h"
#import "RecardDetailModel.h"
#import <MJExtension.h>


@interface YYDetailRecardViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSArray *iconList;
@property (nonatomic, strong) RecardDetailModel *dataModel;
@end

@implementation YYDetailRecardViewController

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH -64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces = NO;
        _tableView.indicatorStyle =
        _tableView.rowHeight = kScreenW *77/320.0 +10;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[YYPInfomationTableViewCell class] forCellReuseIdentifier:@"YYPInfomationTableViewCell"];
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
    self.title = @"病例查看";
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    
    [self httpRequest];
    
    self.dataSource = [[NSMutableArray alloc]initWithArray:@[@[@"用户名",@"性别",@"年龄",@"婚姻"],@[@"病理采集日期"]]];
    //    self.iconList =@[@[@"18511694068",@"男",@"24"],@[@"黑龙江哈尔滨",@"程序员",@"未婚"],@[@"2016-10-23"]];
    
    
   
    
    // Do any additional setup after loading the view.
}
- (UIView *)personInfomation{
    
    UIView *personV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 242 *kiphone6)];
    personV.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(10 *kiphone6, 10 *kiphone6, kScreenW -20*kiphone6, 232 *kiphone6)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    [personV addSubview:headerView];
    
    //
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"现病史";
    nameLabel.textColor = [UIColor colorWithHexString:@"666666"];
    nameLabel.font = [UIFont systemFontOfSize:14];
    //
    
    UITextView *textView = [[UITextView alloc]init];
    
    textView.text = self.dataModel.medicalrecord;
    textView.textColor = [UIColor colorWithHexString:@"666666"];
    textView.font = [UIFont systemFontOfSize:13];
    textView.editable = NO;
    [headerView addSubview:textView];
    [headerView addSubview:nameLabel];
    
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView).with.offset(10 *kiphone6);
        make.left.equalTo(headerView).with.offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(140 *kiphone6, 10 *kiphone6));
    }];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).with.offset(10 *kiphone6);
        make.left.equalTo(headerView).with.offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(kScreenW -30*kiphone6, 180 *kiphone6));
    }];
    
    return personV;
}

#pragma mark -
#pragma mark ------------Tableview Delegate----------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    [self.navigationController pushViewController:[[YYSectionViewController alloc]init] animated:YES];
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
    
    return 40 *kiphone6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10 *kiphone6;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 10)];
    headerView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    
    return headerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYPInfomationTableViewCell *homeTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"YYPInfomationTableViewCell" forIndexPath:indexPath];
    
    homeTableViewCell.titleLabel.text = self.dataSource[indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        
        if (indexPath.row ==  0) {
            homeTableViewCell.seeRecardLabel.text = self.dataModel.trueName;
        }else if (indexPath.row ==  1) {
            if ([self.dataModel.gender isEqualToString:@"0"]) {
                homeTableViewCell.seeRecardLabel.text = @"男";
            }else{
                homeTableViewCell.seeRecardLabel.text = @"女";
            }
            
        }else if (indexPath.row ==  2) {
            homeTableViewCell.seeRecardLabel.text = self.dataModel.age;
        }else if (indexPath.row ==  3) {
            if ([self.dataModel.marital isEqualToString:@"0"]) {
                homeTableViewCell.seeRecardLabel.text = @"未婚";
            }
            if ([self.dataModel.marital isEqualToString:@"1"]) {
                homeTableViewCell.seeRecardLabel.text = @"已婚";
            }if ([self.dataModel.marital isEqualToString:@"2"]) {
                homeTableViewCell.seeRecardLabel.text = @"离异";
            }if ([self.dataModel.marital isEqualToString:@"3"]) {
                homeTableViewCell.seeRecardLabel.text = @"丧偶";
            }
        }
    }else{
        
        homeTableViewCell.seeRecardLabel.text = [self.dataModel.createTimeString componentsSeparatedByString:@" "].firstObject;;
    }
    //    homeTableViewCell.seeRecardLabel.text = self.iconList[indexPath.section][indexPath.row];
    //    homeTableViewCell.iconV.image = [UIImage imageNamed:self.iconList[indexPath.row]];
    
    return homeTableViewCell;
    
}

#pragma mark -
#pragma mark ------------Http client----------------------

- (void)httpRequest{
    [[HttpClient defaultClient]requestWithPath:[NSString stringWithFormat:@"%@%@",mMedicalDetail,self.recardID] method:0 parameters:nil prepareExecute:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSArray *array = responseObject;
        NSDictionary *dict = array.firstObject;
        self.dataModel = [RecardDetailModel mj_objectWithKeyValues:dict];
        self.tableView.tableFooterView = [self personInfomation];
//        [self.tableView reloadData];
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
