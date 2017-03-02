//
//  YYShopCartEmptyView.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/2/28.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYShopCartEmptyView.h"
#import "UIColor+colorValues.h"
#import <Masonry.h>
#import "UILabel+Addition.h"
#import "ViewController.h"

@implementation YYShopCartEmptyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    UIView *witheView = [[UIView alloc]init];
    witheView.backgroundColor = [UIColor whiteColor];
    [self addSubview:witheView];
    [witheView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.right.offset(0);
        make.height.offset(300);
    }];
    UIButton *goShoppingButton = [[UIButton alloc] init];
    [goShoppingButton setTitle:@"去抢购" forState:UIControlStateNormal];
    goShoppingButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [goShoppingButton setTitleColor:[UIColor colorWithHexString:@"25f067"] forState:UIControlStateNormal];
    [witheView addSubview:goShoppingButton];
    [goShoppingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(witheView);
        make.width.offset(100);
        make.height.offset(30);
        make.bottom.offset(-30);
    }];
    [goShoppingButton.layer setBorderColor:[UIColor colorWithHexString:@"25f067"].CGColor];
    [goShoppingButton.layer setBorderWidth:2.0];
    //    [goShoppingButton.layer setCornerRadius:8];
    [goShoppingButton.layer setMasksToBounds:true];
    
    [goShoppingButton addTarget:self action:@selector(jumpToHome) forControlEvents:UIControlEventTouchUpInside];
    //
    UILabel *noticeLabel = [UILabel labelWithText:@"购物车空空如也" andTextColor:[UIColor colorWithHexString:@"999999"] andFontSize:14];
    [witheView addSubview:noticeLabel];
    [noticeLabel sizeToFit];
    [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(witheView);
        make.bottom.equalTo(goShoppingButton.mas_top).offset(-20);
    }];

    UIImageView *emptyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shopping_icon"]];
    [witheView addSubview:emptyImageView];
    [emptyImageView sizeToFit];
    [emptyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(witheView);
        make.width.offset(90);
        make.height.offset(85);
        make.bottom.equalTo(noticeLabel.mas_top).offset(-20);
    }];
    
    
    }

- (void)jumpToHome {
    [self.vc.navigationController pushViewController:[[ViewController alloc]init] animated:true];
}


@end
