//
//  YYPInfomartionViewController.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/24.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYPInfomartionViewController.h"
#import "UIColor+Extension.h"
#import "YYHomeNewTableViewCell.h"
#import <Masonry.h>
#import "YYSectionViewController.h"
#import "YYPersonalTableViewCell.h"
#import "YYRecardTableViewCell.h"
#import "YYPInfomationTableViewCell.h"
#import "ZYActionSheet.h"
@interface YYPInfomartionViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSArray *iconList;

@end

@implementation YYPInfomartionViewController

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
    self.title = @"个人编辑";
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    
    
    self.dataSource = [[NSMutableArray alloc]initWithArray:@[@"用户名",@"性别",@"年龄",@"身份证号码",@"籍贯"]];
    //    self.iconList =@[@"Personal-EMR-icon-",@"Personal-message-icon-",@"Personal-shopping -icon-",@"order_icon_",@"family-icon--1",@"equipment-icon-",@"goods-icon-",@"Set-icon-"];
    
    
    //    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 70 *kiphone6)];
    //    headView.backgroundColor = [UIColor whiteColor];
    //    UIImageView *imageV =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_icon"]];
    //    [headView addSubview:imageV];
    //    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(headView).with.offset(20 *kiphone6);
    //        make.left.equalTo(headView).with.offset(20 *kiphone6);
    //        make.size.mas_equalTo(CGSizeMake((kScreenW -40*kiphone6), 30 *kiphone6));
    //    }];
    //   self.tableView.tableHeaderView = [self personInfomation];
    
    [self tableView];
    
    // Do any additional setup after loading the view.
}
- (UIView *)personInfomation{
    
    UIView *personV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 90 *kiphone6)];
    personV.backgroundColor = [UIColor whiteColor];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 10)];
    headerView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    
    [personV addSubview:headerView];
    
    UIImageView *iconV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"LIM_"]];
    iconV.layer.cornerRadius = 25;
    iconV.clipsToBounds = YES;
    //
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"李美丽";
    nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
    nameLabel.font = [UIFont systemFontOfSize:14];
    //
    UILabel *idName = [[UILabel alloc]init];
    idName.text = @"用户：18328887563";
    idName.textColor = [UIColor colorWithHexString:@"333333"];
    idName.font = [UIFont systemFontOfSize:13];
    //
    [personV addSubview:iconV];
    [personV addSubview:nameLabel];
    [personV addSubview:idName];
    //
    [iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(personV).with.offset(10);
        make.left.equalTo(personV).with.offset(25 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(50 *kiphone6, 50 *kiphone6));
    }];
    //
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(personV).with.offset(31.5 *kiphone6);
        make.left.equalTo(iconV.mas_right).with.offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(140 *kiphone6, 14 *kiphone6));
    }];
    //
    [idName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).with.offset(10 *kiphone6);
        make.left.equalTo(nameLabel.mas_left);
        make.size.mas_equalTo(CGSizeMake(260 *kiphone6, 13 *kiphone6));
    }];
    
    return personV;
}

#pragma mark -
#pragma mark ------------Tableview Delegate----------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1) {
       ZYActionSheet *sheet = [[ZYActionSheet alloc] initWithTitle:@"性别"
                                                       buttonTitles:[NSArray arrayWithObjects:@"男",@"女", nil]
                                                  cancelButtonTitle:@""
                                                           delegate:(id<ZYActionSheetDelegate>)self
                                                            buttonW:200 *kiphone6];
        sheet.titleFont = [UIFont systemFontOfSize:20];
        sheet.titleBackgroundColor = [UIColor colorWithHexString:@"f4f5f8"];
        sheet.titleColor = [UIColor colorWithHexString:@"666666"];
        sheet.lineColor = [UIColor colorWithHexString:@"dbdce4"];
        [sheet showWithFrame:CGRectMake((kScreenW - 200 *kiphone6)/2.0, (kScreenH - 135 *kiphone6)/2.0, 200 *kiphone6, 135 *kiphone6)];
    }
//    [self.navigationController pushViewController:[[YYSectionViewController alloc]init] animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark -
#pragma mark ------------TableView DataSource----------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40 *kiphone6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80 *kiphone6;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *allHeadSectionV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 80 *kiphone6)];
    allHeadSectionV.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, kScreenW, 70 *kiphone6)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *iconV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"LIM_"]];
    iconV.layer.cornerRadius = 25;
    iconV.clipsToBounds = YES;
    
    [headerView addSubview:iconV];
    
    [iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.left.equalTo(headerView).with.offset(25 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(50 *kiphone6, 50 *kiphone6));
    }];
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"头像";
    nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
    nameLabel.font = [UIFont systemFontOfSize:15];
    
    
    [headerView addSubview:nameLabel];
    
    WS(ws);
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.right.equalTo(headerView).with.offset(-10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(35 ,15));
    }];
    
    [allHeadSectionV addSubview:headerView];
    return allHeadSectionV;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYPInfomationTableViewCell *homeTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"YYPInfomationTableViewCell" forIndexPath:indexPath];
    
   
    
    homeTableViewCell.titleLabel.text = self.dataSource[indexPath.row];
    if (indexPath.row ==  0) {
        homeTableViewCell.seeRecardLabel.text = @"18511694068";
         homeTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else if (indexPath.row ==  1) {
        homeTableViewCell.seeRecardLabel.text = @"男";
    }else if (indexPath.row ==  2) {
        [homeTableViewCell setType:@"celltextfield"];
        homeTableViewCell.editInfoText.text = @"26";
         homeTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else if (indexPath.row ==  3) {
        homeTableViewCell.seeRecardLabel.text = @"2301221993077220014";
        homeTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else if (indexPath.row ==  4) {
        homeTableViewCell.seeRecardLabel.text = @"黑龙江省哈尔滨";
        homeTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //    homeTableViewCell.iconV.image = [UIImage imageNamed:self.iconList[indexPath.row]];
    
    return homeTableViewCell;
    
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
