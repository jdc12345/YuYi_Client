//
//  TptApiData.h
//  Fmd
//
//  Created by Kimi Ling on 2016/10/25.
//  Copyright © 2016年 Sunrise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTPar.h"

//通讯方式
typedef enum {
    TMT_BODY=1,//人体温度
    TMT_SURFACE //物体温度
}TPT_MODE;

@interface TptApiData : NSObject

@property (nonatomic,assign) float  temperature;//温度

@property (nonatomic,assign) TPT_MODE tptmode;//温度类型  TMT_BODY：人体温度  TMT_SURFACE.室内温度

@property (nonatomic,copy) NSString *err;//错误信息

@property (nonatomic,assign) COMM_MODE mode;//通讯方式 蓝牙

@property (nonatomic,assign) REAL_REC rec;//语音

@property (nonatomic,assign) EQU_TPT equtype;//测试方式 臂式

@property (nonatomic,assign) EQU_FAC fac;//工厂

@property (nonatomic,copy) NSString *prodectmode;//产品型号 fac@0

@end
