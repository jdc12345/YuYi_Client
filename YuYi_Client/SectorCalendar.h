//
//  SectorCalendar.h
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/21.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectorCalendar : UIView

@property (nonatomic, strong) NSString* appointment_date;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UIButton *morningBtn;

@property (nonatomic, strong) UIButton *afternoonBtn;


@property (nonatomic, copy) void(^timeClick)(BOOL isMorning);

- (void)resumeView;

@end
