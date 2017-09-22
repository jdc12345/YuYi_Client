//
//  YYCardView.h
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/22.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYCardView : UIView

//@property (nonatomic, strong) NSString *titleStr;

@property (nonatomic, weak) UITextField *highPressureField;

@property (nonatomic, weak) UITextField *lowPressureField;

@property (nonatomic, weak) UILabel *highLabel;

@property (nonatomic, weak) UILabel *lowLabel;

@property (nonatomic, weak) UILabel *resultLabel;//结果说明label
@end
