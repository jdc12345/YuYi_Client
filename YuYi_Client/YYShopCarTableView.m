//
//  YYShopCarTableView.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/3/1.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYShopCarTableView.h"
#import "YYShopCartSingleton.h"
#import "YYShopCarTableViewCell.h"
#import <Masonry.h>
#import "UIColor+colorValues.h"
#import "YYLogInVC.h"

static NSString *shopCarGoodCellId = @"shopCarGoodCell_id";
@interface YYShopCarTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITextField *pickerTextField;

@property (nonatomic, strong) NSMutableArray<NSArray *> *goodsArray;

@property (nonatomic, assign) CGFloat marketPrice;

@property (nonatomic, assign) CGFloat bookingPrice;

@property (nonatomic, strong) NSMutableArray<NSNumber *> *totalPriceArray;

@end

@implementation YYShopCarTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.goodsArray = [YYShopCartSingleton sharedInstance].shopCartGoods;
        self.totalPriceArray = [NSMutableArray array];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor clearColor];
    self.estimatedRowHeight = 150;
    self.rowHeight = UITableViewAutomaticDimension;
    [self registerNib:[UINib nibWithNibName:@"YYShopCarTableViewCell" bundle:nil] forCellReuseIdentifier:shopCarGoodCellId];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goodsArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYShopCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shopCarGoodCellId];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 100)];
    view.backgroundColor = [UIColor whiteColor];
    UIButton *balanceBtn = [[UIButton alloc]init];
    balanceBtn.backgroundColor = [UIColor colorWithHexString:@"66cc00"];
    [balanceBtn setTitle:@"去结算" forState:UIControlStateNormal];
    [balanceBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    [view addSubview:balanceBtn];
    [balanceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
        make.width.offset(100);
        make.height.offset(30);
    }];
    [balanceBtn addTarget:self action:@selector(goBalance:) forControlEvents:UIControlEventTouchUpInside];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}
#pragma goBalance
-(void)goBalance:(UIButton*)sender{
    //换登录
    YYLogInVC *liVC = [[YYLogInVC alloc]init];
    [self.vc.navigationController pushViewController:liVC animated:true];
}
@end
