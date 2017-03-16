//
//  YYCategoryModel.h
//  YuYi_Client
//
//  Created by 万宇 on 2017/3/16.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//"id": "1",
//"name": "常用",
//"platMark": "0",
//"level": "1",
//"pId": "null",
//"treeCode": "1",
//"open": true,
//"file": "",
//"isParent": true,
//"children": [

#import <Foundation/Foundation.h>

@interface YYCategoryModel : NSObject
@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)NSArray *children;
@end
