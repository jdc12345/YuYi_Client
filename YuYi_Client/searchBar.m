//
//  searchBar.m
//  电商
//
//  Created by 万宇 on 2017/2/17.
//  Copyright © 2017年 万宇. All rights reserved.
//

#import "searchBar.h"

@implementation searchBar

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
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
//    [self.titleLabel setFont:[UIFont systemFontOfSize:12]];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.imageView.frame = CGRectMake(0.35*width, 0.25*height, 0.5*height, 0.5*height);
    self.titleLabel.frame = CGRectMake(self.imageView.frame.origin.x+self.imageView.frame.size.width+5, 0, width, height);
}

@end
