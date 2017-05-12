//
//  YYSpeechViewController.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/3/2.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYSpeechViewController.h"
#import "UIColor+Extension.h"
#import <Masonry.h>
@interface YYSpeechViewController ()<RCCallSessionDelegate ,RCCallReceiveDelegate>
@property (nonatomic, strong) UIWindow *actionWindow;
@property (nonatomic, strong) UIView *maskView;

//@property (nonatomic,strong) RCCallSession *callSession;

@end

@implementation YYSpeechViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"医生";
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    RCCallSession *callSession = [[RCCallClient sharedRCCallClient]startCall:ConversationType_PRIVATE targetId:self.toUserID to:@[@""] mediaType:RCCallMediaAudio sessionDelegate:self extra:nil];
    
    
    [[RCCallClient sharedRCCallClient] setDelegate:self];
    
    [[RCCallClient sharedRCCallClient] isAudioCallEnabled:ConversationType_PRIVATE];
    
//    
//    _actionWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    _actionWindow.windowLevel       = UIWindowLevelStatusBar;
//    _actionWindow.backgroundColor   = [UIColor clearColor];
//    _actionWindow.hidden = NO;
//    _actionWindow.multipleTouchEnabled = YES;
//    
//    
//    UIView *maskView = [[UIView alloc] init];
//    
//    UIColor *color = [UIColor blackColor];
//    color = [color colorWithAlphaComponent:0.6];
//    maskView.backgroundColor = color;
//    [maskView setUserInteractionEnabled:NO];
//    [maskView setFrame:(CGRect){0, 0, kScreenW, kScreenH}];
//    maskView.userInteractionEnabled = YES;
//
////    [self.view addSubview:maskView];
//    _maskView = maskView;
//
//    
//    [_actionWindow addSubview:maskView];
//    
//    
//    
//    UILabel *titleLabel = [[UILabel alloc]init];
//    titleLabel.text = @"等待对方语音接受...";
//    titleLabel.textColor = [UIColor colorWithHexString:@"f9f9f9"];
//    titleLabel.font = [UIFont boldSystemFontOfSize:14];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    
//    
//    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"voice-phone-icon-1"]];
//    imageV.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
//    [imageV addGestureRecognizer:tap];
//    
//    
//    
//    UILabel *putLabel = [[UILabel alloc]init];
//    putLabel.text = @"挂断";
//    putLabel.textColor = [UIColor colorWithHexString:@"f9f9f9"];
//    putLabel.font = [UIFont boldSystemFontOfSize:15];
//    putLabel.textAlignment = NSTextAlignmentCenter;
//    
//    
//    [maskView addSubview:titleLabel];
//    [maskView addSubview:imageV];
//    [maskView addSubview:putLabel];
//    
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(maskView).with.offset(64 +260*kiphone6);
//        make.centerX.equalTo(maskView);
//        make.size.mas_equalTo(CGSizeMake(kScreenW ,14));
//    }];
//    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(titleLabel.mas_bottom).with.offset(155 *kiphone6);
//        make.centerX.equalTo(maskView);
//        make.size.mas_equalTo(CGSizeMake(60 *kiphone6 ,60 *kiphone6));
//    }];
//    [putLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(imageV.mas_bottom).with.offset(15 *kiphone6);
//        make.centerX.equalTo(maskView);
//        make.size.mas_equalTo(CGSizeMake(kScreenW ,15));
//    }];
    
    

    
    // Do any additional setup after loading the view.
}


- (void)createSubView{
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.text = @"20:05";
    timeLabel.textColor = [UIColor colorWithHexString:@"333333"];
    timeLabel.font = [UIFont systemFontOfSize:15];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"voice-profil-icon-1"]];
    
    [self.view addSubview:timeLabel];
    [self.view addSubview:imageV];
    
    WS(ws)
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view).with.offset(64 +80*kiphone6);
        make.centerX.equalTo(ws.view);
        make.size.mas_equalTo(CGSizeMake(kScreenW ,15));
    }];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeLabel.mas_bottom).with.offset(25 *kiphone6);
        make.centerX.equalTo(ws.view);
        make.size.mas_equalTo(CGSizeMake(100 *kiphone6 ,100 *kiphone6));
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"voice-phone-icon-1"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setImage:[UIImage imageNamed:@"voice-photo-icon-1"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"挂断";
    titleLabel.textColor = [UIColor colorWithHexString:@"666666"];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *titleLabel2 = [[UILabel alloc]init];
    titleLabel2.text = @"照片传输";
    titleLabel2.textColor = [UIColor colorWithHexString:@"666666"];
    titleLabel2.font = [UIFont systemFontOfSize:15];
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
- (void)btnClick:(UIButton *)sender{
    
}
- (void)dismiss:(UITapGestureRecognizer *)tap {
    NSLog(@"1234");
    _actionWindow.hidden = YES;
    [self createSubView];
    [UIView animateWithDuration:0.1f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [_maskView setAlpha:0];
                         [_maskView setUserInteractionEnabled:NO];
                     }
                     completion:^(BOOL finished) {
                        
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
