//
//  RCUserModel.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/3/30.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "RCUserModel.h"

@implementation RCUserModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
/**
 * PS:用自己的属性，代替字典里的
 */
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"info_id" : @"id"};
}
+ (RCUserModel *)defaultClient{
    static RCUserModel *userModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userModel = [[self alloc]init];
    });
    return userModel;
}
@end
