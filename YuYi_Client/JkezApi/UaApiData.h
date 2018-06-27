//
//  UaApiData.h
//  Fmd
//
//  Created by Kimi Ling on 2016/10/14.
//  Copyright © 2016年 Sunrise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTPar.h"

@interface UaApiData : NSObject

@property (nonatomic,assign) float value;//血糖值

@property (nonatomic,copy) NSString *message;//中间过程

@property (nonatomic,copy) NSString *err;//错误

@property (nonatomic,assign) COMM_MODE mode;//通讯方式 蓝牙

@property (nonatomic,assign) REAL_REC rec;//语音

@property (nonatomic,assign) EQU_UA equtype;//测试方式 臂式

@property (nonatomic,assign) EQU_FAC fac;//工厂

@property (nonatomic,copy) NSString *prodectmode;//产品型号 fac@0

@end
