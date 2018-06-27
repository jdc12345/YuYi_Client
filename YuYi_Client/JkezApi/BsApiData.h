//
//  BsApiData.h
//  Fmd
//
//  Created by Kimi Ling on 16/9/18.
//  Copyright © 2016年 Sunrise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTPar.h"

typedef enum
{
    BLOODTEXT,//测量文字
    BLOODCOUNDDOWN, //倒计时
    BLOODEND  //结束
}BLOODTYPE;//蓝牙设备类型

@interface BsApiData : NSObject

@property (nonatomic,assign) float value;//血糖值

@property (nonatomic,assign) BLOODTYPE type;//内容描述的类型

@property (nonatomic,copy) NSString *message;//中间过程

@property (nonatomic,copy) NSString *err;//错误

@property (nonatomic,assign) COMM_MODE mode;//通讯方式 蓝牙

@property (nonatomic,assign) REAL_REC rec;//语音

@property (nonatomic,assign) EQU_BS_TYPE equtype;//测试方式 臂式

@property (nonatomic,assign) EQU_FAC fac;//工厂

@property (nonatomic,copy) NSString *prodectmode;//产品型号 fac@0


@end
