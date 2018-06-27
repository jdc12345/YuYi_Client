//
//  BTPar.h
//  Fmd
//
//  Created by Kimi Ling on 15/5/27.
//  Copyright (c) 2015年 Sunrise. All rights reserved.
//

#ifndef Fmd_BTPar_h
#define Fmd_BTPar_h

//通讯方式
typedef enum {
    COMM_SERIAL_PORT=1,//串口
    COMM_BT //蓝牙
}COMM_MODE;

//语音实别
typedef enum {
    YREAL = 1, //有语音
    NREAL,//无语音
}REAL_REC;//语音实别


//设备类型（血压计）
typedef enum {
    EQU_ARM =1,//臂式
    EQU_WRIST,//腕式
}EQU_BP_TYPE;

//设备类型（血糖仪）
typedef enum {
    EQU_BS_DEF =1,//臂式
}EQU_BS_TYPE;

//设备类型（体重秤）
typedef enum {
    EQU_WDEF =1,
}EQU_WTYPE;

////设备类型（体温）
typedef enum {
    EQU_FOREHEAD =1,
}EQU_TPT;

////设备类型（尿酸）
typedef enum {
    EQU_UA_DEF =1,
}EQU_UA;

////设备类型（胆固醇）
typedef enum {
    EQU_CHOL_DEF =1,
}EQU_CHOL;

////设备类型（心电）
typedef enum {
    EQU_ECG_SINGLE = 1,//单导
}EQU_ECG;

typedef enum {
    EQU_BO_DEF = 1,//
}EQU_BO;

//厂家:
typedef enum {
    BT_PG = 1,//攀高  (血压)
    BT_MBB,//脉博波  (血压)
    BT_RDE,//瑞迪恩 (血压  血糖)
    BT_BJ,//百捷 (血糖 胆固醇  尿酸)
    BT_SANNUO,//三诺 (血糖)
    BT_FDK,//福达康 (血糖)
    BT_LF, //乐福 (人体秤  脂肪秤)
    BT_YUYUE, //鱼跃 (血压  血糖)
    BT_YICHENG, //怡成 (血糖)
    BT_KENUO,//柯诺(血糖)
    BT_BEITAI,//倍泰(血压)
    BT_URN,//优瑞恩 (血压)
    BT_KLB, //凯利博（额温）
    BT_HPY, //好朋友（心电）
    BT_FRK,  //福瑞康(体脂)
    BT_KRK, //科瑞康（血氧仪）
    BT_SENSSUN,//香山（体脂称）
    BT_CARDIOCHEK  //迈普瑞（血脂仪 四项）
}EQU_FAC;


#endif
