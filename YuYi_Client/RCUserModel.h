//
//  RCUserModel.h
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/3/30.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCUserModel : NSObject

@property (nonatomic, strong) NSString *Avatar;
@property (nonatomic, strong) NSString *TrueName;
@property (nonatomic, strong) NSString *info_id;
@property (nonatomic, strong) NSString *token;


+ (RCUserModel *)defaultClient;
@end
