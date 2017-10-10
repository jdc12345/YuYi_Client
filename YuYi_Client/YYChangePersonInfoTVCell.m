//
//  YYChangePersonInfoTVCell.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/9/29.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYChangePersonInfoTVCell.h"
#import "UILabel+Addition.h"

@implementation YYChangePersonInfoTVCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createDetailView];
    }
    return self;
}
- (void)createDetailView{
    //添加电话label
    UILabel *titleLabel = [UILabel labelWithText:@"标题" andTextColor:[UIColor colorWithHexString:@"333333"] andFontSize:15];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10*kiphone6);
        make.centerY.offset(0);
    }];
    self.titleLable = titleLabel;
    //添加电话textField
    UITextField *textField = [[UITextField alloc]init];
    textField.placeholder = @"请输入相应信息";
    //设置左边视图的宽度
    textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    //设置显示模式为永远显示(默认不显示 必须设置 否则没有效果)
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.font = [UIFont systemFontOfSize:14];
    textField.textColor = [UIColor colorWithHexString:@"666666"];
    textField.keyboardType = UIKeyboardTypeNumberPad;//设置键盘的样式
    [self.contentView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right).offset(5*kiphone6);
        make.centerY.equalTo(titleLabel);
//        make.right.offset(-15*kiphone6);
//        make.height.offset(30*kiphone6H);
    }];
    self.textField = textField;
//    textField.delegate = self;

    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
    [self.contentView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.height.offset(1);
        make.left.offset(10*kiphone6);
        make.right.offset(-10*kiphone6);
    }];
    
}


@end

