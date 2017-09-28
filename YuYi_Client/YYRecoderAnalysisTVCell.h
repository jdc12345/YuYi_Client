//
//  YYRecoderAnalysisTVCell.h
//  YuYi_Client
//
//  Created by 万宇 on 2017/9/28.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecardModel.h"
@interface YYRecoderAnalysisTVCell : UITableViewCell
@property (nonatomic, strong) NSMutableArray *recoderData;//病历记录数据
@property(nonatomic,copy) void(^recoderCellClick)(RecardModel*);//记录cell点击事件
@end
