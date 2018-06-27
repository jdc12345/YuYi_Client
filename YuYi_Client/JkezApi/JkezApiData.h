//
//  JkezApiData.h
//  Fmd
//
//  Created by Kimi Ling on 16/9/19.
//  Copyright © 2016年 Sunrise. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JkezApiData : NSObject

@property (nonatomic,copy) NSString *accout;//手机帐号
@property (nonatomic,copy) NSString *pwd;//密码
@property (nonatomic,copy) NSString *name;//姓名
@property (nonatomic,assign) int sex;
@property (nonatomic,copy) NSString *companymark;//公司标识

-(id)initJkezApiDataWithAccount:(NSString *)accout pwd:(NSString *)pwd name:(NSString *)name sex:(int)sex comark:(NSString *)companymark;

+(id)jkezApiDataWithAccount:(NSString *)accout pwd:(NSString *)pwd name:(NSString *)name sex:(int)sex comark:(NSString *)companymark;

@end
