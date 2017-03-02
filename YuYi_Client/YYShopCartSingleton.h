//
//  YYShopCartSingleton.h
//  YuYi_Client
//
//  Created by 万宇 on 2017/3/1.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYShopCartSingleton : NSObject
+ (YYShopCartSingleton *)sharedInstance;

@property(nonatomic,strong)NSMutableArray *shopCartGoods;
@end
