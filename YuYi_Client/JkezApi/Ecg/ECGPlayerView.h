//
//  ECGPlayerView.h
//  ZRQECGMonitor
//
//  Created by zhangjiang on 15/11/12.
//  Copyright © 2015年 深圳市中瑞奇电子科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol ECGPlayerViewDelegate <NSObject>


@required
- (void)analysisEcg;
- (void)createFileCode;
//3个元素  1是文件存储路径（包含文件名）  2是性别(1是男   0是女)  3是年龄
- (NSArray *)informationForECGData;


//- (void)dataForDiskState:(int )volt;


- (void)dataForHeartCurve:(int)heart;


- (void)getDevSn:(char *)dev;

- (void)putWriteData:(short *) wriData;



@end



@interface ECGPlayerView : UIView


@property (nonatomic,assign)id<ECGPlayerViewDelegate>delegate;
@property (nonatomic,assign)BOOL isCollection;
@property (nonatomic,strong) UIImage *collectionImage;
@property (nonatomic,assign) BOOL isFourChannel;   //是否为4通道       YES = 4   NO = 1
@property (nonatomic,assign)BOOL isHasCollection;
@property (nonatomic,assign) NSInteger leadsInView; // el-191 画线的view

- (id)initWithFrame:(CGRect)frame;

//开始采集10s数据
- (void)startCollectCurveData;

- (UIImage *)getImageWithResult:(id)result andUserInfo:(NSMutableDictionary *)dic;

- (void)resetBuffer;
- (void)resetView;
- (void)putBleData:(char*)data withLength:(int) l;

@property (nonatomic,assign) BOOL  isConnected;
@end
