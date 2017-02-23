//
//  headerTitleBtn.m
//  电商
//
//  Created by 万宇 on 2017/2/20.
//  Copyright © 2017年 万宇. All rights reserved.
//

#import "headerTitleBtn.h"

@implementation headerTitleBtn

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
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    //    [self.titleLabel setFont:[UIFont systemFontOfSize:12]];
    
    
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.imageView.frame = CGRectMake(width-0.5*height, 0.25*height, 0.25*height, 0.5*height);
    self.titleLabel.frame = CGRectMake(20, 0, width-height, height);
}


@end
