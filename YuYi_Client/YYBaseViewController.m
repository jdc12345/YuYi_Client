//
//  YYBaseViewController.m
//  电商
//
//  Created by 万宇 on 2017/2/21.
//  Copyright © 2017年 万宇. All rights reserved.
//

#import "YYBaseViewController.h"
#import "UIColor+colorValues.h"
@interface YYBaseViewController ()

@end

@implementation YYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar    setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"333333"],NSFontAttributeName:[UIFont systemFontOfSize:17.0f]}];
    [self configNavigationBar];

}
//配置导航栏
- (void)configNavigationBar
{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 44, 44);
//    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 10);
    [leftButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    UIButton *rightButton = [[UIButton alloc]init];
    rightButton.frame = CGRectMake(0, 0, 44, 44);
//    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -15);
    [rightButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(searching:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton]; //
    
}
//导航栏按钮点击事件
-(void)backButtonClick:(id)sender{
     [self.navigationController popViewControllerAnimated:true];
}
-(void)searching:(id)sender{
    NSLog(@"搜索跳转");
}
//
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
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
