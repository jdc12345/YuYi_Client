//
//  YYInfomationModel.h
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/3/20.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYInfomationModel : NSObject

@property (nonatomic, copy) NSString *mediumUrl;
@property (nonatomic, copy) NSString *highUrl;
@property (nonatomic, copy) NSString *defaultUrl;



@property (nonatomic, copy) NSString *introduction;
@property (nonatomic, copy) NSString *hospitalName;
@property (nonatomic, copy) NSString *gradeName;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *info_id;
@property (nonatomic, copy) NSString *picture;


// 文章
@property (nonatomic, copy) NSString *articleText;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *smalltitle;
@property (nonatomic, copy) NSString *tell;


@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double lng;


@end
