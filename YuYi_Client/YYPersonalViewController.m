//
//  YYPersonalViewController.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/17.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYPersonalViewController.h"
#import "YYHomeNewTableViewCell.h"
#import "YYSectionViewController.h"
#import "YYPersonalTableViewCell.h"
#import "YYRecardViewController.h"
#import "YYPInfomartionViewController.h"
#import "YYSettingViewController.h"
#import "YYEquipmentViewController.h"
#import "YYFamilyAddViewController.h"
#import "YYShopCartVC.h"
#import "YYOrderDetailVC.h"
#import "YYAddressEditVC.h"
#import "NotficationViewController.h"
#import "HttpClient.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "CcUserModel.h"
#import "YYHomeUserModel.h"
#import "UILabel+Addition.h"
#import "YYPersonalDetailInfoVC.h"

#define myToken @"6DD620E22A92AB0AED590DB66F84D064"
@interface YYPersonalViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSArray *iconList;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *genderV;//性别
@property (nonatomic, strong) UIImageView *iconView;//头像
@property (nonatomic, strong) YYHomeUserModel *personalModel;//用户个人信息

@end

@implementation YYPersonalViewController

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
        [_tableView registerClass:[YYPersonalTableViewCell class] forCellReuseIdentifier:@"YYPersonalTableViewCell"];
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
 //    [self httpRequest];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
   
    // ,@[@"购物车",@"订单详情"] ,@[@"Personal-shopping -icon-",@"order_icon_"]
    CcUserModel *model = [CcUserModel defaultClient];
    if (![model.telephoneNum isEqualToString:@"18511694068"]) {
    self.dataSource = [[NSMutableArray alloc]initWithArray:@[@[@"电子病例",@"消息"],@[@"家庭用户管理",@"用户设备管理",@"设置"]]];
    self.iconList =@[@[@"Personal-EMR-icon-",@"Personal-message-icon-"],@[@"family-icon--1",@"equipment-icon-",@"Set-icon-"]];
    }else{
        self.dataSource = [[NSMutableArray alloc]initWithArray:@[@[@"消息"],@[@"家庭用户管理",@"用户设备管理",@"设置"]]];
        self.iconList =@[@[@"Personal-message-icon-"],@[@"family-icon--1",@"equipment-icon-",@"Set-icon-"]];
    }
    
//    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 70 *kiphone6)];
//    headView.backgroundColor = [UIColor whiteColor];
//    UIImageView *imageV =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_icon"]];
//    [headView addSubview:imageV];
//    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(headView).with.offset(20 *kiphone6);
//        make.left.equalTo(headView).with.offset(20 *kiphone6);
//        make.size.mas_equalTo(CGSizeMake((kScreenW -40*kiphone6), 30 *kiphone6));
//    }];
    self.tableView.tableHeaderView = [self personInfomation];
    if (@available(iOS 11.0, *)) {
        //iOS 11
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{//不是iOS 11
        self.automaticallyAdjustsScrollViewInsets = false;
    }
   // [self tableView];
    
    // Do any additional setup after loading the view.
}
- (UIView *)personInfomation{
    
    //添加头部视图
//    UIView *headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 310)];
//    headerView.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1"];
//    [self.view addSubview:headerView];
    //添加背景视图
    UIImageView *backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 220*kiphone6H)];
    backView.userInteractionEnabled = true;
//    [headerView addSubview:backView];
    UIImage *oldImage = [UIImage imageNamed:@"photo_mine"];
    backView.image = oldImage;
    //添加头像
    UIImageView *iconView = [[UIImageView alloc]init];
    UIImage *iconImage = [UIImage imageNamed:@"avatar.jpg"];
    iconView.image = iconImage;
    [backView addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView);
        make.top.offset(50);
        make.width.height.offset(79);
    }];
    iconView.layer.cornerRadius=79*0.5;//裁成圆角
    iconView.layer.masksToBounds=YES;//隐藏裁剪掉的部分
    iconView.layer.borderWidth = 1.5;
    iconView.layer.borderColor = [UIColor colorWithHexString:@"ffffff"].CGColor;
    iconView.userInteractionEnabled = true;
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(event:)];
    //将手势添加至需要相应的view中
    [iconView addGestureRecognizer:tapGesture];
    //添加名字
    UILabel *namelabel = [UILabel labelWithText:@"姓名" andTextColor:[UIColor colorWithHexString:@"#ffffff"] andFontSize:14];
    [backView addSubview:namelabel];
    [namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(iconView);
        make.top.equalTo(iconView.mas_bottom).offset(10);
    }];
    
    self.nameLabel = namelabel;
    self.iconView = iconView;
    //添加性别标识
    UIImageView *imageV = [[UIImageView alloc]init];
    imageV.image = [UIImage imageNamed:@"woman"];
    [imageV sizeToFit];
    [backView addSubview:imageV];
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(namelabel);
        make.left.equalTo(namelabel.mas_right).offset(5);
    }];
    self.genderV = imageV;
    return backView;
}
- (void)headViewClick{
    YYPInfomartionViewController *pInfoVC = [[YYPInfomartionViewController alloc]init];
    pInfoVC.personalModel = self.personalModel;
    [self.navigationController pushViewController:pInfoVC animated:YES];
}
//执行手势触发的方法：
- (void)event:(UITapGestureRecognizer *)gesture
{
    YYPersonalDetailInfoVC *pvc = [[YYPersonalDetailInfoVC alloc]init];
    pvc.personalModel = self.personalModel;
    [self.navigationController pushViewController:pvc animated:true];
    
}
#pragma mark -
#pragma mark ------------Tableview Delegate----------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CcUserModel *model = [CcUserModel defaultClient];
    if (indexPath.section == 0){
        if (indexPath.row == 0 && ![model.telephoneNum isEqualToString:@"18511694068"]) {
            [self.navigationController pushViewController:[[YYRecardViewController alloc]init] animated:YES];
        }else{
            NotficationViewController *shopVC = [[NotficationViewController alloc]init];
            [self.navigationController pushViewController:shopVC animated:YES];
        }
    }else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
            {
                YYFamilyAddViewController *familyVC = [[YYFamilyAddViewController alloc]init];
                familyVC.personalModel = self.personalModel;
                [self.navigationController pushViewController:familyVC animated:YES];
            }
                break;
            case 1:
            {
                YYEquipmentViewController *equipmentVC = [[YYEquipmentViewController alloc]init];
                [self.navigationController pushViewController:equipmentVC animated:YES];
            }
                break;
            case 2:
            {
                YYSettingViewController *setVC = [[YYSettingViewController alloc]init];
                [self.navigationController pushViewController:setVC animated:YES];
            }
                break;
            default:
                break;
        }
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark -
#pragma mark ------------TableView DataSource----------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.dataSource[section];
    return array.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 46 *kiphone6H;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 10)];
    headerView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    
    return headerView;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYPersonalTableViewCell *homeTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"YYPersonalTableViewCell" forIndexPath:indexPath];
    
    homeTableViewCell.titleLabel.text = self.dataSource[indexPath.section][indexPath.row];
    homeTableViewCell.iconV.image = [UIImage imageNamed:self.iconList[indexPath.section][indexPath.row]];
    
    return homeTableViewCell;
    
}

#pragma mark -
#pragma mark ------------Http client----------------------
- (void)httpRequest{
    NSString *tokenStr = [CcUserModel defaultClient].userToken;
    [[HttpClient defaultClient]requestWithPath:[NSString stringWithFormat:@"%@%@",mMyInfo,tokenStr] method:0 parameters:nil prepareExecute:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"res = = %@",responseObject);
        NSDictionary *dict = responseObject[@"result"];
//        CcUserModel *userMoedel = [CcUserModel mj_objectWithKeyValues:responseObject];
        YYHomeUserModel *userMoedel = [YYHomeUserModel mj_objectWithKeyValues:dict];
        
        
        NSLog(@"%@",userMoedel.avatar);
        
        
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mPrefixUrl,userMoedel.avatar]]];
        
        self.nameLabel.text = [NSString stringWithFormat:@"%@ %@岁",userMoedel.trueName,userMoedel.age];
        if ([userMoedel.gender containsString:@"男"]) {
            [self.genderV setImage:[UIImage imageNamed:@"boy_mine"]];
        }else{
            [self.genderV setImage:[UIImage imageNamed:@"boy_mine"]];
        }
        self.personalModel = userMoedel;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = false;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    //去掉导航栏底部的黑线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self httpRequest];
}
//如果仅设置当前页导航透明，需加入下面方法
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

-(UIStatusBarStyle)preferredStatusBarStyle{//如果有导航栏必须在导航栏重写- (UIViewController *)childViewControllerForStatusBarStyle{
    //    return self.topViewController;
    //}
    return UIStatusBarStyleLightContent;
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
