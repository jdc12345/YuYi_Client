//
//  YYMedinicalDetailModel.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/3/16.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYMedinicalDetailModel.h"

@implementation YYMedinicalDetailModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
-(void)setValue:(id)value forKey:(NSString *)key{
//    if ([key isEqualToString:@"author"]) {
//        if (!_author) {
//            _author = [[Author alloc] init];
//            [_author setValuesForKeysWithDictionary:value];
//        }
//        else{
//            [_author setValuesForKeysWithDictionary:value];
//        }
//    }
//    else{
        [super setValue:value forKey:key];
//    }
    
    if ([key isEqualToString:@"id"]) {
        key = @"id";
        [super setValue:value forKey:key];
    }
}

@end
