//
//  YYHomeHeadView.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/17.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYHomeHeadView.h"
#import <SDCycleScrollView.h>

@implementation YYHomeHeadView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreenW, 300 *kiphone6);
        self.backgroundColor = kColor_DefaultGray;
        [self setViewInHead];
    }
    return self;
}

- (void)setViewInHead{
    SDCycleScrollView *cycleScrollView2 = [[SDCycleScrollView alloc]init];
    cycleScrollView2.
//                                           cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenW, 169/375.0*kScreenW) delegate:self placeholderImage:[UIImage imageNamed:@"place2"]];
//    
//    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter; // SDCycleScrollViewPageContolAlimentRight;
//    // cycleScrollView2.titlesGroup = titles;
//    cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
//    cycleScrollView2.pageDotColor = [UIColor colorWithHexString:@"#ffffff" alpha:0.3];
//    // [demoContainerView addSubview:cycleScrollView2];
//    cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    cycleScrollView2.delegate = self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
