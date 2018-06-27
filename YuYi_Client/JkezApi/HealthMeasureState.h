//
//  HealthMeasureState.h
//  Fmd
//
//  Created by Kimi Ling on 16/9/12.
//  Copyright © 2016年 Sunrise. All rights reserved.
//

#ifndef HealthMeasureState_h
#define HealthMeasureState_h


typedef enum
{
    BTSTATEUNKNOWN = 0,//初始化中,请稍后
    BTSTATERESETTING, //正在重置
    BTSTATEUNSUPPORTED,//设备不支持
    BTSTATEUNAUTHORIZED,//设备未授权
    BTSTATEPOWEREDOFF,//尚未打开蓝牙,请在设置中打开
    BTSTATEPOWEREDON,//蓝牙己开启
    BTSTATEOTHER //未知状态
}BTSTATE;//蓝牙状态

typedef enum
{
    MEASURING,//测量中
    NOMAL,//正常结果
    ERROR  //错误
}HEALTHMEAUSRESTATE;//测量状态

#endif /* HealthMeasureState_h */
