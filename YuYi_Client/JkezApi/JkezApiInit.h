//
//  JkezApiInit.h
//  Fmd
//
//  Created by Kimi Ling on 16/9/18.
//  Copyright © 2016年 Sunrise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JkezApiData.h"

/**
 *  绑定结果
 *  status 0:失败  1:成功
 */
typedef void (^BindFinishHttpBlock)(int status);

typedef void (^RegisterEcgBlock)(NSString *userid,NSString *err);

@interface JkezApiInit : NSObject

@property (nonatomic,copy) BindFinishHttpBlock bindblock;

@property (nonatomic,copy) NSString *comark;


-(id)initJkezApiInitWithAppKey:(NSString *)appkey comark:(NSString *)comark;

+(id)jkezApiInitWithAppKey:(NSString *)appkey comark:(NSString *)comark;

/**
  * 设置用户参数
  * height 50~~255cm 之间
  * 1:男  0：女
  * 5~~120岁之间
  */
+(void)setApiUserDataWithHeight:(int)height sex:(int)sex age:(int)age;

+(void)bindAccountWithData:(JkezApiData *)data block:(BindFinishHttpBlock)block;

+(void)registerEcgWithAccount:(NSString *)account pwd:(NSString *)pwd block:(RegisterEcgBlock)block ;

+(NSString *)EcgOrgId;

+(NSString *)EcgSign;

@end
