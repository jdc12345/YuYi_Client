//
//  YYSectorViewController.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/21.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYSectorViewController.h"
#import <Masonry.h>
#import "SectorCalendar.h"
#import "UIColor+Extension.h"
#import "YYSectorTableViewCell.h"
#import "ZYAlertSView.h"
#import "HttpClient.h"
#import "AppointmentModel.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "CcUserModel.h"
#import "YYHomeUserModel.h"
#import "YYPInfomartionViewController.h"
@interface YYSectorViewController ()<UIScrollViewDelegate,UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableDataSource;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *dateList;
@property (nonatomic, strong) NSMutableArray *userList;
@property (nonatomic, weak) ZYAlertSView *alertView;
@property (nonatomic, weak) UIView *selectView;
@property (nonatomic, copy) NSString *dateStr;
@property (nonatomic, assign) BOOL isMorning;
@property (nonatomic, assign) NSInteger selectUser;
@property (nonatomic, assign) NSInteger selectDoctor;

@end

@implementation YYSectorViewController
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH -64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.indicatorStyle =
        _tableView.rowHeight = kScreenW *77/320.0 +10;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        //        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        [_tableView registerClass:[YYSectorTableViewCell class] forCellReuseIdentifier:@"YYSectorTableViewCell"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [self.view addSubview:_tableView];
        [self.view sendSubviewToBack:_tableView];
        
    }
    return _tableView;
}
- (NSMutableArray *)tableDataSource{
    if (_tableDataSource == nil) {
        _tableDataSource = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return _tableDataSource;
}
- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return _dataSource;
}
- (NSMutableArray *)dateList{
    if (_dateList == nil) {
        _dateList = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return _dateList;
}
- (NSMutableArray *)userList{
    if (_userList == nil) {
        _userList = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return _userList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.sectorTitle;
    [self httpRequest];
    [self httpRequestForUser];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    
    // Do any additional setup after loading the view.
}
- (UIScrollView *)updataView{
    WS(ws);
    
    NSArray *dateList = @[@"01/13",@"01/14",@"01/15",@"01/16",@"01/17",@"01/18",@"01/19"];
    NSMutableArray *currentDate = [[NSMutableArray alloc]initWithCapacity:2];
    for (NSString *dateStr in self.dateList) {
        NSString *month= [dateStr substringWithRange:NSMakeRange(4,2)];
        NSString *day= [dateStr substringWithRange:NSMakeRange(6,2)];
        [currentDate addObject:[NSString stringWithFormat:@"%@/%@",month,day]];
    }
    NSLog(@"currentDate = %@",currentDate);
    dateList = currentDate;
    
    UIScrollView *scrollTrendView = [[UIScrollView alloc]init];
    scrollTrendView.contentSize = CGSizeMake(700 *kiphone6, 60 *kiphone6);
    scrollTrendView.pagingEnabled = YES;
    scrollTrendView.showsHorizontalScrollIndicator = NO;
    scrollTrendView.showsVerticalScrollIndicator = NO;
    scrollTrendView.bounces = NO;
    scrollTrendView.delegate = self;
    scrollTrendView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    
    for (int i = 0; i <7; i++) {
        SectorCalendar *sectorView = [[SectorCalendar alloc]init];
        [sectorView setAppointment_date:dateList[i]];
        sectorView.tag = 120 +i;
        
        // block 回调
        sectorView.timeClick = ^(BOOL isMorning){
            NSLog(@"%ld,%@",sectorView.tag -120,isMorning?@"上午":@"下午");
            self.isMorning = isMorning;
            self.tableDataSource = self.dataSource[sectorView.tag -120];
            // NSLog(@"%@",self.tableDataSource);
            [self.tableView reloadData];
            for (int j = 0; j <7 ;  j++) {
                SectorCalendar *otherV = (SectorCalendar *)[scrollTrendView viewWithTag:120 +j];
                if (otherV != sectorView) {
                    [otherV resumeView];
                }
                
            }
        };
        if (i == 0) {
            // 设置为默认选中状态
            [sectorView selectInit];
        }
        [scrollTrendView addSubview:sectorView];
        
        [sectorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(scrollTrendView).with.offset(0);
            make.left.equalTo(scrollTrendView).with.offset(i*100*kiphone6);
            make.size.mas_equalTo(CGSizeMake(100 *kiphone6 ,60 *kiphone6));
        }];
    }
    // [self.view addSubview:scrollTrendView];
    scrollTrendView.contentOffset = CGPointMake(0, 0);
    
    
    //    [scrollTrendView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(ws.tableView).with.offset(0);
    //        make.left.equalTo(ws.tableView).with.offset(0);
    //        make.size.mas_equalTo(CGSizeMake(kScreenW ,70 *kiphone6));
    //    }];
    scrollTrendView.frame = CGRectMake(0, 0, kScreenW, 70*kiphone6);
    
    return scrollTrendView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark ------------Tableview Delegate----------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    [self.navigationController pushViewController:[[YYSectionViewController alloc]init] animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark -
#pragma mark ------------TableView DataSource----------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableDataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120 *kiphone6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AppointmentModel *appointmentModel = self.tableDataSource[indexPath.row];
    YYSectorTableViewCell *homeTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"YYSectorTableViewCell" forIndexPath:indexPath];
    [homeTableViewCell.iconV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mPrefixUrl,appointmentModel.avatar]]];//[UIImage imageNamed:[NSString stringWithFormat:@"cell%ld",(indexPath.row)%2 +1]];
    homeTableViewCell.titleLabel.text = appointmentModel.trueName;
    if (self.isMorning) {
        homeTableViewCell.countLabel.text = [NSString stringWithFormat:@"余号%@",appointmentModel.beforNum];
    }else{
        homeTableViewCell.countLabel.text = [NSString stringWithFormat:@"余号%@",appointmentModel.afterNum];
    }
    homeTableViewCell.bannerClick = ^(BOOL isClick){
        [self appointmentDoctor];
        self.selectDoctor = indexPath.row;
    };
//    WS(ws);
//    if (indexPath.row%2) {
//        homeTableViewCell.bannerClick = ^(BOOL isClick){
//            [ws back_click];
//            ws.selectDoctor = indexPath.row;
//        };
//    }else{
//        homeTableViewCell.bannerClick = ^(BOOL isClick){
//            [ws emptyClick];
//            ws.selectDoctor = indexPath.row;
//        };
//    }
    
    [homeTableViewCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return homeTableViewCell;
    
}
- (void)appointmentDoctor{
    YYHomeUserModel *userModel = self.userList[0];
    if ([userModel.age isEqualToString:@""]||[userModel.trueName isEqualToString:@""]||[userModel.gender isEqualToString:@""]) {
        [self emptyClick];
    }else{
        [self back_click];
    }
}

- (void)back_click{
    if (self.userList.count >0) {
        
        
        CGFloat alertW = 335 *kiphone6;
        CGFloat alertH = 310 *kiphone6;
        
        // titleView
        UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, alertW, 80 *kiphone6)];
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"选择挂号人";
        titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
        titleLabel.font = [UIFont systemFontOfSize:20];
        
        UILabel *lineLabel = [[UILabel alloc]init];
        lineLabel.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
        
        [titleView addSubview:titleLabel];
        [titleView addSubview:lineLabel];
        
        WS(ws);
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(titleView);
            make.size.mas_equalTo(CGSizeMake(120 ,20));
        }];
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleView);
            make.bottom.equalTo(titleView);
            make.size.mas_equalTo(CGSizeMake(alertW ,1));
        }];
        // 选项view
        UIView *selectView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame), alertW, 170 *kiphone6)];
        self.selectUser = 0;
        NSArray *nameList = @[@"李苗（我）",@"李美丽（妈妈）",@"刘德华（爷爷）"];
        NSInteger peopleCount = self.userList.count;        // 人数
        for (int i = 0; i <= peopleCount ; i++) {
            NSInteger num;
            if (i < peopleCount) {
                num = i;
            }else{
                num = 0;
            }
            YYHomeUserModel *userModel = self.userList[num];
            CGFloat x_padding = i%2 * 157.5 *kiphone6;
            CGFloat y_padding = i/2 * 60 *kiphone6;
            
            UIView *btnView = [[UIView alloc]initWithFrame:CGRectMake(10 +x_padding, 25 +y_padding, 157.5 *kiphone6,  60*kiphone6)];
            btnView.backgroundColor = [UIColor whiteColor];
            //        btnView.layer.cornerRadius = 1.5;
            //        btnView.layer.borderWidth = 0.5;
            //        btnView.layer.borderColor = [UIColor colorWithHexString:@"25f368"].CGColor;
            btnView.tag = 200 +i;
            
            
            UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
            
            [btnView addGestureRecognizer:tapGest];
            
            if (i == 0) {
                [self tapClick:tapGest];
            }
            
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10 *kiphone6, 14 *kiphone6, 32 *kiphone6, 32 *kiphone6)];
            imageV.layer.cornerRadius = 16 *kiphone6;
            imageV.clipsToBounds = YES;
            
            UILabel *nameLabel = [[UILabel alloc]init];
            nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
            nameLabel.font = [UIFont systemFontOfSize:13];
            if (i != peopleCount) {
                nameLabel.text = userModel.trueName;
                //            imageV.image = [UIImage imageNamed:@"LIM_"];
                [imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mPrefixUrl,userModel.avatar]]];
            }else{
                nameLabel.text = @"添加";
                imageV.image = [UIImage imageNamed:@"add-1"];
            }
            [btnView addSubview:imageV];
            [btnView addSubview:nameLabel];
            
            [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(imageV.mas_right).with.offset(10);
                make.centerY.equalTo(btnView);
                make.right.equalTo(btnView);
                make.height.mas_equalTo(13 *kiphone6);
            }];
            
            [selectView addSubview:btnView];
            
            
            
        }
        self.selectView = selectView;
        
        // 取消确定view
        UIView *sureView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(selectView.frame), alertW, 60 *kiphone6)];
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(alertClick:) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
        
        [sureView addSubview:cancelBtn];
        
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(sureView);
            make.top.equalTo(sureView);
            make.size.mas_equalTo(CGSizeMake(alertW/2.0, 60 *kiphone6));
        }];
        
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(alertClick:) forControlEvents:UIControlEventTouchUpInside];
        sureBtn.backgroundColor = [UIColor colorWithHexString:@"25f368"];
        
        [sureView addSubview:sureBtn];
        
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(sureView);
            make.top.equalTo(sureView);
            make.size.mas_equalTo(CGSizeMake(sureView.frame.size.width/2.0, 60 *kiphone6));
        }];
        
        
        
        ZYAlertSView *alertV = [[ZYAlertSView alloc]initWithContentSize:CGSizeMake(alertW, alertH) TitleView:titleView selectView:selectView sureView:sureView];
        [alertV show];
        self.alertView = alertV;
    }
}
- (void)alertClick:(UIButton *)sender{
    if ([sender.currentTitle isEqualToString:@"取消"]) {
        [self.alertView dismiss:nil];
    }else if([sender.currentTitle isEqualToString:@"确认"]){
        [self httpRequestForAppointment];
    }else{
        YYHomeUserModel *userModel = self.userList[0];
        YYPInfomartionViewController *personInfoVC = [[YYPInfomartionViewController alloc]init];
        personInfoVC.personalModel = userModel;
        [self.navigationController pushViewController:personInfoVC animated:YES];
    }
}
- (void)tapClick:(UITapGestureRecognizer *)tapGesture{
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)tapGesture;
    NSInteger index = singleTap.view.tag;
    NSLog(@"tag =%ld",index);
    if (index -200 == self.userList.count) {
        // 添加按钮
    }else{
        self.selectUser = index -200;
        for (int i = 0; i < self.userList.count; i++) {
            if (index == i +200) {
                singleTap.view.layer.cornerRadius = 1.5;
                singleTap.view.layer.borderWidth = 0.5;
                singleTap.view.layer.borderColor = [UIColor colorWithHexString:@"25f368"].CGColor;
            }else{
                NSInteger tag = i +200;
                UIView *view = [self.selectView viewWithTag:tag];
                view.layer.borderWidth = 0;
            }
        }
    }
}

/////////////////
- (void)emptyClick{
    CGFloat alertW = 335 *kiphone6;
    CGFloat alertH = 310 *kiphone6;
    
    // titleView
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, alertW, 80 *kiphone6)];
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"提示";
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    titleLabel.font = [UIFont systemFontOfSize:20];
    
    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    
    [titleView addSubview:titleLabel];
    [titleView addSubview:lineLabel];
    
    WS(ws);
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(titleView);
        make.size.mas_equalTo(CGSizeMake(120 ,20));
    }];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleView);
        make.bottom.equalTo(titleView);
        make.size.mas_equalTo(CGSizeMake(alertW ,1));
    }];
    // 选项view
    UIView *selectView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame), alertW, 170 *kiphone6)];
    
    UILabel *promptLabel = [[UILabel alloc]init];
    promptLabel.text = @"你还没有完善个人信息无法挂号，现在去完善?";
    promptLabel.textColor = [UIColor colorWithHexString:@"333333"];
    promptLabel.font = [UIFont systemFontOfSize:16];
    promptLabel.numberOfLines = 2;
    
    [selectView addSubview:promptLabel];
    [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(selectView);
        make.size.mas_equalTo(CGSizeMake(225 *kiphone6 ,40));
    }];
    
    
    
    // 取消确定view
    UIView *sureView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(selectView.frame), alertW, 60 *kiphone6)];
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(alertClick:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    
    [sureView addSubview:cancelBtn];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sureView);
        make.top.equalTo(sureView);
        make.size.mas_equalTo(CGSizeMake(alertW/2.0, 60 *kiphone6));
    }];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"去完善" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(alertClick:) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.backgroundColor = [UIColor colorWithHexString:@"25f368"];
    
    [sureView addSubview:sureBtn];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(sureView);
        make.top.equalTo(sureView);
        make.size.mas_equalTo(CGSizeMake(sureView.frame.size.width/2.0, 60 *kiphone6));
    }];
    
    
    
    ZYAlertSView *alertV = [[ZYAlertSView alloc]initWithContentSize:CGSizeMake(alertW, alertH) TitleView:titleView selectView:selectView sureView:sureView];
    [alertV show];
    self.alertView = alertV;
}
- (void)httpRequest{
    NSLog(@"cid = %@",self.cid);
    [[HttpClient defaultClient]requestWithPath:[NSString stringWithFormat:@"%@%@",mAppointmentList,self.cid] method:0 parameters:nil prepareExecute:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSArray *dateArray = responseObject[@"result"];
        for (NSDictionary *dict in dateArray) {
            
            
            NSArray *dateNumList = dict[@"datenumberList"];
            NSMutableArray *datebydayList = [[NSMutableArray alloc]initWithCapacity:2];
            for(NSDictionary *dictionary in dateNumList){
                AppointmentModel *model = [AppointmentModel mj_objectWithKeyValues:dictionary];
                [datebydayList addObject:model];
            }
            [self.dateList addObject:dict[@"datastr"]];
            [self.dataSource addObject:datebydayList];
        }
        self.isMorning = YES;
        self.tableDataSource = self.dataSource[0];
        self.tableView.tableHeaderView = [self updataView];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
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
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
- (void)httpRequestForAppointment{
    NSString *tokenStr = [CcUserModel defaultClient].userToken;
    YYHomeUserModel *userModel = self.userList[self.selectUser];
    AppointmentModel *appointmentModel = self.tableDataSource[self.selectDoctor];
    [[HttpClient defaultClient]requestWithPath:[NSString stringWithFormat:@"%@",mAppointmentCount] method:1 parameters:@{@"token":tokenStr,@"homeuserId":userModel.info_id,@"datenumberId":appointmentModel.departmentId,@"isAm":[NSString stringWithFormat:@"%@",self.isMorning?@"1":@"0"]} prepareExecute:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"挂号%@",responseObject);
        [self.alertView dismiss:nil];
        
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
