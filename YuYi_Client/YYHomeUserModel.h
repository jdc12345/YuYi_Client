//
//  YYHomeUserModel.h
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/3/22.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYHomeUserModel : NSObject

@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *createTimeString;
@property (nonatomic, copy) NSString *groupId;
@property (nonatomic, copy) NSString *nickName;//身份
@property (nonatomic, copy) NSString *gradeName;
@property (nonatomic, copy) NSString *oid;
@property (nonatomic, copy) NSString *info_id;
@property (nonatomic, copy) NSString *role;
@property (nonatomic, copy) NSString *trueName;
@property (nonatomic, copy) NSString *idCard;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, strong) NSArray *bloodpressureList;
@property (nonatomic, strong) NSArray *temperatureList;
@property (nonatomic, copy) NSString *telephone;


@end
