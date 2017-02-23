//
//  YYCardInputView.h
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/23.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYCardInputView : UIView

@property (nonatomic, strong) NSString *titleStr;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *dataLabel;

@property (nonatomic, strong) UILabel *promptLabel;

@property (nonatomic, strong) UITextField *dataTextField;

@end
