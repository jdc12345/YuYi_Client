//
//  YYWordsViewController.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/3/2.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYWordsViewController.h"
#import "UIColor+Extension.h"
#import <Masonry.h>
#import "HcCustomKeyboard.h"
#import <RongIMKit/RongIMKit.h>
@interface YYWordsViewController ()<HcCustomKeyboardDelegate>
@property (nonatomic, strong) HcCustomKeyboard *cc;
@end

@implementation YYWordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"医生";
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
//    self.cc = [HcCustomKeyboard customKeyboard];
//    [self.cc textViewShowView:self customKeyboardDelegate:self];
//    
//    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setImage:[UIImage imageNamed:@"屏幕快照 2017-03-02 上午10.55.18"] forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@"屏幕快照 2017-03-02 上午10.55.18"] forState:UIControlStateSelected];
//    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.view addSubview:btn];
//    
//    WS(ws);
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(ws.view).with.offset(0 *kiphone6);
//        make.left.equalTo(ws.view).with.offset(0 *kiphone6);
//        make.size.mas_equalTo(CGSizeMake(kScreenW, 44 *kiphone6));
//    }];
//    
//    
//    NSLog(@"弹出评论框");

}
- (void)btnClick:(UIButton *)sender{
    [self.cc.mTextView becomeFirstResponder];
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
