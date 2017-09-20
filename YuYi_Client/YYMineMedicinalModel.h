//
//  YYMineMedicinalModel.h
//  YuYi_Client
//
//  Created by 万宇 on 2017/9/19.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//
//"createTimeString": "2017-09-19 16:44:08",
//"updateTimeString": "",
//"boilMedicineList": [
//                     {},
//                     {},
//                     {},
//                     {
//                         "createTimeString": "2017-09-19 16:34:54",
//                         "prescriptionId": 7,
//                         "updateTimeString": "",
//                         "stateText": "正在煎药",
//                         "id": 12
//                     }
//                     ],
//"title": "我的药方",
//"physicianId": null,
//"hospitalId": null,
//"humeuserId": null,
//"takeNote": "",
//"id": 7,
//"state": 4,
//"persinalId": 13014591689,
//"medincineCount": null
#import <Foundation/Foundation.h>

@interface YYMineMedicinalModel : NSObject
@property(nonatomic,copy)NSString *createTimeString;
@property(nonatomic,strong)NSArray *boilMedicineList;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *info_id;
@property(nonatomic,copy)NSString *state;
@property(nonatomic,copy)NSString *persinalId;
@end
