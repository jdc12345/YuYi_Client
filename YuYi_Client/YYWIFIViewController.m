//
//  YYWIFIViewController.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/28.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYWIFIViewController.h"
#import "UIColor+Extension.h"
#import <Masonry.h>
#import "ZYAlertSView.h"

@interface YYWIFIViewController ()
@property (nonatomic, weak) ZYAlertSView *alertView;
@end

@implementation YYWIFIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"连接WIFI";
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    [self createSubView];
    // Do any additional setup after loading the view.
}
- (void)createSubView{
    UIView *cardView = [[UIView alloc]init];
    cardView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"connect-wifi-icon-"]];
    UILabel *lineL1 = [[UILabel alloc]init];
    lineL1.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    
    UIImageView *iconV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"connect-wifi-icon-mormal"]];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"WIFI";
    titleLabel.textColor = [UIColor colorWithHexString:@"666666"];
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    
    UITextField *accountText = [[UITextField alloc]init];
    accountText.textColor = [UIColor colorWithHexString:@"999999"];
    accountText.font = [UIFont systemFontOfSize:12];
    
    
    
    UILabel *lineL2 = [[UILabel alloc]init];
    lineL2.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    UIImageView *iconV2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"connect-lock-icon-"]];
    
    UILabel *titleLabel2 = [[UILabel alloc]init];
    titleLabel2.text = @"密码";
    titleLabel2.textColor = [UIColor colorWithHexString:@"666666"];
    titleLabel2.font = [UIFont boldSystemFontOfSize:14];
    
    UITextField *accountText2 = [[UITextField alloc]init];
    accountText2.textColor = [UIColor colorWithHexString:@"999999"];
    accountText2.font = [UIFont systemFontOfSize:12];
    
    
    
    
    UILabel *promtyLabel = [[UILabel alloc]init];
    promtyLabel.text = @"连接wifi后点击配置按钮，连接设备";
    promtyLabel.textColor = [UIColor colorWithHexString:@"999999"];
    promtyLabel.font = [UIFont systemFontOfSize:11];
    
    
    [cardView addSubview:imageV];
    [cardView addSubview:lineL1];
    [cardView addSubview:lineL2];
    [cardView addSubview:iconV];
    [cardView addSubview:iconV2];
    [cardView addSubview:titleLabel];
    [cardView addSubview:titleLabel2];
    [cardView addSubview:accountText];
    [cardView addSubview:accountText2];
    [cardView addSubview:promtyLabel];
    
    WS(ws);
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardView).with.offset(20 *kiphone6);
        make.centerX.equalTo(cardView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(135 *kiphone6, 110 *kiphone6));
    }];
    /////////////////////////////////////////////////////////////////////
    [lineL1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardView).with.offset(185 *kiphone6);
        make.left.equalTo(cardView).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(kScreenW -20, 1));
    }];
    [iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineL1.mas_bottom).with.offset(-2.5 *kiphone6);
        make.left.equalTo(cardView).with.offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(18*kiphone6, 15*kiphone6));
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineL1.mas_bottom).with.offset(-2.5 *kiphone6);
        make.left.equalTo(iconV.mas_right).with.offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(32*kiphone6, 14*kiphone6));
    }];
    [accountText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLabel.mas_centerY);
        make.left.equalTo(titleLabel.mas_right).with.offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(200*kiphone6, 12*kiphone6));
    }];
    
    ////////////////////////////////////////////////////////////////////
    [lineL2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineL1.mas_bottom).with.offset(40 *kiphone6);
        make.left.equalTo(cardView).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(kScreenW -20, 1));
    }];
    [iconV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineL2.mas_bottom).with.offset(-2.5 *kiphone6);
        make.left.equalTo(cardView).with.offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(18*kiphone6, 18*kiphone6));
    }];
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineL2.mas_bottom).with.offset(-2.5 *kiphone6);
        make.left.equalTo(iconV2.mas_right).with.offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(32*kiphone6, 14*kiphone6));
    }];
    [accountText2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLabel2.mas_centerY);
        make.left.equalTo(titleLabel2.mas_right).with.offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(200*kiphone6, 12*kiphone6));
    }];
    
    /////////////////////////////////
    [promtyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineL2.mas_bottom).with.offset(10 *kiphone6);
        make.left.equalTo(titleLabel.mas_left);
        make.size.mas_equalTo(CGSizeMake(300*kiphone6, 11*kiphone6));
    }];
    
    
    UIButton *sureBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    sureBtn.layer.cornerRadius = 1.5 *kiphone6;
    sureBtn.layer.borderWidth = 0.5 *kiphone6;
    sureBtn.layer.borderColor = [UIColor colorWithHexString:@"25f368"].CGColor;
    sureBtn.clipsToBounds = YES;
    [sureBtn setTitle:@"配置" forState:UIControlStateNormal];
    sureBtn.backgroundColor = [UIColor whiteColor];
    [sureBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    //    [sureBtn setTintColor:[UIColor colorWithHexString:@"25f368"]];
    [sureBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    [sureBtn addTarget:self action:@selector(buttonClick1:) forControlEvents:UIControlEventTouchUpInside];
    
    [cardView addSubview:sureBtn];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(promtyLabel.mas_bottom).with.offset(20 *kiphone6);
        make.centerX.equalTo(cardView);
        make.size.mas_equalTo(CGSizeMake(100 *kiphone6 ,30 *kiphone6));
    }];
    
    
    [self.view addSubview:cardView];
    [cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view).with.offset(74 *kiphone6);
        make.centerX.equalTo(ws.view).with.offset(0);
        make.bottom.equalTo(sureBtn.mas_bottom).with.offset(20 *kiphone6);
        make.width.mas_equalTo(kScreenW);
    }];
    
    
    
}


- (void)buttonClick:(UIButton *)button{
    [button setBackgroundColor:[UIColor colorWithHexString:@"25f368"]];
}
- (void)buttonClick1:(UIButton *)button{
    [button setBackgroundColor:[UIColor whiteColor]];
    
    
    // 30   35
    CGFloat alertW = 200 *kiphone6;
    CGFloat alertH = 135 *kiphone6;
    
    // titleView
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, alertW, 135 *kiphone6)];
    
    
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"connect-wifi-icon-"]];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"连接wifi失败，请重试一次";
    titleLabel.textColor = [UIColor colorWithHexString:@"e51b1b"];
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:imageV];
    [titleView addSubview:titleLabel];
    
    
    WS(ws);
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView).with.offset(25 *kiphone6);
        make.centerX.equalTo(titleView);
        make.size.mas_equalTo(CGSizeMake(35 *kiphone6,30 *kiphone6));
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageV.mas_bottom).with.offset(22 *kiphone6);
        make.centerX.equalTo(titleView);
        make.size.mas_equalTo(CGSizeMake(alertW ,13 *kiphone6));
    }];

    
    ZYAlertSView *alertV = [[ZYAlertSView alloc]initWithContentSize:CGSizeMake(alertW, alertH) TitleView:titleView selectView:nil sureView:nil];
    [alertV show];
    self.alertView = alertV;
    
    
}
- (void)alertClick:(UIButton *)sender{
    if ([sender.currentTitle isEqualToString:@"取消"]) {
        [self.alertView dismiss:nil];
    }else{
        
    }
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
