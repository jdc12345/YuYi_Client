//
//  YYHandleMeasureViewController.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/23.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYHandleMeasureViewController.h"
#import "YYCardInputView.h"
#import "UIColor+Extension.h"
#import "UIBarButtonItem+Helper.h"
#import <Masonry.h>
#import "YYMemberTableViewCell.h"

@interface YYHandleMeasureViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIView *memberView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation YYHandleMeasureViewController

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40*kiphone6, kScreenW, self.memberView.frame.size.height -90 *kiphone6) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];//colorWithHexString:@"eeeeee"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //        _tableView.indicatorStyle =
        //        _tableView.rowHeight = kScreenW *77/320.0 +10;
        //        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        //        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        [_tableView registerClass:[YYMemberTableViewCell class] forCellReuseIdentifier:@"YYMemberTableViewCell"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [self.memberView addSubview:_tableView];
        // [self.memberView sendSubviewToBack:_tableView];
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
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    self.title = @"手动输入";
    [self createOtherView];
    
    
    // Do any additional setup after loading the view.
}
- (void)createOtherView{
    
    CGFloat cardH;
    YYCardInputView *card = [[YYCardInputView alloc]initWithFrame:CGRectMake(10 *kiphone6, (64 +10) *kiphone6, kScreenW - 20 *kiphone6, 100 *kiphone6)];
    if ([self.navTitle isEqualToString:@"当前体温"]) {
        card.titleLabel.text = @"体温";
        card.dataLabel.text = @"38℃";
    }else{
        card.titleLabel.text = @"收缩压（高压）";
        card.dataLabel.text = @"110";
    }
    
    if ([self.navTitle isEqualToString:@"当前血压"]) {
        YYCardInputView *cardView = [[YYCardInputView alloc]initWithFrame:CGRectMake(10 *kiphone6, CGRectGetMaxY(card.frame) +10 *kiphone6, kScreenW - 20 *kiphone6, 100 *kiphone6)];
        cardView.titleLabel.text = @"舒张压（低压）";
        cardView.dataLabel.text = @"90";
        
        [self.view addSubview:cardView];
        
        cardH = CGRectGetMaxY(cardView.frame);
        
    }else{
        
        UILabel *promptLabel= [[UILabel alloc]initWithFrame:CGRectMake(25 *kiphone6 ,CGRectGetMaxY(card.frame) +9 *kiphone6, kScreenW, 12)];
        promptLabel.text = @"*内容不能为空";
        promptLabel.textColor = [UIColor colorWithHexString:@"e80000"];
        promptLabel.font = [UIFont systemFontOfSize:12];
        [self.view addSubview:promptLabel];
        
        
        cardH = CGRectGetMaxY(card.frame);
        
    }
    
    [self.view addSubview:card];
    
    
    self.memberView  = [[UIView alloc] initWithFrame:CGRectMake(0, cardH + 30 *kiphone6, kScreenW, kScreenH - cardH - 30*kiphone6)];
    self.memberView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.memberView];
    [self createMemberView];
}

- (void)createMemberView{
    UIView *header = [[UIView alloc]init];
    header.backgroundColor = [UIColor whiteColor];
    
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(20 *kiphone6, 0, kScreenW, 40 *kiphone6)];
    headerLabel.backgroundColor = [UIColor whiteColor];
    headerLabel.textColor = [UIColor colorWithHexString:@"333333"];
    headerLabel.font = [UIFont systemFontOfSize:14];
    headerLabel.text = @"数据录入";
    [self.memberView addSubview:headerLabel];
    
    UILabel *lineL = [[UILabel alloc]init];
    lineL.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    
    UIButton *sureBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    sureBtn.layer.cornerRadius = 1.5 *kiphone6;
    sureBtn.layer.borderWidth = 1 *kiphone6;
    sureBtn.layer.borderColor = [UIColor colorWithHexString:@"25f368"].CGColor;
    sureBtn.clipsToBounds = YES;
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    sureBtn.backgroundColor = [UIColor whiteColor];
    [sureBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    //    [sureBtn setTintColor:[UIColor colorWithHexString:@"25f368"]];
    [sureBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    [sureBtn addTarget:self action:@selector(buttonClick1:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.memberView addSubview:sureBtn];
    [self.memberView addSubview:lineL];
    
    
    WS(ws);
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.memberView).with.offset(-9.5 *kiphone6);
        make.centerX.equalTo(ws.memberView);
        make.size.mas_equalTo(CGSizeMake(100 *kiphone6 ,30 *kiphone6));
    }];
    [lineL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.memberView).with.offset(-49 *kiphone6);
        make.centerX.equalTo(ws.memberView);
        make.size.mas_equalTo(CGSizeMake(kScreenW *kiphone6 ,1 *kiphone6));
    }];
    [self tableView];
    
}
#pragma mark -
#pragma mark ------------TableView DataSource----------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60 *kiphone6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YYMemberTableViewCell *homeTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"YYMemberTableViewCell" forIndexPath:indexPath];
    
    if (indexPath.row == 3) {
        homeTableViewCell.iconV.image = [UIImage imageNamed:@"add-1"];
        homeTableViewCell.titleLabel.text = @"添加其他成员";
        homeTableViewCell.titleLabel.textColor = [UIColor colorWithHexString:@"c7c5c5"];
    }else{
        homeTableViewCell.titleLabel.highlightedTextColor = [UIColor whiteColor];
        homeTableViewCell.selectedBackgroundView = [[UIView alloc] initWithFrame:homeTableViewCell.frame];
        homeTableViewCell.selectedBackgroundView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    }
    return homeTableViewCell;
    
}

-(void)buttonClick:(UIButton *)button{
    [button setBackgroundColor:[UIColor colorWithHexString:@"25f368"]];
}
-(void)buttonClick1:(UIButton *)button{
    [button setBackgroundColor:[UIColor whiteColor]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
