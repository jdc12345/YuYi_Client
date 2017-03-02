//
//  YYPInfomationTableViewCell.h
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/24.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYPInfomationTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *nextImageV;
@property (nonatomic, strong) UILabel *seeRecardLabel;
@property (nonatomic, strong) UITextField *editInfoText;

- (void)setType:(NSString *)cellType;


@property (nonatomic, copy) void(^sexClick)(NSString *);

@end
