//
//  YYPayOptionView.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/2/24.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYPayOptionView.h"
#import <Masonry.h>
#import "UIColor+colorValues.h"
@implementation YYPayOptionView

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
         self.payBtns = [NSMutableArray array];
        [self setupUI];
       
    }
    return self;
}
-(void)setupUI{
    //支付方式label
    UILabel *label = [[UILabel alloc]init];
    label.text = @"支付方式";
    label.textColor = [UIColor colorWithHexString:@"999999"];
    label.font = [UIFont systemFontOfSize:15];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.offset(17.5);
    }];
    //添加line1
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(50);
        make.left.right.offset(0);
        make.height.offset(1);
    }];
    //添加line2
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(110);
        make.left.right.offset(0);
        make.height.offset(1);
    }];
    //添加line1
    UIView *line3 = [[UIView alloc]init];
    line3.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    [self addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(160);
        make.left.right.offset(0);
        make.height.offset(1);
    }];
    //添加btns
    NSArray *titles = @[@"支付宝支付",@"微信支付",@"货到付款"];
    for (int i = 0; i < 3; i++) {
        UIButton * payBtn=  [[UIButton alloc]init];
        payBtn.tag = 101 + i;
        [payBtn setTitle:titles[i] forState:UIControlStateNormal];
        [payBtn setTitleColor:[UIColor colorWithHexString:@"6a6a6a"] forState:UIControlStateNormal];
        payBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:payBtn];
        [self.payBtns addObject:payBtn];
        [payBtn addTarget:self action:@selector(payBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(line1.mas_bottom);
                make.left.right.offset(0);
                make.height.offset(59);
            }];
        }
        if (i==1) {
            [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(line2.mas_bottom);
                make.left.right.offset(0);
                make.height.offset(59);
            }];
        }
        if (i==2) {
            [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(line3.mas_bottom);
                make.left.right.offset(0);
                make.height.offset(59);
            }];
        }

    }
    //添加conform按钮
    UIButton * conformPayBtn=  [[UIButton alloc]init];
    conformPayBtn.backgroundColor = [UIColor colorWithHexString:@"fcd186"];
    conformPayBtn.tag = 104;
    [conformPayBtn setTitle:@"确认" forState:UIControlStateNormal];
    [conformPayBtn setTitleColor:[UIColor colorWithHexString:@"6a6a6a"] forState:UIControlStateNormal];
    conformPayBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [self addSubview:conformPayBtn];
    [self.payBtns addObject:conformPayBtn];
    [conformPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(60);
    }];
}

-(void)payBtnClick:(UIButton*)sender{
    UIColor *secColor = [UIColor colorWithHexString:@"fcd186"];
    UIColor *unseColor = [UIColor colorWithHexString:@"6a6a6a"];
    if ([sender.titleLabel.textColor isEqual:unseColor]) {
        [sender setTitleColor:secColor forState:UIControlStateNormal];
        for (UIButton* btn in self.payBtns) {
            if (![btn isEqual:sender]) {
                [btn setTitleColor:unseColor forState:UIControlStateNormal];
            }
        }

    }else{
        [sender setTitleColor:unseColor forState:UIControlStateNormal];
    }
    
}
@end
