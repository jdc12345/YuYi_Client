//
//  CholApiData.h
//  Fmd
//
//  Created by Kimi Ling on 2016/10/26.
//  Copyright © 2016年 Sunrise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTPar.h"

@interface CholApiData : NSObject

@property (nonatomic,assign) float value;//总胆固醇值
@property (nonatomic,assign) float cholHdlValue;//高密度脂蛋白胆固醇
@property (nonatomic,assign) float cholLdlValue;//低密度脂蛋白胆固醇
@property (nonatomic,assign) float trigValue;//甘油三酯
@property (nonatomic,assign) float tcHdlValue;//TC/HDL

@property (nonatomic,copy) NSString *message;//中间过程

@property (nonatomic,copy) NSString *err;//总胆固醇错误

@property (nonatomic,copy) NSString *hdlerr;//高密度脂蛋白胆固醇错误
@property (nonatomic,copy) NSString *ldlerr;//低密度脂蛋白胆固醇错误
@property (nonatomic,copy) NSString *trigerr;//甘油三酯错误
@property (nonatomic,copy) NSString *tcHdlerr;//TC/HDL错误

@property (nonatomic,assign) COMM_MODE mode;//通讯方式 蓝牙

@property (nonatomic,assign) REAL_REC rec;//语音

@property (nonatomic,assign) EQU_CHOL equtype;//测试方式 臂式

@property (nonatomic,assign) EQU_FAC fac;//工厂

@property (nonatomic,copy) NSString *prodectmode;//产品型号 fac@0

@end
