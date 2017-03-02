//
//  YYLogInVC.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/3/2.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYLogInVC.h"
#import "UIColor+colorValues.h"
#import <Masonry.h>
#import "UILabel+Addition.h"
@interface YYLogInVC ()

@end

@implementation YYLogInVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    [self setupUI];
}
-(void)setupUI{
    //添加log图片
    UIImageView *logImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
    [self.view addSubview:logImageView];
    [logImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.offset(130);
        make.width.height.offset(125);
    }];
    
    //添加line1
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(logImageView.mas_bottom).offset(60);
        make.width.offset(225);
        make.height.offset(0.5);
    }];
    //添加电话imageView图标
    UIImageView *telImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_phone_icon"]];
    [self.view addSubview:telImageView];
    [telImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line1.mas_left);
        make.bottom.equalTo(line1.mas_top).offset(-7.5);
        make.width.height.offset(17);
    }];
    //添加电话textField
    UITextField *telNumberField = [[UITextField alloc]init];
    [self.view addSubview:telNumberField];
    [telNumberField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(telImageView.mas_left).offset(15);
        make.bottom.equalTo(line1.mas_top).offset(-7.5);
        make.width.offset(75);
    }];

    //添加line2
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(line1.mas_bottom).offset(40);
        make.width.offset(225);
        make.height.offset(0.5);
    }];
    //添加密码imageView图标
    UIImageView *passWordImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_lock_icon"]];
    [self.view addSubview:passWordImageView];
    [passWordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line2.mas_left);
        make.bottom.equalTo(line2.mas_top).offset(-7.5);
        make.width.height.offset(17);
    }];
    //添加密码textField
    UITextField *passWordField = [[UITextField alloc]init];
    [self.view addSubview:passWordField];
    [passWordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passWordImageView.mas_left).offset(15);
        make.bottom.equalTo(line2.mas_top).offset(-7.5);
        make.width.offset(75);
    }];
    //添加获取验证码Btn
    UIButton *getCodeBtn = [[UIButton alloc]init];
    [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:9];
    [getCodeBtn setBackgroundColor:[UIColor colorWithHexString:@"66cc00"]];
    [self.view addSubview:getCodeBtn];
    [getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passWordField.mas_right).offset(5);
        make.bottom.equalTo(line2.mas_top).offset(-7.5);
        make.width.offset(50);
        make.height.offset(20);
    }];
    //点击事件
    [getCodeBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    [getCodeBtn addTarget:self action:@selector(buttonClick1:) forControlEvents:UIControlEventTouchUpInside];
    //添加倒计时Label
    UILabel *countdownLabel = [UILabel labelWithText:@"59 S" andTextColor:[UIColor colorWithHexString:@"f211221"] andFontSize:12];
    [self.view addSubview:countdownLabel];
    [countdownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(getCodeBtn.mas_right).offset(5);
        make.centerY.equalTo(getCodeBtn);
        make.width.offset(25);
        make.height.offset(20);
    }];
    [countdownLabel sizeToFit];
    //添加登录Btn
}

-(void)buttonClick:(UIButton *)button{
    [button setBackgroundColor:[UIColor colorWithHexString:@"#cccccc"]];
    
}
-(void)buttonClick1:(UIButton *)button{
//    [button setBackgroundColor:[UIColor colorWithHexString:@"66cc00"]];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
