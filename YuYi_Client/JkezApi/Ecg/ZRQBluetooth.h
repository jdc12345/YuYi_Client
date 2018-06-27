//
//  ZRQBluetooth.h
//  ZRQECGMonitor
//
//  Created by zhangjiang on 15/11/24.
//  Copyright © 2015年 深圳市中瑞奇电子科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>


@protocol ZRQBluetoothDelegate <NSObject>

@required
//发现采集盒设备
- (void)bluetoothEquipment:(CBPeripheral *)peripheral andRSSI:(NSNumber *)RSSI andMAC:(NSString*) mac;

//连接失败返回错误信息
- (void)disconnectBluetooth:(CBPeripheral *)peripheral andError:(NSError *)error;

//连接成功返回信息
- (void)didconnectBluetooth:(CBPeripheral *)peripheral devType:(int) devType;

-(void)putData:(NSData *)data;

@end




@interface ZRQBluetooth : NSObject

@property (nonatomic,assign) id<ZRQBluetoothDelegate> delegate;

- (id)init;

//浏览蓝牙设备
- (void)startScan;

//停止浏览
- (void)stopScan;

//连接蓝牙设备
- (void)connectPeripheral:(CBPeripheral *)peripheral;

//断开蓝牙设备
- (void)cancelPeripheral:(CBPeripheral *)peripheral;

//校正时间  校正采集盒的时间，建议在每次连接成功后调用 校正时间大概需要2-3s
- (void)corretionTime;


- (void)writeChar:(char)value;

- (void)writeChar:(NSData*) sendData devType:(int) type;

-(void) closeAllPeripheral;
-(void) sendSetEcgDateTime;
-(void) sendGetSn;
@end
