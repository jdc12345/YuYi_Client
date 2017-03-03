//
//  YYOrderDetailVC.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/3/3.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYOrderDetailVC.h"
#import "UIColor+colorValues.h"
#import <Masonry.h>
@interface YYOrderDetailVC ()

@end

@implementation YYOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    UIView *view = [[NSBundle mainBundle] loadNibNamed:@"YYOrderDetailView" owner:nil options:nil][0];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(64);
        make.left.right.bottom.offset(0);
    }];
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
