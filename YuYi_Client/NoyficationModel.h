//
//  NoyficationModel.h
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/3/30.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoyficationModel : NSObject
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *createTimeString;
@property (nonatomic, copy) NSString *msgType;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *info_id;
@property (nonatomic, copy) NSString *picture;
@end
