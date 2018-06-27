//
//  ECGHelper.h
//  EcgMonitor
//
//  Created by  manor on 16/8/30.
//  Copyright © 2016年 深圳市中瑞奇电子科技有限公司. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ECGData.h"

@protocol ECGHelperDelegate <NSObject>
@optional
- (void)dataForStaState:(int )value;
- (void)writeBleChar:(char)value;
- (void)dataForFirmDev:(char *)dev;
@end
@interface ECGHelper : NSObject
{
    
    
    int index;
    int m_nDataTail;
    int m_nLostBytes;
    bool m_bPriECGPacket;
    int _boxMode;
    ECGData *ecgData;
}
@property (nonatomic,assign) int boxMode;
- (void)putData:(NSData *)data;
- (int)getdata:(short **)data;
- (void)initFilter;
- (void)fileterData:(short *)data whitlead:(int) lead whitCount:(int) count;
- (void)onLineCalcRRI:(short *)data whitCount:(int) count;
- (int)getHeartCure;
@property (nonatomic,assign) id<ECGHelperDelegate> delegate;
@end
