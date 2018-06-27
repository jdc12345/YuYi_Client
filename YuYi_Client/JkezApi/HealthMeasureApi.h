//
//  HealthMeasureUI.h
//  Fmd
//
//  Created by Kimi Ling on 16/9/12.
//  Copyright © 2016年 Sunrise. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HealthMeasureType.h"
#import "HealthMeasureState.h"

@protocol HealthMeasureApiDelegate <NSObject>


//设备名称
-(void)healthMeasureBlueToothState:(BTSTATE)state;

//获取蓝牙设备名称
-(void)healthMeasureBlueToothName:(NSString *)name Mac:(NSString *)mac;

//连接成功
-(void)healthMeasureConnectSuccess;

//蓝牙断开
-(void)healthMeasureDisconnect;
//@optional

//返回有效值
-(void)healthMeasureWithType:(BTMEASURETYTE)type state:(HEALTHMEAUSRESTATE)state data:(id)data;


@end



@interface HealthMeasureApi : NSObject

@property (nonatomic,assign) id<HealthMeasureApiDelegate> healthMeasureDelegate;

-(id)initHealthMeasureWithType:(BTMEASURETYTE)type;

+(id)healthMeasureWithType:(BTMEASURETYTE)type;

//开始连接
- (BOOL)connectWithDelegate:(id<HealthMeasureApiDelegate>)delegate;

-(void)btConnectWithDelegate:(id<HealthMeasureApiDelegate>)delegate;

//断开连接
- (void)disconnect;

@end
