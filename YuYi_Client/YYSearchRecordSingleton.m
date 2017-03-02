//
//  YYSearchRecordSingleton.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/3/1.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYSearchRecordSingleton.h"

@implementation YYSearchRecordSingleton
+ (YYSearchRecordSingleton *)sharedInstance
{
    static YYSearchRecordSingleton *User = nil;
    static dispatch_once_t onceUser;
    dispatch_once(&onceUser, ^{
        User = [[YYSearchRecordSingleton alloc] init];
        User.searchRecords = [NSMutableArray array];
    });
    return User;
}
@end
