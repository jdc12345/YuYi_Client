//
//  BpApiData.h
//  Fmd
//
//  Created by Kimi Ling on 16/9/14.
//  Copyright © 2016年 Sunrise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTPar.h"

@interface BpApiData : NSObject

@property (nonatomic,assign) int pcp;//高压
@property (nonatomic,assign) int pdp;//低压
@property (nonatomic,assign) int pm;//心率
@property (nonatomic,assign) int pressure;//压力值
@property (nonatomic,copy) NSString *err; //错误信息

@property (nonatomic,assign) COMM_MODE mode;//通讯方式 蓝牙
@property (nonatomic,assign) REAL_REC rec;//语音

@property (nonatomic,assign) EQU_BP_TYPE equtype;//测试方式 臂式

@property (nonatomic,assign) EQU_FAC fac;//工厂
@property (nonatomic,copy) NSString *prodectmode;//产品型号 fac@0

@end
