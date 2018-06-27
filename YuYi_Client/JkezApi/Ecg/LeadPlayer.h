//
//  HeartBeatDrawing.h
//  ECG
//
//  Created by Will Yang (yangyu.will@gmail.com) on 5/7/11.
//  Copyright 2013 WMS Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECGPlayerView.h"



@class ViewForDrew;


@protocol playerTouchDelegate <NSObject>


- (void)drawFinished;

@end

@interface LeadPlayer : UIView <UIGestureRecognizerDelegate>
{
    CGPoint drawingPoints[1000];
    CGPoint endPoint, endPoint2, endPoint3, viewCenter;
    int currentPoint;
    CGContextRef context;
    
    ECGPlayerView *__unsafe_unretained liveMonitor;
    ViewForDrew *  viewForDrew;
    
    
    NSMutableArray *pointsArray;
    int index;
    NSString *label;
    
    int count;
    UIView *lightSpot;
    int pos_x_offset;
}
@property (nonatomic,assign)id<playerTouchDelegate> touchDelegate;
@property (nonatomic, strong) NSMutableArray *pointsArray;
@property (nonatomic, strong) UIView *lightSpot;
@property (nonatomic, strong) NSString *label;
@property (nonatomic, unsafe_unretained) ECGPlayerView *liveMonitor;
@property (nonatomic,strong) ViewForDrew *viewForDrew;
@property (nonatomic) int index;
@property (nonatomic) int currentPoint;
@property (nonatomic) int pos_x_offset;
@property (nonatomic) int gridColor;
@property (nonatomic) int savedDrawingState;
@property (nonatomic) CGPoint viewCenter;
@property (nonatomic,assign)int arrayRemain;
@property (nonatomic,assign)BOOL arrayRemainDrawing;
@property (nonatomic,assign)BOOL isDrawing;
@property (nonatomic,assign)BOOL isFourChannel;

@property (nonatomic,assign)BOOL isAnalysis;
- (void)fireDrawing;
- (void)drawGrid:(CGContextRef)ctx;
- (void)drawCurve:(CGContextRef)ctx;

- (void)clearDrawing;
- (void)redraw;
- (CGFloat)getPosX:(int)tick;
- (BOOL)pointAvailable:(NSInteger)pointIndex;
- (void)resetBuffer;
- (void)addGestureRecgonizer;
- (void)fireDrawingSign:(int)pointCount;

- (void)cleadDataAndLine;


@end
