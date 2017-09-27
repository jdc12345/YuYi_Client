//
//  YYPersonalInfoDetailVC.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/9/27.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYPersonalInfoDetailVC.h"
#import "YYAutoMeasureViewController.h"
#import "YYHandleMeasureViewController.h"
#import "YYConnectViewController.h"
#import "UIBarButtonItem+Helper.h"
#import "YYFamilyAccountViewController.h"
#import <Masonry.h>
#import "YYPersonalInfoTableViewCell.h"
#import "YYDataAnalyseViewController.h"
#import "YYDetailRecardViewController.h"
#import "YYPInfomartionViewController.h"
#import <UIImageView+WebCache.h>
#import "FamilyRecardViewController.h"
#import "YYRecardViewController.h"
#import "CcUserModel.h"
#import "HttpClient.h"

@interface YYPersonalInfoDetailVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
//@property (nonatomic, strong) FMActionSheet *fmActionS;
@property (nonatomic, assign) NSInteger currentRow;

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
        [_tableView registerClass:[YYPersonalInfoTableViewCell class] forCellReuseIdentifier:@"YYPersonalInfoTableViewCell"];
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
    self.title = @"个人信息";
    self.tableView.tableHeaderView = [self personInfomation];
    
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
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60 *kiphone6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *nameList = @[@"我的数据分析",@"我的病历档案",@"刘德华（爷爷）"];
    YYPersonalInfoTableViewCell *homeTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"YYPersonalInfoTableViewCell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        homeTableViewCell.iconV.image = [UIImage imageNamed:[NSString stringWithFormat:@"cell1"]];
        homeTableViewCell.titleLabel.text = nameList[indexPath.row];
        
        
    }else if(indexPath.row == 1){
        homeTableViewCell.iconV.image = [UIImage imageNamed:[NSString stringWithFormat:@"cell2"]];
        homeTableViewCell.titleLabel.text = nameList[indexPath.row];
        
    }else{
        //        [homeTableViewCell addOtherCell];
        homeTableViewCell.iconV.image = [UIImage imageNamed:[NSString stringWithFormat:@"cell1"]];
        homeTableViewCell.titleLabel.text = nameList[indexPath.row];
        
    }
    homeTableViewCell.backgroundColor = [UIColor blackColor];
    [homeTableViewCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return homeTableViewCell;
    
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
        make.centerY.equalTo(personV).with.offset(0);
        make.left.equalTo(personV).with.offset(25 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(50 *kiphone6, 50 *kiphone6));
    }];
    //
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(personV).with.offset(24 *kiphone6);
        make.left.equalTo(iconV.mas_right).with.offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(140 *kiphone6, 14 *kiphone6));
    }];
    //
    [idName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).with.offset(10 *kiphone6);
        make.left.equalTo(nameLabel.mas_left);
        make.size.mas_equalTo(CGSizeMake(260 *kiphone6, 13 *kiphone6));
    }];
    
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(personV).with.offset(15 *kiphone6);
        make.right.equalTo(personV).with.offset(-10 *kiphone6);
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
-(void)buttonClick1:(UIButton *)button{
    // [button setBackgroundColor:[UIColor whiteColor]];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确认删除家庭用户？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self httpRequestRemoveUser];
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)httpRequestRemoveUser{
    NSString *tokenStr = [CcUserModel defaultClient].userToken;
    [[HttpClient defaultClient]requestWithPath:[NSString stringWithFormat:@"%@token=%@&id=%@",mremoveFamily,tokenStr,self.personalModel.info_id] method:0 parameters:nil prepareExecute:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
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
