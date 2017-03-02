//
//  YYContactViewController.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/3/1.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYContactViewController.h"
#import "UIColor+Extension.h"
#import <Masonry.h>

@interface YYContactViewController ()

@end

@implementation YYContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"联系我们";
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"联系电话";
    titleLabel.textColor = [UIColor colorWithHexString:@"555555"];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset((kScreenH -170)/2.0);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kScreenW,20));
    }];
    
    UILabel *phoneLabel = [[UILabel alloc]init];
    phoneLabel.text = @"0312-3850331";
    phoneLabel.textColor = [UIColor colorWithHexString:@"555555"];
    phoneLabel.font = [UIFont systemFontOfSize:20];
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:phoneLabel];
    
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).with.offset(20);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kScreenW,20));
    }];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"拨打" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithHexString:@"25f368"];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    btn.layer.cornerRadius = 2.5;
    btn.clipsToBounds = YES;
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneLabel.mas_bottom).with.offset(60);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(150,50.5));
    }];
    
    

    // Do any additional setup after loading the view.
}
- (void)btnClick{
    
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
