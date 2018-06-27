//
//  ZRQECGAnaysic.h
//  ZRQECGAnaysic
//
//  Created by zhangjiang on 15/12/15.
//  Copyright © 2015年 深圳市中瑞奇电子科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZRQECGAnalysisDelegate <NSObject>



@required

// response 上传ecg后得到的分析结果  如果response为nil，会传回error错误原因  dic是用户信息，用于生成带结果的图片；
- (void)analysisResult:(id)response orError:(NSError *)error withUserinfor:(NSDictionary *)dic;


@end





@interface ZRQECGAnalysis : NSObject


@property (nonatomic,assign) id<ZRQECGAnalysisDelegate>delegate;


- (id)init;

//** ecg: 保存在本地的ecg文件转换成NSData类型
//** name: 单独的文件名
//** user: @"InstitID",@"InstitKey",@"UserID",@"UserName",@"UserAge",@"UserSex"  包含这6个key 和对应的value  其中 UserAge 和UserSex（0是女 1是男是NSNumber类型 其他都是NSString类型

- (void)analysisECG:(NSData *)ecg WithFileName:(NSString *)name AndUserInformation:(NSDictionary *)user;


//- (void)analysisECG:(NSData *)ecg WithFileName:(NSString *)name AndUserInformation:(NSDictionary *)user;

@end
