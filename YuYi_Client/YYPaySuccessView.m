//
//  YYPaySuccessView.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/2/24.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYPaySuccessView.h"
#import <Masonry.h>
#import "UIColor+colorValues.h"
@implementation YYPaySuccessView

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
        
    }
    return self;
}
-(void)setupUI{
    //添加conform按钮
    UIButton * closeBtn=  [[UIButton alloc]init];
    [closeBtn setImage:[UIImage imageNamed:@"close_shop"] forState:UIControlStateNormal];
    [self addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.right.offset(-15);
    }];
    [closeBtn addTarget:self action:@selector(closeView:) forControlEvents:UIControlEventTouchUpInside];
    //✅号和❎号的imageView
    UIImageView *imageView = [[UIImageView alloc]init];
    [self addSubview:imageView];
    self.imageView = imageView;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(50);
        make.centerX.equalTo(self);
        make.width.height.offset(45);
    }];
    //支付成功/失败label
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor colorWithHexString:@"333333"];
    label.font = [UIFont systemFontOfSize:18];
    [self addSubview:label];
    self.label = label;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(imageView.mas_bottom).offset(25);
    }];
    //添加conform按钮
    UIButton * conformPayBtn=  [[UIButton alloc]init];
    conformPayBtn.backgroundColor = [UIColor colorWithHexString:@"#25f368"];
    [conformPayBtn setTitle:@"确定" forState:UIControlStateNormal];
    [conformPayBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    conformPayBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [self addSubview:conformPayBtn];
    self.conformPayBtn = conformPayBtn;
    [conformPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(60);
    }];
}

-(void)closeView:(UIButton*)sender{
    [self removeFromSuperview];
}


@end
