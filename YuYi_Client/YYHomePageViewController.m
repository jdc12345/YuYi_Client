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

@interface YYHomePageViewController ()<UITableViewDataSource, UITableViewDelegate,SDWebImageManagerDelegate,SDWebImageOperation>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

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
        _tableView.tableHeaderView = [[YYHomeHeadView alloc]init];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"首页";
    
    
    [self tableView];
    
    
    // 左侧地址按钮
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [leftButton setFrame:CGRectMake(0,0,40, 30)];
    
    [leftButton setTitle:@"北京" forState:UIControlStateNormal];
    
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [leftButton addTarget:self action:@selector(back_click:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    // 右侧通知按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightButton setFrame:CGRectMake(0,0,20, 20)];
    
    [rightButton setBackgroundImage:[UIImage imageNamed:@"notfic_select"] forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(back_click:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    UIImageView *searchImageV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 300, 26)];
    searchImageV.image = [UIImage imageNamed:@"search_icon"];
    self.navigationItem.titleView = searchImageV;
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark ------------TableView Delegate----------------------

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
    
    UILabel *sectionName = [[UILabel alloc]init];
    sectionName.text = title;
    sectionName.textColor = [UIColor colorWithHexString:@"6a6a6a"];
    sectionName.font = [UIFont systemFontOfSize:14];
    
    UIButton *clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [clickButton setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    
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
