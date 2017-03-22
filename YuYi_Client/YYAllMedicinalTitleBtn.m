//
//  YYAllMedicinalTitleBtn.m
//  电商
//
//  Created by 万宇 on 2017/2/21.
//  Copyright © 2017年 万宇. All rights reserved.
//

#import "YYAllMedicinalTitleBtn.h"
#import <Masonry.h>
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
    if (self.tag==1000) {
        self.imageView.frame = CGRectMake(width-0.5*height-6, 0.25*height, 0.5*height, 0.45*height);
        self.titleLabel.frame = CGRectMake(0, 0, width-0.5*height-6, height);
    }else{
        self.imageView.frame = CGRectMake(width-0.25*height-10, 0.35*height, 0.25*height, 0.25*height);
        self.titleLabel.frame = CGRectMake(15, 0, width-0.25*height-10, height);
    }
//    [self.titleLabel removeConstraints:self.titleLabel.constraints];
//    for (NSLayoutConstraint *constraint in self.titleLabel.superview.constraints) {
//        if ([constraint.firstItem isEqual:self.titleLabel]) {
//            [self.titleLabel.superview removeConstraint:constraint];
//        }
//    }
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset(0);
//        make.centerY.equalTo(self);
//    }];
//    [self.titleLabel sizeToFit];
//    [self.imageView removeConstraints:self.imageView.constraints];
//    for (NSLayoutConstraint *constraint in self.imageView.superview.constraints) {
//        if ([constraint.firstItem isEqual:self.imageView]) {
//            [self.imageView.superview removeConstraint:constraint];
//        }
//    }
//
//    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.titleLabel.mas_right).offset(6);
//        make.centerY.equalTo(self);
//    }];
//    [self.imageView sizeToFit];
}

@end
