//
//  YYHeadViewModel.h
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/3/22.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//
//返回值：   返回值名称                返回值类型    备注
//picture        String      图片
//title        String      标题
//content        String      正文
//createTime      String      发布时间
//smallTitle      String      小标题
//hospitalId        Long      医院编号
//auditState      Integer   审核状态1=审核通过，2=审核中，3=审核失败
//publishchannel      Integer    发布渠道1=宇医2=宇医医生
//code              0成功
#import <Foundation/Foundation.h>

@interface YYHeadViewModel : NSObject
@property (nonatomic, copy) NSString *info_id;
@property (nonatomic, copy) NSString *picture;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *smallTitle;
@property (nonatomic, assign) long hospitalId;
@property (nonatomic, assign) NSInteger auditState;
@property (nonatomic, assign) NSInteger publishchannel;
@end
