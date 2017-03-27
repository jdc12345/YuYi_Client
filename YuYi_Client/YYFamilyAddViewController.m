//
//  YYFamilyAddViewController.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/27.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYFamilyAddViewController.h"
#import "UIColor+Extension.h"
#import "YYMeasureTableViewCell.h"
#import "FMActionSheet.h"
#import "YYAutoMeasureViewController.h"
#import "YYHandleMeasureViewController.h"
#import "YYConnectViewController.h"
#import "YYFamilyAddTableViewCell.h"
#import "UIBarButtonItem+Helper.h"
#import "YYFamilyAccountViewController.h"
#import "YYPersonalInfoViewController.h"
#import "HttpClient.h"
#import "CcUserModel.h"
#import "YYHomeUserModel.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
@interface YYFamilyAddViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) FMActionSheet *fmActionS;
@property (nonatomic, assign) NSInteger currentRow;
@property (nonatomic, strong) NSMutableArray *userList;

@end

@implementation YYFamilyAddViewController

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
        [_tableView registerClass:[YYFamilyAddTableViewCell class] forCellReuseIdentifier:@"YYFamilyAddTableViewCell"];
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
- (NSMutableArray *)userList{
    if (_userList == nil) {
        _userList = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return _userList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"家庭用户管理";
    
    [self httpRequestForUser];

    
    
    
    [UIColor colorWithHexString:@"25f368"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" normalColor:[UIColor colorWithHexString:@"25f368"] highlightedColor:[UIColor colorWithHexString:@"25f368"] target:self action:@selector(addFamily)];
    // Do any additional setup after loading the view.
}
#pragma mark -
#pragma mark ------------TableView Delegate----------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    YYPersonalInfoViewController *personalInfo = [[YYPersonalInfoViewController alloc]init];
    personalInfo.titleStr = @"李苗";
    [self.navigationController pushViewController:personalInfo animated:YES];

}
#pragma mark -
#pragma mark ------------TableView DataSource----------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.userList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70 *kiphone6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *nameList = @[@"李苗（我）",@"李美丽（妈妈）",@"刘德华（爷爷）"];
    YYFamilyAddTableViewCell *homeTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"YYFamilyAddTableViewCell" forIndexPath:indexPath];
//    if (indexPath.row == 0) {
//        homeTableViewCell.iconV.image = [UIImage imageNamed:[NSString stringWithFormat:@"cell1"]];
//        homeTableViewCell.titleLabel.text = nameList[indexPath.row];
//
//        
//    }else if(indexPath.row == 1){
//        homeTableViewCell.iconV.image = [UIImage imageNamed:[NSString stringWithFormat:@"cell2"]];
//        homeTableViewCell.titleLabel.text = nameList[indexPath.row];
//
//    }else{
////        [homeTableViewCell addOtherCell];
//        homeTableViewCell.iconV.image = [UIImage imageNamed:[NSString stringWithFormat:@"cell1"]];
//        homeTableViewCell.titleLabel.text = nameList[indexPath.row];
//        
//    }
    YYHomeUserModel *userModel = self.userList[indexPath.row];
    [homeTableViewCell.iconV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mPrefixUrl,userModel.avatar]]];
    //.image = [UIImage imageNamed:[NSString stringWithFormat:@"cell1"]];
    homeTableViewCell.titleLabel.text = userModel.trueName;//nameList[indexPath.row];
    [homeTableViewCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return homeTableViewCell;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addFamily{
    YYFamilyAccountViewController *familyAVC = [[YYFamilyAccountViewController alloc]init];
    [self.navigationController pushViewController:familyAVC animated:YES];
}


- (void)httpRequestForUser{
    NSString *tokenStr = [CcUserModel defaultClient].userToken;
    [[HttpClient defaultClient]requestWithPath:[NSString stringWithFormat:@"%@token=%@",mUserAndMeasureInfo,tokenStr] method:0 parameters:nil prepareExecute:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *result = responseObject[@"result"];
        for (NSDictionary *dict in result) {
            YYHomeUserModel *userModel = [YYHomeUserModel mj_objectWithKeyValues:dict];
            [self.userList addObject:userModel];
        }
        
        
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 0 *kiphone6)];
        headView.backgroundColor = [UIColor clearColor];
        self.tableView.tableHeaderView = headView;
        
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
