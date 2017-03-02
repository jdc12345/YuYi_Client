//
//  YYShopCartSingleton.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/3/1.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYShopCartSingleton.h"

@implementation YYShopCartSingleton
+ (YYShopCartSingleton *)sharedInstance
{
    static YYShopCartSingleton *User = nil;
    static dispatch_once_t onceUser;
    dispatch_once(&onceUser, ^{
        User = [[YYShopCartSingleton alloc] init];
        User.shopCartGoods = [NSMutableArray array];
    });
    return User;
}
@end
