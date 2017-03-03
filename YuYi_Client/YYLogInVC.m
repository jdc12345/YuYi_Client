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
#import "YYTabBarController.h"
@interface YYLogInVC ()
@property(nonatomic,weak)UILabel *countdownLabel;
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
        make.left.equalTo(telImageView.mas_right).offset(15);
        make.bottom.equalTo(line1.mas_top).offset(-7.5);
        make.width.offset(110);
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
        make.left.equalTo(passWordImageView.mas_right).offset(15);
        make.bottom.equalTo(line2.mas_top).offset(-7.5);
        make.width.offset(110);
    }];
    //添加获取验证码Btn
    UIButton *getCodeBtn = [[UIButton alloc]init];
    [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCodeBtn setTitleColor:[UIColor colorWithHexString:@"f9f9f9"] forState:UIControlStateNormal];
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
    
    //添加倒计时Label
    UILabel *countdownLabel = [UILabel labelWithText:@"59 S" andTextColor:[UIColor redColor] andFontSize:12];
    [countdownLabel sizeToFit];
    [self.view addSubview:countdownLabel];
    self.countdownLabel = countdownLabel;
    [countdownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(getCodeBtn.mas_right).offset(5);
        make.centerY.equalTo(getCodeBtn);
    }];
    //添加登录Btn
    UIButton *logInBtn = [[UIButton alloc]init];
    [logInBtn setTitle:@"登录" forState:UIControlStateNormal];
    [logInBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    logInBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [logInBtn setBackgroundColor:[UIColor colorWithHexString:@"66cc00"]];
    [self.view addSubview:logInBtn];
    [logInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(line2);
        make.top.equalTo(line2.mas_bottom).offset(30);
        make.width.offset(80);
        make.height.offset(35);
    }];
    //点击事件
    [logInBtn addTarget:self action:@selector(logIn:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)buttonClick:(UIButton *)button{
    //倒计时时间
    __block NSInteger timeOut = 59;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [button setBackgroundColor:[UIColor colorWithHexString:@"66cc00"]];

                [button setTitle:@"获取验证码" forState:UIControlStateNormal];
                button.userInteractionEnabled = YES;
                self.countdownLabel.text = @"59 S";
            });
        } else {
            int allTime = 60;
            int seconds = timeOut % allTime;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [button setBackgroundColor:[UIColor colorWithHexString:@"#cccccc"]];
                self.countdownLabel.text = [NSString stringWithFormat:@"%@ S",timeStr];

                button.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}

-(void)logIn:(UIButton*)sender{
    YYTabBarController *firstVC = [[YYTabBarController alloc]init];
    [self.navigationController pushViewController:firstVC animated:true];
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
