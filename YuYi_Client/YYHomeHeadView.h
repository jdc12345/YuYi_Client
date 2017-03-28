//
//  YYHomeHeadView.h
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/17.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYHomeHeadView : UIView

@property (nonatomic, copy) void(^bannerClick)(BOOL isShopping);
@property (nonatomic, copy) void(^itemClick)(NSString  *index);
@property (nonatomic, copy) void(^addFamily)(NSString  *index);
- (instancetype)init;
- (void)refreshThisView;

@end
