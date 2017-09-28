//
//  YYPersonalInfoDetailVC.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/9/27.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYPersonalInfoDetailVC.h"
//#import "YYAutoMeasureViewController.h"
//#import "YYHandleMeasureViewController.h"
#import "YYConnectViewController.h"
#import "UIBarButtonItem+Helper.h"
#import "YYFamilyAccountViewController.h"
//#import "YYPersonalInfoTableViewCell.h"
//#import "YYDataAnalyseViewController.h"
#import "YYDetailRecardViewController.h"
#import "YYPInfomartionViewController.h"
#import <UIImageView+WebCache.h>
#import "FamilyRecardViewController.h"
#import "YYRecardViewController.h"
#import "CcUserModel.h"
#import "HttpClient.h"
#import <MJExtension.h>
#import "YYDataAnalysisTVCell.h"
#import "YYRecoderAnalysisTVCell.h"

@interface YYPersonalInfoDetailVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;//整个tableview
@property (nonatomic, strong) NSMutableArray *dataSource;//整个tableview数据
@property (nonatomic, assign) NSInteger currentRow;
@property (nonatomic, strong) NSMutableArray *recoderData;//病历记录数据
@property (nonatomic, assign) BOOL dataAnalysisOpen;//数据分析是否打开
@property (nonatomic, assign) BOOL recoderisOpen;//病历记录是否打开
@end

@implementation YYPersonalInfoDetailVC

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.indicatorStyle =
        _tableView.rowHeight = kScreenW *77/320.0 +10;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        //        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        [_tableView registerClass:[YYDataAnalysisTVCell class] forCellReuseIdentifier:@"YYDataAnalysisTVCell"];
        [_tableView registerClass:[YYRecoderAnalysisTVCell class] forCellReuseIdentifier:@"YYRecoderAnalysisTVCell"];
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
- (NSMutableArray *)recoderData{
    if (_recoderData == nil) {
        _recoderData = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return _recoderData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"个人信息";
    self.dataAnalysisOpen = true;
    self.recoderisOpen = false;
    self.tableView.tableHeaderView = [self personInfomation];
    [self httpRequestForRecoder];//请求病历记录数据
}
//请求病历记录数据
- (void)httpRequestForRecoder{
    [[HttpClient defaultClient]requestWithPath:[NSString stringWithFormat:@"%@token=%@",mMedicalToken,[CcUserModel defaultClient].userToken] method:0 parameters:nil prepareExecute:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *rowArray = responseObject[@"result"];
        NSLog(@"%@",responseObject);
        for (NSDictionary *dict in rowArray) {
            
            RecardModel *recardModel = [RecardModel mj_objectWithKeyValues:dict];
            [self.recoderData addObject:recardModel];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark -
#pragma mark ------------TableView Delegate----------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
//    if (indexPath.row != 2) {
//        if (indexPath.row == 0) {
//            YYDataAnalyseViewController *dataVC = [[YYDataAnalyseViewController alloc]init];
//            dataVC.userHome_id = self.personalModel.info_id;
//            [self.navigationController pushViewController:dataVC animated:YES];
//        }else{
//            if ([self.type isEqualToString:@"我"]) {
//                YYRecardViewController *recardVC = [[YYRecardViewController alloc]init];
//                [self.navigationController pushViewController:recardVC animated:YES];
//            }else{
//                FamilyRecardViewController *recardVC = [[FamilyRecardViewController alloc]init];
//                recardVC.familyID = self.personalModel.info_id;
//                [self.navigationController pushViewController:recardVC animated:YES];
//            }
//        }
//    }else{
//        YYConnectViewController *connectVC = [[YYConnectViewController alloc]init];
//        [self.navigationController pushViewController:connectVC animated:YES];
//    }
}
#pragma mark -
#pragma mark ------------TableView DataSource----------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {//数据分析
        
        return self.dataAnalysisOpen?1:0;
        
    }else{//病历记录
        
        return self.recoderisOpen?1:0;
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {//数据分析

        return 370*kiphone6H;
    }else{//病历记录

        if (self.recoderData.count>0) {//有记录
            return 85 *kiphone6H *self.recoderData.count+10*kiphone6H;
        }else{//没有记录
            return 300;//空页面
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {//数据分析cell
        YYDataAnalysisTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YYDataAnalysisTVCell" forIndexPath:indexPath];
        cell.personalModel = self.personalModel;
        return cell;
    }else{//病历记录cell
        YYRecoderAnalysisTVCell *homeTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"YYRecoderAnalysisTVCell" forIndexPath:indexPath];
        homeTableViewCell.recoderData = self.recoderData;
        WS(ws);
        homeTableViewCell.recoderCellClick = ^(RecardModel *recardModel) {
            YYDetailRecardViewController *detailRecardVC = [[YYDetailRecardViewController alloc]init];
            detailRecardVC.model = recardModel;
            [ws.navigationController pushViewController:detailRecardVC animated:YES];
            [ws.tableView deselectRowAtIndexPath:indexPath animated:YES];
        };
        return homeTableViewCell;
    }
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50*kiphone6H;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 50*kiphone6H)];
    headerView.backgroundColor = [UIColor whiteColor];
    //titleLabel
    UILabel *titleLabel = [[UILabel  alloc]init];
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    titleLabel.font = [UIFont systemFontOfSize:15];
    if (section == 0) {
        headerView.tag = 101;
        titleLabel.text = @"我的数据分析";
    }else{
        headerView.tag = 102;
        titleLabel.text = @"我的病历档案";
    }
    [headerView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.centerX.offset(-10);
    }];
    //图标
    UIImageView *imageV = [[UIImageView alloc]init];
    if (section == 0) {
        if (self.dataAnalysisOpen) {
            imageV.image = [UIImage imageNamed:@"open"];
        }else{
            imageV.image = [UIImage imageNamed:@"pack_up"];
        }
        
    }else{
        if (self.recoderisOpen) {
            imageV.image = [UIImage imageNamed:@"open"];
        }else{
            imageV.image = [UIImage imageNamed:@"pack_up"];
        }
    }
    [headerView addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right).offset(10);
        make.centerY.offset(0);
    }];
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerViewClick:)];
    [headerView addGestureRecognizer:tapGest];
    return headerView;
    
}
//组头点击事件
-(void)headerViewClick:(UITapGestureRecognizer*)tap{
    UIView *headerView = tap.view;
    if (headerView.tag == 101) {//第一组的组头
        self.dataAnalysisOpen = !self.dataAnalysisOpen;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }else{//第二组的组头
        self.recoderisOpen = !self.recoderisOpen;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
        if (self.recoderisOpen) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionBottom animated:true];
        }
        
    }
}
//#pragma mark - ......::::::: UIActionSheetDelegate :::::::......
//
//- (void)actionSheet:(FMActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//    NSLog(@"clickedButtonAtIndex:%ld",buttonIndex);
//    if (buttonIndex == 0) {
//        if (_currentRow == 0) {
//            YYAutoMeasureViewController *autuMVC = [[YYAutoMeasureViewController alloc]init];
//            autuMVC.navTitle = @"当前血压";
//            [self.navigationController pushViewController:autuMVC animated:YES];
//        }else{
//            YYAutoMeasureViewController *autuMVC = [[YYAutoMeasureViewController alloc]init];
//            autuMVC.navTitle = @"当前体温";
//            [self.navigationController pushViewController:autuMVC animated:YES];
//        }
//        
//        
//    }else if(buttonIndex == 1){
//        if (_currentRow == 0) {
//            YYHandleMeasureViewController *autuMVC = [[YYHandleMeasureViewController alloc]init];
//            autuMVC.navTitle = @"当前血压";
//            [self.navigationController pushViewController:autuMVC animated:YES];
//        }else{
//            YYHandleMeasureViewController *autuMVC = [[YYHandleMeasureViewController alloc]init];
//            autuMVC.navTitle = @"当前体温";
//            [self.navigationController pushViewController:autuMVC animated:YES];
//        }
//    }else{
//        
//    }
//    
//}
//
//- (UIFont *)actionSheet:(FMActionSheet *)actionSheet buttonTextFontAtIndex:(NSInteger)bottonIndex {
//    return [UIFont systemFontOfSize:20];
//}
//
//- (UIColor *)actionSheet:(FMActionSheet *)actionSheet buttonTextColorAtIndex:(NSInteger)bottonIndex {
//    if (bottonIndex == 0) {
//        return [UIColor whiteColor];
//    }
//    
//    return [UIColor whiteColor];
//}
//
//- (UIColor *)actionSheet:(FMActionSheet *)actionSheet buttonBackgroundColorAtIndex:(NSInteger)bottonIndex {
//    return [UIColor whiteColor];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addFamily{
    YYFamilyAccountViewController *familyAVC = [[YYFamilyAccountViewController alloc]init];
    familyAVC.titleStr = @"修改用户信息";
    familyAVC.personalModel = self.personalModel;
    [self.navigationController pushViewController:familyAVC animated:YES];
}
- (UIView *)personInfomation{
    
    UIView *personV = [[UIView alloc]initWithFrame:CGRectMake(10, 10, kScreenW -20, 120 *kiphone6H)];
    personV.backgroundColor = [UIColor whiteColor];
    
    //
    //    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headViewClick)];
    //    [personV addGestureRecognizer:tapGest];
    //
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 140*kiphone6H)];
    headerView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    
    [headerView addSubview:personV];
    
    UIImageView *iconV = [[UIImageView alloc]init];//WithImage:[UIImage imageNamed:@"LIM_"]];
    if ([self.personalModel.avatar isEqualToString:@""]) {
        // avatar.jpg
        iconV.image = [UIImage imageNamed:@"avatar.jpg"];
    }else{
        [iconV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mPrefixUrl,self.personalModel.avatar]]];
    }
    iconV.layer.cornerRadius = 60;
    iconV.clipsToBounds = YES;
    //
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = [NSString stringWithFormat:@"%@    %@岁",self.personalModel.trueName,self.personalModel.age];//@"李美丽(我)    18岁";
    nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
    nameLabel.font = [UIFont systemFontOfSize:14];
    //
    UILabel *idName = [[UILabel alloc]init];
    idName.text = self.personalModel.telephone;//@"18328887563";
    idName.textColor = [UIColor colorWithHexString:@"333333"];
    idName.font = [UIFont systemFontOfSize:13];
    
    
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editBtn setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [editBtn sizeToFit];
    
    
//    UIButton *sureBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
//    sureBtn.layer.cornerRadius = 1.5 *kiphone6;
//    sureBtn.layer.borderWidth = 0.5 *kiphone6;
//    sureBtn.layer.borderColor = [UIColor colorWithHexString:@"e00610"].CGColor;
//    sureBtn.clipsToBounds = YES;
//    [sureBtn setTitle:@"删除" forState:UIControlStateNormal];
//    sureBtn.backgroundColor = [UIColor clearColor];
//    [sureBtn setTitleColor:[UIColor colorWithHexString:@"e00610"] forState:UIControlStateNormal];
//    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
//    //     [sureBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
//    [sureBtn addTarget:self action:@selector(buttonClick1:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //
    [personV addSubview:iconV];
    [personV addSubview:nameLabel];
    [personV addSubview:idName];
    [personV addSubview:editBtn];
//    [self.view addSubview:sureBtn];
    //
    [iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(120 *kiphone6, 120 *kiphone6));
    }];
    //
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(personV.mas_centerY).offset(-7.5 *kiphone6H);
        make.left.equalTo(iconV.mas_right).offset(10 *kiphone6);
    }];
    //
    [idName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(15 *kiphone6H);
        make.left.equalTo(nameLabel.mas_left);
    }];
    
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconV);
        make.right.offset(-10 *kiphone6);
    }];
    
//    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(ws.view).with.offset(-9.5 *kiphone6);
//        make.centerX.equalTo(ws.view);
//        make.size.mas_equalTo(CGSizeMake(150 *kiphone6 ,50 *kiphone6));
//    }];
    
    return headerView;
}
-(void)searchBtnClick:(UIButton*)sender{
    YYFamilyAccountViewController *changeFamilyInfo = [[YYFamilyAccountViewController alloc]init];
    changeFamilyInfo.titleStr = @"修改用户信息";
    changeFamilyInfo.personalModel = self.personalModel;
    [self.navigationController pushViewController:changeFamilyInfo animated:YES];
}
//-(void)buttonClick1:(UIButton *)button{
//    // [button setBackgroundColor:[UIColor whiteColor]];
//    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确认删除家庭用户？" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//        [self httpRequestRemoveUser];
//    }];
//    
//    [alert addAction:cancelAction];
//    [alert addAction:okAction];
//    [self presentViewController:alert animated:YES completion:nil];
//}
//- (void)httpRequestRemoveUser{
//    NSString *tokenStr = [CcUserModel defaultClient].userToken;
//    [[HttpClient defaultClient]requestWithPath:[NSString stringWithFormat:@"%@token=%@&id=%@",mremoveFamily,tokenStr,self.personalModel.info_id] method:0 parameters:nil prepareExecute:^{
//        
//    } success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@",responseObject);
//        [self.navigationController popViewControllerAnimated:YES];
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@",error);
//    }];
//    
//}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
