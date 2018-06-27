//
//  FatApiData.h
//  Fmd
//
//  Created by Kimi Ling on 16/9/18.
//  Copyright © 2016年 Sunrise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTPar.h"

@interface FatApiData : NSObject

@property (nonatomic,assign) float weight;//体重值

@property (nonatomic,assign) float bmi;//体质指数

@property (nonatomic,assign) float water;//水分

@property (nonatomic,assign) float muscle;//肌肉

@property (nonatomic,assign) float bone;//骨骼

@property (nonatomic,assign) float fat;//脂肪

@property (nonatomic,assign) int bmr;//卡路里

@property (nonatomic,assign) int vis;//内脏脂肪

@property (nonatomic,assign) int bodyage;//身体年龄

@property (nonatomic,assign) float protein;//蛋白质

@property (nonatomic,assign) int healthScore;//健康得分

@property (nonatomic,copy) NSString *err;//错误信息

@property (nonatomic,assign) COMM_MODE mode;//通讯方式 蓝牙

@property (nonatomic,assign) REAL_REC rec;//语音

@property (nonatomic,assign) EQU_WTYPE equtype;//测试方式 臂式

@property (nonatomic,assign) EQU_FAC fac;//工厂

@property (nonatomic,copy) NSString *prodectmode;//产品型号 fac@0


@end
