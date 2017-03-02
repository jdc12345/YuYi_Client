//
//  YYareaBtn.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/2/27.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYareaBtn.h"

@implementation YYareaBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}
- (void)setUI{
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.masksToBounds = true;
    self.imageView.backgroundColor = [UIColor whiteColor];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    UIViewContentModeScaleToFill,
//    UIViewContentModeScaleAspectFit,      // contents scaled to fit with fixed aspect. remainder is transparent
//    UIViewContentModeScaleAspectFill,
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
//    self.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    //    [self.titleLabel setFont:[UIFont systemFontOfSize:12]];
    
    
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.imageView.frame = CGRectMake(width-0.5*height-10, 0.25*height, 0.5*height, 0.5*height);
    self.titleLabel.frame = CGRectMake(0, 0, width-0.5*height-10, height);
}
@end
