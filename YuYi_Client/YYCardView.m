//
//  YYCardView.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/22.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYCardView.h"
#import <Masonry.h>
#import "UIColor+Extension.h"

@implementation YYCardView
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
    
    self.dataLabel = [[UILabel alloc]init];
    self.dataLabel.textColor = [UIColor colorWithHexString:@"e80000"];
    self.dataLabel.font = [UIFont fontWithName:kPingFang_S size:15];
    self.dataLabel.textAlignment = NSTextAlignmentCenter;
    
 
    
    
    
    [self addSubview:lineLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.dataLabel];
    
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
    
    [self.dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws).with.offset(57.5 *kiphone6);
        make.centerX.equalTo(ws.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width ,15));
    }];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
