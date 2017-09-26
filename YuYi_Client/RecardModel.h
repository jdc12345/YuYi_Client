//
//  RecardModel.h
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/3/24.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//
//"departmentName": "内科",
//"createTimeString": "2017-09-26 11:56:35",
//"updateTimeString": "",
//"departmentId": 1,
//"homeuserid": 101,
//"medicalrecord": "电子病历",
//"hospitalName": "涿州市中医医院",
//"picture": "/static/image/avatar.jpeg;/static/image/avatar.jpeg;/static/image/avatar.jpeg;/static/image/avatar.jpeg;/static/image/avatar.jpeg",
//"physicianId": 34,
//"physicianName": "",
//"hospitalId": 1,
//"id": 20,
//"persinalId": 13014591689
#import <Foundation/Foundation.h>

@interface RecardModel : NSObject

@property (nonatomic, copy) NSString *createTimeString;
@property (nonatomic, copy) NSString *info_id;
@property (nonatomic, copy) NSString *persinalId;
@property (nonatomic, copy) NSString *departmentName;
@property (nonatomic, copy) NSString *departmentId;
@property (nonatomic, copy) NSString *homeuserid;
@property (nonatomic, copy) NSString *medicalrecord;
@property (nonatomic, copy) NSString *hospitalName;
@property (nonatomic, copy) NSString *picture;
@property (nonatomic, copy) NSString *physicianId;
@property (nonatomic, copy) NSString *physicianName;
@property (nonatomic, copy) NSString *hospitalId;


@end
