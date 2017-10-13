//
//  YYAVViewController.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/3/2.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYAVViewController.h"
#import "UIColor+Extension.h"
#import <Masonry.h>

@interface YYAVViewController ()<RCCallSessionDelegate ,RCCallReceiveDelegate>

@end

@implementation YYAVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"医生";
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    
    
//    RCCallSession *callSession = [[RCCallClient sharedRCCallClient]startCall:ConversationType_PRIVATE targetId:self.toUserID to:@[@""] mediaType:RCCallMediaVideo sessionDelegate:self extra:nil];
    
    
    [[RCCallClient sharedRCCallClient] setDelegate:self];
    
    [[RCCallClient sharedRCCallClient] isAudioCallEnabled:ConversationType_PRIVATE];
    self.remoteNameLabel.text = @"医生";
    [self.hangupButton setTitle:@"挂断" forState:UIControlStateNormal];
    [self.acceptButton setTitle:@"接听" forState:UIControlStateNormal];

    
//    [self createSubView];
    // Do any additional setup after loading the view.
}
- (void)createSubView{
    UIImageView *iconV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"07ecfad393d14033924f2fcc18ff6af9_th.jpg"]];
    
    
    
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.text = @"20:05";
    timeLabel.textColor = [UIColor colorWithHexString:@"f2f2f2"];
    timeLabel.font = [UIFont boldSystemFontOfSize:15];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"001f3a978ff3154e897f16.jpg"]];
//    imageV.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:iconV];
    [self.view addSubview:timeLabel];
    [self.view addSubview:imageV];
    
    WS(ws)
    [iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view).with.offset(64*kiphone6);
        make.centerX.equalTo(ws.view);
        make.size.mas_equalTo(CGSizeMake(kScreenW,kScreenH -64));
    }];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view).with.offset(64 +80*kiphone6);
        make.centerX.equalTo(ws.view);
        make.size.mas_equalTo(CGSizeMake(kScreenW ,15));
    }];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view).with.offset(64);
        make.right.equalTo(ws.view);
        make.size.mas_equalTo(CGSizeMake(100 *kiphone6 ,150 *kiphone6));
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"voice-phone-icon-1"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setImage:[UIImage imageNamed:@"voice-photo-icon-1"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"挂断";
    titleLabel.textColor = [UIColor colorWithHexString:@"f2f2f2"];
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *titleLabel2 = [[UILabel alloc]init];
    titleLabel2.text = @"照片传输";
    titleLabel2.textColor = [UIColor colorWithHexString:@"f2f2f2"];
    titleLabel2.font = [UIFont boldSystemFontOfSize:15];
    titleLabel2.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:btn];
    [self.view addSubview:btn2];
    [self.view addSubview:titleLabel];
    [self.view addSubview:titleLabel2];
    
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.view).with.offset(-115 *kiphone6);
        make.left.equalTo(ws.view).with.offset(57.5 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(60 *kiphone6,60 *kiphone6));
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn.mas_bottom).with.offset(12.5 *kiphone6);
        make.centerX.equalTo(btn.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(70 *kiphone6,15 *kiphone6));
    }];
    
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.view).with.offset(-115 *kiphone6);
        make.right.equalTo(ws.view).with.offset(- 57.5 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(60 *kiphone6,60 *kiphone6));
    }];
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn2.mas_bottom).with.offset(12.5 *kiphone6);
        make.centerX.equalTo(btn2.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(70 *kiphone6,15 *kiphone6));
    }];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)callDidConnect{
    NSLog(@"通话接通");
}
- (void)callDidDisconnect{
    NSLog(@"通话结束");
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)didReceiveCall:(RCCallSession *)callSession{
    
}

- (void)didReceiveCallRemoteNotification:(NSString *)callId inviterUserId:(NSString *)inviterUserId mediaType:(RCCallMediaType)mediaType userIdList:(NSArray *)userIdList userDict:(NSDictionary *)userDict{
    
}

- (void)didCancelCallRemoteNotification:(NSString *)callId inviterUserId:(NSString *)inviterUserId mediaType:(RCCallMediaType)mediaType userIdList:(NSArray *)userIdList{
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
