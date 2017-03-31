//
//  YYPersonalInfoViewController.h
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/28.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYHomeUserModel.h"

@interface YYPersonalInfoViewController : UIViewController

@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic, strong) YYHomeUserModel *personalModel;
@property (nonatomic, strong) NSString *type;

@end
