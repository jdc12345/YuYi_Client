//
//  SPView.m
//  StockPlotting
//
//  Created by  wylt_ios1 on 17-1-12.
//  Copyright (c) 2017年 cactus. All rights reserved.
//

#define NLSystemVersionGreaterOrEqualThan(version)  ([[[UIDevice currentDevice] systemVersion] floatValue] >= version)
#define IOS7_OR_LATER   NLSystemVersionGreaterOrEqualThan(7.0)
#define GraphColor      [UIColor colorWithHexString:@"6a6a6a" alpha:1]
#define str(index)      [NSString stringWithFormat : @"%.f", -[[self.values objectAtIndex:(index)] floatValue] * kYScale]
#define point(x, y)     CGPointMake((x) * kXScale +xOffset, yOffset + (y) * kYScale)
#define xPoint(x, y)    CGPointMake((x) * kXScale , yOffset + (y) * kYScale)

//#define kXScale  44.0 *kiphone6
//#define kYScale  55.0 *kiphone6
#define kXScale  47.0 *kiphone6
#define kYScale  60.0 *kiphone6
#import "YYTrendView.h"
//#import "UIColor+Extension.h"
@interface YYTrendView ()
@property (nonatomic, strong)   dispatch_source_t timer;

@property (strong , nonatomic) NSMutableArray *startPoints;
@property (nonatomic, strong) NSArray *temperatureY;//Y轴数据源
@property (nonatomic, strong) NSArray *bloodY;
@property (nonatomic, strong) NSArray *dateX;//时间轴的数据源
@end
@implementation YYTrendView
//CGFloat   kXScale = 40.0 *kiphone6;
//CGFloat   kYScale = 55.0 *kiphone6;

static inline CGAffineTransform
CGAffineTransformMakeScaleTranslate(CGFloat sx, CGFloat sy,
                                    CGFloat dx, CGFloat dy)
{
    return CGAffineTransformMake(sx, 0.f, 0.f, sy, dx, dy);
}

- (NSMutableArray *)values{
    if (_values  ==  nil) {
        _values = [[NSMutableArray alloc]initWithCapacity:2];
        //        [UIColor colorWithHexString:@"6a6a6a"];
    }
    return _values;
}
- (NSMutableArray *)valuesforBlood{
    if (_valuesforBlood  ==  nil) {
        _valuesforBlood = [[NSMutableArray alloc]initWithCapacity:2];
        //        [UIColor colorWithHexString:@"6a6a6a"];
    }
    return _valuesforBlood;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.temperatureY = @[@"40",@"60",@"80",@"100",@"120",@"140",@"160",@"180"];
        // Initialization code
// if (self.values.count == 0) {
//        for (int i = 1; i<8; i++) {
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self updateValues];
//                //                NSLog(@"-----%d",i);
//            });
//            
//        }
//        
//    }
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setContentMode:UIViewContentModeRight];
    _values = [NSMutableArray array];
    
//    __weak id   weakSelf = self;
//    double      delayInSeconds = 0.1;
    //    self.timer =
    //        dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,
    //            dispatch_get_main_queue());
    //    dispatch_source_set_timer(
    //        _timer, dispatch_walltime(NULL, 0),
    //        (unsigned)(delayInSeconds * NSEC_PER_SEC), 0);
    //    dispatch_source_set_event_handler(_timer, ^{
    //            [weakSelf updateValues];
    //        });
    //    dispatch_resume(_timer);
//    if (self.values.count == 0) {
//        for (int i = 1; i<8; i++) {
//            //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self updateValues];
//            //            NSLog(@"-----%d",i);
//            //        });
//            
//        }
//    }

}

- (void)updateValues
{
    double nextValue = sin(CFAbsoluteTimeGetCurrent())
    + ((double)rand() / (double)RAND_MAX);
    if (nextValue > 0) {
        nextValue *= -1;
    }
    //NSLog(@"%g",(double)rand()/(double)RAND_MAX);
//    NSLog(@"value =  %g",nextValue *kYScale);
    [self.values addObject:
     [NSNumber numberWithDouble:nextValue]];
    //    NSLog(@"%g",self.values.count);
    
    
    CGSize size = self.bounds.size;
    
    /*
     *   UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
     *   if(orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight){
     *
     *
     *   }
     */
    CGFloat     maxDimension = size.width; // MAX(size.height, size.width);
    NSUInteger  maxValues =
    (NSUInteger)floorl(maxDimension / kXScale);
    
    if ([self.values count] > maxValues) {
        [self.values removeObjectsInRange:
         NSMakeRange(0, [self.values count] - maxValues)];
    }
    
    [self setNeedsDisplay];
}

- (void)dealloc
{
    //    dispatch_source_cancel(_timer);
}

- (void)drawRect:(CGRect)rect
{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextSetStrokeColorWithColor(ctx,
//                                     [[UIColor colorWithHexString:@"6a6a6a"] CGColor]);
    //设置线条的转角的样式为圆角
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextSetLineWidth(ctx, 2);
    //  画 坐标轴
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGFloat yOffset = self.bounds.size.height -25;
    CGFloat xOffset = 10;
    
    
    CGAffineTransform   transform =
    CGAffineTransformMakeScaleTranslate(kXScale, kYScale,
                                        xOffset, yOffset);
    // 标刻度
    for (int i = 1; i < 9; i++) {
        //x轴
        if (i != 8) {
            [self zydrawAtPoint:xPoint(i, 0) withStr:self.dateX[i -1]];//[NSString stringWithFormat:@"%d日",i]];
        }
        //y轴
        [self zydrawAtPoint:point(0, -i *0.5) withStr:self.temperatureY[i-1]];//[NSString stringWithFormat:@"%d", 20 +(i *20 )]];
    }
    
    if (self.valuesforBlood.count>0) {//画高压标识
        NSString *str = @"高压";
        [str drawAtPoint:CGPointMake(kScreenW-40, 15) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10], NSForegroundColorAttributeName:[UIColor colorWithHexString:@"1dbeec"]}];
        CGContextAddArc(ctx, kScreenW-53, 21, 4, 0, M_PI * 2, 0);
        CGPathMoveToPoint(path, NULL, kScreenW-75, 21);
        CGPathAddLineToPoint(path, NULL, kScreenW-56, 21);
        
    }else if (self.values.count > 0){//画体温标识
        NSString *str = @"体温";
        [str drawAtPoint:CGPointMake(kScreenW-40, 15) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10], NSForegroundColorAttributeName:[UIColor colorWithHexString:@"1dbeec"]}];
        CGContextAddArc(ctx, kScreenW-53, 21, 4, 0, M_PI * 2, 0);
        CGPathMoveToPoint(path, NULL, kScreenW-75, 21);
        CGPathAddLineToPoint(path, NULL, kScreenW-56, 21);
    }
    //    --------------------高压线-------------------------
    if ([self.values count] == 0) {
        return;
    }
    // 画线 以及写数值
    [[UIColor colorWithHexString:@"1dbeec"] set];//设置颜色

    CGFloat y = [[self.values objectAtIndex:0] floatValue];
    CGPathMoveToPoint(path, &transform, 1, y);
    for (NSUInteger x = 1; x < [self.values count]; ++x) {
        y = [[self.values objectAtIndex:x] floatValue];
        CGPathAddLineToPoint(path, &transform, x+1, y);
        
    }
    
    // 画点。
    CGContextAddPath(ctx, path);
    CGPathRelease(path);
    CGContextStrokePath(ctx);
    //画点的外框
    for (NSUInteger x = 0; x < [self.values count]; ++x) {
        y = [[self.values objectAtIndex:x] floatValue];
        
        if (x==self.values.count-1) {//最后一天的点的外圈
            CGContextAddArc(ctx, (x+1)*kXScale +xOffset, y*kYScale +yOffset, 5, 0, M_PI * 2, 0);
        }else{
            CGContextAddArc(ctx, (x+1)*kXScale +xOffset, y*kYScale +yOffset, 4, 0, M_PI * 2, 0);
        }
        
        // 3.显示所绘制的东西   FillPath实心
        //        CGContextFillPath(ctx);
        CGContextStrokePath(ctx);
    }
    //画点的实心
    for (NSUInteger x = 0; x < [self.values count]; ++x) {
        y = [[self.values objectAtIndex:x] floatValue];
        
        CGContextAddArc(ctx, (x+1)*kXScale +xOffset, y*kYScale +yOffset, 3, 0, M_PI * 2, 0);
        
        if (x==self.values.count-1) {//最后一天的点的实心
           [[UIColor colorWithHexString:@"1dbeec"] set];//设置颜色  实心颜色
        }else{
           [[UIColor colorWithHexString:@"30323a"] set];//设置颜色  背景色
        }
        // 3.显示所绘制的东西   FillPath实心
        CGContextFillPath(ctx);
    }
   
    //    --------------------低压线-------------------------
    if (self.valuesforBlood.count != 0) {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetLineJoin(ctx, kCGLineJoinRound);
        CGContextSetLineWidth(ctx, 2);
        
        CGMutablePathRef path = CGPathCreateMutable();
        
        CGFloat  yOffset = self.bounds.size.height -25;
        CGFloat  xOffset = 10;
        
        CGAffineTransform   transform =
        CGAffineTransformMakeScaleTranslate(kXScale, kYScale,
                                            xOffset, yOffset);
        //画低压标识
            NSString *strL = @"低压";
            [strL drawAtPoint:CGPointMake(kScreenW-40, 37) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10], NSForegroundColorAttributeName:[UIColor colorWithHexString:@"7ed66b"]}];
            CGPathMoveToPoint(path, NULL, kScreenW-75, 43);
            CGPathAddLineToPoint(path, NULL, kScreenW-56, 43);
            CGContextAddArc(ctx, kScreenW-53, 43, 4, 0, M_PI * 2, 0);
        // 画线 以及写数值
        [[UIColor colorWithHexString:@"7ed66b"] set];//设置颜色
        CGFloat y = [[self.valuesforBlood objectAtIndex:0] floatValue];
        CGPathMoveToPoint(path, &transform, 1, y);
        //    [self drawAtPoint:point(1, y) withStr:str(0)];
        
        for (NSUInteger x = 1; x < [self.valuesforBlood count]; ++x) {
            y = [[self.valuesforBlood objectAtIndex:x] floatValue];
            CGPathAddLineToPoint(path, &transform, x+1, y);
        }
        // 画点。
        CGContextAddPath(ctx, path);
        CGPathRelease(path);
        CGContextStrokePath(ctx);
        //画点的外框
        for (NSUInteger x = 0; x < [self.valuesforBlood count]; ++x) {
            y = [[self.valuesforBlood objectAtIndex:x] floatValue];
            
            if (x==self.valuesforBlood.count-1) {//最后一天的点的外圈
                CGContextAddArc(ctx, (x+1)*kXScale +xOffset, y*kYScale +yOffset, 5, 0, M_PI * 2, 0);
            }else{
                CGContextAddArc(ctx, (x+1)*kXScale +xOffset, y*kYScale +yOffset, 4, 0, M_PI * 2, 0);
            }
            // 3.显示所绘制的东西   FillPath实心
            //        CGContextFillPath(ctx);
            CGContextStrokePath(ctx);
        }

        //画点的实心
        for (NSUInteger x = 0; x < [self.values count]; ++x) {
            y = [[self.valuesforBlood objectAtIndex:x] floatValue];
            // CGContextAddEllipseInRect(ctx, CGRectMake(x*kXScale, y*kYScale +yOffset, 5, 5));
            // CGContextSetLineWidth(ctx, 10);
            CGContextAddArc(ctx, (x+1)*kXScale +xOffset, y*kYScale +yOffset, 3, 0, M_PI * 2, 0);
            //        CGPathAddArc(path, &transform, x, y, 2, 0, M_PI *2, 0);
            
            if (x==self.valuesforBlood.count-1) {//最后一天的点的实心
                [[UIColor colorWithHexString:@"7ed66b"] set];//设置颜色  实心颜色
            }else{
                [[UIColor colorWithHexString:@"30323a"] set];//设置颜色  背景色
            }
            // 3.显示所绘制的东西   FillPath实心
            CGContextFillPath(ctx);
            //        CGContextStrokePath(ctx);
        }
    }
}

- (void)drawAtPoint:(CGPoint)point withStr:(NSString *)str
{
    
    if (IOS7_OR_LATER) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
        [str drawAtPoint:point withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9], NSStrokeColorAttributeName:GraphColor}];
#endif
    } else {
        // [str drawAtPoint:point withFont:[UIFont systemFontOfSize:9]];
    }
    
}
//画X轴刻度
- (void)zydrawAtPoint:(CGPoint)point withStr:(NSString *)str
{
    [str drawAtPoint:point withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9], NSForegroundColorAttributeName:[UIColor colorWithHexString:@"22f3f6" alpha:0.7]}];
}
// 血压走势图
- (void)updateBloodTrendDataList:(NSArray *)highList  lowList:(NSArray *)lowList  dateList:(NSArray *)dateList{
    [self editDate:dateList];//获取时间轴底部数据源
    [self.values removeAllObjects];
    [self.valuesforBlood removeAllObjects];
    for (NSNumber *number  in highList) {
        CGFloat floa = ([number floatValue] -25)/40 *-1;
        [self.values addObject:[NSNumber numberWithFloat:floa]];
        
    }
    
    for (NSNumber *number  in lowList) {
        CGFloat floa = ([number floatValue] -25)/40 *-1;
        [self.valuesforBlood addObject:[NSNumber numberWithFloat:floa]];
        
    }
    [self setNeedsDisplay];
    self.temperatureY = @[@"40",@"60",@"80",@"100",@"120",@"140",@"160",@"180"];
}
// 体温走势图
- (void)updateTempatureTrendDataList:(NSArray *)tempature{
    [self.values removeAllObjects];
    NSMutableArray *dateDate = [[NSMutableArray alloc]initWithCapacity:2];
    for (NSDictionary *dict  in tempature) {
        NSString *str = [NSString stringWithFormat:@"%@",dict[@"temperaturet"]];
        NSString *dateStr = dict[@"createTimeString"];
        CGFloat floa;
        if([str isEqualToString:@"<null>"]){
            str = @"36";
        }
        floa = ([str floatValue] -34) *-0.5;
        [self.values addObject:[NSNumber numberWithFloat:floa]];
        
        [dateDate addObject:dateStr];
    }
    [self editDate:dateDate];
    self.temperatureY = @[@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42"];
//    for(int i = 1 ; i<8 ; i++){
//        [self.values addObject:[NSNumber numberWithFloat:-(i *0.5)]];
//    }
    [self setNeedsDisplay];
}
- (void)editDate:(NSArray *)dateList{
    NSMutableArray *measureDate = [[NSMutableArray alloc]initWithCapacity:2];
    for (NSString *dateStr in dateList) {
        int month= [[dateStr substringWithRange:NSMakeRange(5,2)] intValue];
        int day= [[dateStr substringWithRange:NSMakeRange(8,2)] intValue];
        [measureDate addObject:[NSString stringWithFormat:@"%d月%d日",month,day]];
    }

   
    if (measureDate.count < 7) {
        NSString *lateDate;//不包含时分秒的日期
        if (measureDate.count == 0) {
            NSDate *nowDate = [NSDate dateWithTimeIntervalSinceNow:-60 * 60 * 24];
            NSString *str = [NSString stringWithFormat:@"%@",nowDate];
            lateDate = [str componentsSeparatedByString:@" "].firstObject;
        }else{
            lateDate = [dateList.lastObject componentsSeparatedByString:@" "].firstObject;
        }
        NSInteger addNum = 7-measureDate.count;
        for (int i = 0; i< addNum; i++) {
            NSDateFormatter *dateFormatter = [NSDateFormatter new];
            [dateFormatter setDateFormat:@"yyyy-MM-dd "];
            NSDate *myDate = [dateFormatter dateFromString:lateDate];
            
            NSDate *newDate = [myDate dateByAddingTimeInterval:60 * 60 * 24 * (i+1)];
            // 转换
            int month= [[[dateFormatter stringFromDate:newDate] substringWithRange:NSMakeRange(5,2)] intValue];
            int day= [[[dateFormatter stringFromDate:newDate] substringWithRange:NSMakeRange(8,2)] intValue];
            
            [measureDate addObject:[NSString stringWithFormat:@"%d月%d日",month,day]];
        }
    }
    NSLog(@"%@",measureDate);
    self.dateX = measureDate;

    
}
@end
