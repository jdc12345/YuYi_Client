//
//  YYMedinicalDetailModel.h
//  YuYi_Client
//
//  Created by 万宇 on 2017/3/16.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.

#import <Foundation/Foundation.h>

@interface YYMedinicalDetailModel : NSObject
//"createTimeString": "",
//"productSpecification": "产品规格",
@property(nonatomic,copy)NSString *productSpecification;
//"drugsName": "999感冒灵1",
@property(nonatomic,copy)NSString *drugsName;
//"specificationsd": "一盒3包",
@property(nonatomic,copy)NSString *specificationsd;
//"oid": 1,
@property(nonatomic,assign)NSInteger oid;
//"packing": "10g x3",
@property(nonatomic,copy)NSString *packing;
//"drugsCurrencyName": "999感冒灵1",
@property(nonatomic,copy)NSString *drugsCurrencyName;
//"localId": "",
//"drugsFunction": "适用症/功能主治",
@property(nonatomic,copy)NSString *drugsFunction;
//"number": 20,
@property(nonatomic,assign)NSInteger number;
//"price": 20,
@property(nonatomic,assign)NSInteger price;
//"drugsType": "颗粒",
@property(nonatomic,copy)NSString *drugsType;
//"drugsDosage": "用法用量",
@property(nonatomic,copy)NSString *drugsDosage;
//"specificationsdList": [ ],
//"details": "专治感冒",
@property(nonatomic,copy)NSString *details;
//"id": 1,
@property(nonatomic,assign)NSInteger id;
//"brand": "999",
@property(nonatomic,copy)NSString *brand;
//"businesses": "华润三九医药公司",
@property(nonatomic,copy)NSString *businesses;
//"info": "",
//"updateTimeString": "",
//"dosageForm": "颗粒",
@property(nonatomic,copy)NSString *dosageForm;
//"updateTime": null,
//"approvalNumber": "国药准字Z2017021423434",
@property(nonatomic,copy)NSString *approvalNumber;
//"picture": "/static/image/999.jpg",
@property(nonatomic,copy)NSString *picture;
//"categoryId1": 1,
//"categoryId2": 11,
//"createTime": null,
//"commodityName": "999感冒灵1",
@property(nonatomic,copy)NSString *commodityName;
//"status": 1
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
