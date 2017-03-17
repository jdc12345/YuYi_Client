//
//  SectorCalendar.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/21.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "SectorCalendar.h"
#import <Masonry.h>
#import "UIColor+Extension.h"
@implementation SectorCalendar
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setViewInHead];
//        self.userInteractionEnabled = YES;
    }
    return self;
}
- (void)setViewInHead{
    
    self.dateLabel = [[UILabel alloc]init];
    self.dateLabel.textColor = [UIColor colorWithHexString:@"6a6a6a"];
    self.dateLabel.font = [UIFont systemFontOfSize:11];
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    [self.dateLabel.layer setBorderColor:[UIColor colorWithHexString:@"f2f2f2"].CGColor];
    [self.dateLabel.layer setBorderWidth:1];
    [self.dateLabel.layer setMasksToBounds:YES];
    
    
    
    self.morningBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.morningBtn setTitle:@"上午" forState:UIControlStateNormal];
    [self.morningBtn setTitleColor:[UIColor colorWithHexString:@"6a6a6a"] forState:UIControlStateNormal];
//    [self.morningBtn setTitleColor:[UIColor colorWithHexString:@"fefdfd"] forState:UIControlStateSelected];
    [self.morningBtn setTintColor:[UIColor colorWithHexString:@"25f368"]];
    [self.morningBtn.layer setBorderColor:[UIColor colorWithHexString:@"f2f2f2"].CGColor];
    [self.morningBtn.layer setBorderWidth:1];
    [self.morningBtn.layer setMasksToBounds:YES];
    self.morningBtn.tag = 101;
    [self.morningBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    self.afternoonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.afternoonBtn setTitle:@"下午" forState:UIControlStateNormal];
    [self.afternoonBtn setTitleColor:[UIColor colorWithHexString:@"6a6a6a"] forState:UIControlStateNormal];
//    [self.afternoonBtn setTitleColor:[UIColor colorWithHexString:@"fefdfd"] forState:UIControlStateSelected];
    [self.afternoonBtn setTintColor:[UIColor colorWithHexString:@"25f368"]];
    [self.afternoonBtn.layer setBorderColor:[UIColor colorWithHexString:@"f2f2f2"].CGColor];
    [self.afternoonBtn.layer setBorderWidth:1];
    [self.afternoonBtn.layer setMasksToBounds:YES];
    self.afternoonBtn.tag = 102;
    [self.afternoonBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.morningBtn.selected = NO;
    self.afternoonBtn.selected = NO;
    
    [self addSubview:self.dateLabel];
    [self addSubview:self.morningBtn];
    [self addSubview:self.afternoonBtn];
    
    
    WS(ws);
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws).with.offset(0);
        make.left.equalTo(ws).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(100 *kiphone6 ,20 *kiphone6));
    }];
    [self.morningBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dateLabel.mas_bottom).with.offset(0);
        make.left.equalTo(ws).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(50 *kiphone6 ,40 *kiphone6));
    }];
    [self.afternoonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dateLabel.mas_bottom).with.offset(0);
        make.left.equalTo(self.morningBtn.mas_right).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(50 *kiphone6 ,40 *kiphone6));
    }];
    
    
}


- (void)setAppointment_date:(NSString *)appointment_date{
    _appointment_date = appointment_date;
    self.dateLabel.text = appointment_date;
}

- (void)clickAction:(UIButton *)sender{
//    NSLog(@"%ld, ,,,,,%@",sender.tag ,sender.selected?@"Yes":@"no");
    if (sender.selected == YES) {
    }else{
        self.dateLabel.textColor = [UIColor colorWithHexString:@"23f368"];
        if (sender.tag == 101) {
            UIButton *button = (UIButton *)[self viewWithTag:102];
            button.selected = NO;
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:[UIColor colorWithHexString:@"6a6a6a"] forState:UIControlStateNormal];
            
            sender.selected = YES;
            sender.backgroundColor = [UIColor colorWithHexString:@"23f368"];
            [sender setTitleColor:[UIColor colorWithHexString:@"fefdfd"] forState:UIControlStateNormal];
            
            
            self.timeClick(YES);
        }else{
            UIButton *button = (UIButton *)[self viewWithTag:101];
            button.selected = NO;
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:[UIColor colorWithHexString:@"6a6a6a"] forState:UIControlStateNormal];
            
            sender.selected = YES;
            sender.backgroundColor = [UIColor colorWithHexString:@"23f368"];
            [sender setTitleColor:[UIColor colorWithHexString:@"fefdfd"] forState:UIControlStateNormal];
            
            
            self.timeClick(NO);
            
        }
    }
}
- (void)resumeView{
    self.dateLabel.textColor = [UIColor colorWithHexString:@"6a6a6a"];
    [self.morningBtn setTitleColor:[UIColor colorWithHexString:@"6a6a6a"] forState:UIControlStateNormal];
    [self.afternoonBtn setTitleColor:[UIColor colorWithHexString:@"6a6a6a"] forState:UIControlStateNormal];
    self.morningBtn.backgroundColor = [UIColor whiteColor];
    self.afternoonBtn.backgroundColor = [UIColor whiteColor];
    self.morningBtn.selected = NO;
    self.afternoonBtn.selected = NO;
}

- (void)selectInit{
    [self clickAction:self.morningBtn];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
