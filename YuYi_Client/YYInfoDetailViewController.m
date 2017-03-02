//
//  YYInfoDetailViewController.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/27.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYInfoDetailViewController.h"
#import "UIColor+Extension.h"
#import <Masonry.h>

@interface YYInfoDetailViewController ()

@property (nonatomic, strong) UIScrollView *infomationS;

@end

@implementation YYInfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资讯详情";
    self.view.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    
    self.infomationS = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH -64)];
    self.infomationS.backgroundColor = [UIColor whiteColor];
    [self createSubView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.infomationS];
    ;
    // Do any additional setup after loading the view.
}
- (void)createSubView{
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cell1"]];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"涿州市中医院";
    titleLabel.font = [UIFont fontWithName:kPingFang_M size:18];
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    
    UILabel *detailLabel = [[UILabel alloc]init];
    detailLabel.text = @"三级甲等";
    detailLabel.font = [UIFont systemFontOfSize:15];
    detailLabel.textColor = [UIColor colorWithHexString:@"333333"];
    
    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    
    UILabel *subLabel = [[UILabel alloc]init];
    subLabel.text = @"医院简介";
    subLabel.font = [UIFont systemFontOfSize:15];
    subLabel.textColor = [UIColor colorWithHexString:@"25f368"];
    
    UILabel *infoLabel = [[UILabel alloc]init];
    infoLabel.text = @"涿州市中医院";
    infoLabel.font = [UIFont systemFontOfSize:14];
    infoLabel.textColor = [UIColor colorWithHexString:@"333333"];
    
    
//    imageV.backgroundColor = [UIColor cyanColor];
//    detailLabel.backgroundColor = [UIColor redColor];
//    subLabel.backgroundColor =[ UIColor yellowColor];
//    infoLabel.backgroundColor = [UIColor greenColor];
//    
    [self.infomationS addSubview:imageV];
    [self.infomationS addSubview:titleLabel];
    [self.infomationS addSubview:detailLabel];
    [self.infomationS addSubview:lineLabel];
    [self.infomationS addSubview:subLabel];
    [self.infomationS addSubview:infoLabel];
    
    WS(ws);
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infomationS).with.offset(0);
        make.left.equalTo(self.infomationS).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW ,210*kiphone6));
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageV.mas_bottom).with.offset(25 *kiphone6);
        make.left.equalTo(self.infomationS).with.offset(20 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(kScreenW -20 *kiphone6,18*kiphone6));
    }];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).with.offset(10.5 *kiphone6);
        make.left.equalTo(titleLabel.mas_left).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW -20 *kiphone6,15*kiphone6));
    }];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(detailLabel.mas_bottom).with.offset(25 *kiphone6);
        make.left.equalTo(titleLabel.mas_left).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW -20 *kiphone6,1*kiphone6));
    }];
    [subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineLabel.mas_bottom).with.offset(20 *kiphone6);
        make.left.equalTo(titleLabel.mas_left).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW -20 *kiphone6,15*kiphone6));
    }];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(subLabel.mas_bottom).with.offset(19 *kiphone6);
        make.left.equalTo(titleLabel.mas_left).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW -40 *kiphone6,14 *kiphone6));
    }];
    
    
    self.infomationS.contentSize = CGSizeMake(kScreenW, CGRectGetMaxY(infoLabel.frame));
    
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
