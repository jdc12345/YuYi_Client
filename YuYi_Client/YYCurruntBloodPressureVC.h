//
//  YYCurruntBloodPressureVC.h
//  YuYi_Client
//
//  Created by 万宇 on 2017/9/22.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JkezApi.h"

@interface YYCurruntBloodPressureVC : UIViewController
@property (nonatomic, strong) NSString *navTitle;
//测量类型
@property(nonatomic,assign) BTMEASURETYTE type;
@end
