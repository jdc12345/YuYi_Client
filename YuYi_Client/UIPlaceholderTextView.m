//
//  UIPlaceholderTextView.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/2/27.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "UIPlaceholderTextView.h"
#import "UIColor+colorValues.h"
@implementation UIPlaceholderTextView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self awakeFromNib];
           }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self addObserver];
}

#pragma mark 注册通知
- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
}

#pragma mark 移除通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 开始编辑
- (void)textDidBeginEditing:(NSNotification *)notification {
    if ([super.text isEqualToString:_placeholder]) {
        super.text = @"";
        [super setTextColor:[UIColor colorWithHexString:@"333333"]];
    }
}

#pragma mark 结束编辑
- (void)textDidEndEditing:(NSNotification *)notification {
    if (super.text.length == 0) {
        super.text = _placeholder;
        //如果文本框内是原本的提示文字，则显示灰色字体
        [super setTextColor:[UIColor colorWithHexString:@"b4b4b4"]];
    }
}

#pragma mark 重写setPlaceholder方法
- (void)setPlaceholder:(NSString *)aPlaceholder {
    _placeholder = aPlaceholder;
    [self textDidEndEditing:nil];
}

#pragma mark 重写getText方法
- (NSString *)text {
    NSString *text = [super text];
    if ([text isEqualToString:_placeholder]) {
        return @"";
    }
    return text;
}


@end
