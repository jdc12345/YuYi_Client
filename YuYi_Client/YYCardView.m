//
//  YYCardView.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/22.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYCardView.h"

@implementation YYCardView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"474d5b"];
        self.frame = frame;
        [self setViewInHead];
    }
    return self;
}
- (void)setViewInHead{
    //高压
    UITextField *highTextField = [[UITextField alloc]init];
    highTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    highTextField.textAlignment = NSTextAlignmentCenter;
    highTextField.textColor = [UIColor colorWithHexString:@"1ebeec"];
    highTextField.font = [UIFont systemFontOfSize:40];
//    highTextField.placeholder = @"请输入";
//    [highTextField setValue:[UIColor colorWithHexString:@"999999"] forKeyPath:@"_placeholderLabel.textColor"];
//    [highTextField setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    //实现了垂直居中
    NSMutableParagraphStyle *style = [highTextField.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    
    style.minimumLineHeight = highTextField.font.lineHeight - (highTextField.font.lineHeight - [UIFont systemFontOfSize:15.0].lineHeight) / 2.0;
    
    highTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入..."attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"999999"],NSFontAttributeName : [UIFont systemFontOfSize:15.0],NSParagraphStyleAttributeName : style}];
    [self addSubview:highTextField];
    [highTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(38*kiphone6H);
        make.right.equalTo(self.mas_centerX).offset(-30*kiphone6);
        
    }];
    self.highPressureField = highTextField;
    
    UILabel *highLabel = [[UILabel alloc]init];
    highLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
    highLabel.font = [UIFont systemFontOfSize:15];
    highLabel.text = @"高压/mmHg";
    [self addSubview:highLabel];
    [highLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(highTextField);
        make.top.equalTo(highTextField.mas_bottom).offset(15*kiphone6H);
    }];
    //低压
    UITextField *lowTextField = [[UITextField alloc]init];
    lowTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    lowTextField.textAlignment = NSTextAlignmentCenter;
    lowTextField.textColor = [UIColor colorWithHexString:@"1ebeec"];
    lowTextField.font = [UIFont systemFontOfSize:40];
    //实现了垂直居中
    lowTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入..."attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"999999"],NSFontAttributeName : [UIFont systemFontOfSize:15.0],NSParagraphStyleAttributeName : style}];
    [self addSubview:lowTextField];
    [lowTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(38*kiphone6H);
        make.left.equalTo(self.mas_centerX).offset(30*kiphone6);
        
    }];
    self.lowPressureField = lowTextField;
    
    UILabel *lowLabel = [[UILabel alloc]init];
    lowLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
    lowLabel.font = [UIFont systemFontOfSize:15];
    lowLabel.text = @"低压/mmHg";
    [self addSubview:lowLabel];
    [lowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(lowTextField);
        make.top.equalTo(lowTextField.mas_bottom).offset(15*kiphone6H);
    }];
    
    //结果说明label
    UILabel *resultLabel = [[UILabel alloc]init];
    self.resultLabel = resultLabel;
    resultLabel.text = @"等待测量";
    self.resultLabel.textColor = [UIColor colorWithHexString:@"1ebeec"];
    self.resultLabel.font = [UIFont fontWithName:kPingFang_S size:15];
    self.resultLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:resultLabel];
    [resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(lowLabel.mas_bottom).offset(15*kiphone6H);
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
