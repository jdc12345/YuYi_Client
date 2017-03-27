//
//  SPView.h
//  StockPlotting
//
//  Created by EZ on 17-2-20.
//  Copyright (c) 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYTrendView : UIView

@property (nonatomic, strong) NSMutableArray *values;   // 数据组
@property (nonatomic, strong) NSString* trendModel;     // 走势图   血压   体温
@property (nonatomic, strong) NSDictionary *measureData; // 测量时间

- (void)setMeasureData:(NSDictionary *)measureData;    // 测量数据 字典

- (void)updateBloodTrendDataList:(NSArray *)highList  lowList:(NSArray *)lowList;
- (void)updateTempatureTrendDataList:(NSArray *)tempature  lowList:(NSArray *)lowList;

@end
