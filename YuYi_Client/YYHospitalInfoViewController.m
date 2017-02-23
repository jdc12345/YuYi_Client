//
//  YYHospitalInfoViewController.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/23.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYHospitalInfoViewController.h"
#import "UIColor+Extension.h"
#import <Masonry.h>

@interface YYHospitalInfoViewController ()

@end

@implementation YYHospitalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"医院详情";
    self.view.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    
    [self createSomeViews];
    // Do any additional setup after loading the view.
}

-(void)createSomeViews{
    
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
