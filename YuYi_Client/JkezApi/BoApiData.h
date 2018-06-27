//
//  BoApiData.h
//  Fmd
//
//  Created by Kimi Ling on 2017/6/8.
//  Copyright © 2017年 Sunrise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTPar.h"

@interface BoApiData : NSObject

@property (nonatomic,assign) int bo;//血氧饱和度 0 代表无效值。
@property (nonatomic,assign) int pr;//脉率 范围 0~511bpm。0 代表无效值。
@property (nonatomic,assign) float pi;//血流灌注指数)数据。范围 0%~25.5%;0 代表无效值。
@property (nonatomic,assign) int bomode;//0：成人模式  1:新生儿模式 10动物模式
@property (nonatomic,copy) NSString *spacetime;//间接时间
@property (nonatomic,copy) NSString *message;//信息

//@property (nonatomic,copy) NSString *value;//所有数据集合

@property (nonatomic,assign) COMM_MODE mode;//通讯方式 蓝牙

@property (nonatomic,assign) REAL_REC rec;//语音

@property (nonatomic,assign) EQU_BO equtype;//测试方式 

@property (nonatomic,assign) EQU_FAC fac;//工厂

@property (nonatomic,copy) NSString *prodectmode;//产品型号 fac@0

@end
