//
//  YYAllMedicinalTitleBtn.m
//  电商
//
//  Created by 万宇 on 2017/2/21.
//  Copyright © 2017年 万宇. All rights reserved.
//

#import "YYAllMedicinalTitleBtn.h"

@implementation YYAllMedicinalTitleBtn

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
    self.imageView.frame = CGRectMake(width-0.25*height-10, 0.35*height, 0.25*height, 0.25*height);
    self.titleLabel.frame = CGRectMake(15, 0, width-0.25*height-10, height);
}

@end
