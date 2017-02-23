//
//  YYCardInputView.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/23.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYCardInputView.h"
#import <Masonry.h>
#import "UIColor+Extension.h"

@implementation YYCardInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.frame = frame;
        [self setViewInHead];
        //        self.userInteractionEnabled = YES;
    }
    return self;
}
- (void)setViewInHead{
    self.layer.borderColor = [UIColor colorWithHexString:@"dcdcdc"].CGColor;
    self.layer.borderWidth = 0.5 *kiphone6;
    
    
    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = [UIColor colorWithHexString:@"e2e2e2"];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    self.titleLabel.font = [UIFont fontWithName:kPingFang_S size:14];
    
    self.dataTextField = [[UITextField alloc]init];
    self.dataTextField.placeholder = @"请输入......";
    self.dataTextField.textColor = [UIColor colorWithHexString:@"25f368"];
    self.dataTextField.font = [UIFont systemFontOfSize:13];
    
    
    [self addSubview:lineLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.dataTextField];
    
    WS(ws);
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws).with.offset(30 *kiphone6);
        make.left.equalTo(ws).with.offset(15 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width - 15*kiphone6 ,1));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws).with.offset(7.5 *kiphone6);
        make.left.equalTo(ws).with.offset(15 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width - 15*kiphone6 ,15));
    }];
    
    [self.dataTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineLabel.mas_bottom).with.offset(6 *kiphone6);
        make.left.equalTo(ws.titleLabel.mas_left);
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width ,13));
    }];
    
    
}

@end
