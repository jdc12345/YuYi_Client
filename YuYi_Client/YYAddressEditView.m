//
//  YYAddressEditView.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/2/27.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYAddressEditView.h"
#import <Masonry.h>
#import "UIColor+colorValues.h"

@implementation YYAddressEditView

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
        
    }
    return self;
}
-(void)setupUI{
    //添加左侧类别Label
    UILabel *preLabel = [[UILabel alloc]init];
    preLabel.font = [UIFont systemFontOfSize:14];
    preLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [self addSubview:preLabel];
    self.preLabel = preLabel;
    [preLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.equalTo(self);
        make.width.offset(60);
    }];
    //添加右侧详情textField
    UITextField *textField = [[UITextField alloc]init];
    //设置输入框内容的字体样式和大小
    textField.font = [UIFont fontWithName:@"Arial" size:14.0f];
    //内容对齐方式
    textField.textAlignment = NSTextAlignmentLeft;
    
    //内容的垂直对齐方式  UITextField继承自UIControl,此类中有一个属性contentVerticalAlignment
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //设置字体颜色
    textField.textColor = [UIColor colorWithHexString:@"333333"];
    [self addSubview:textField];
    self.textField = textField;
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(preLabel.mas_right).offset(13);
        make.top.right.bottom.equalTo(self);
    }];
}

@end
