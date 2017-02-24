//
//  YYConfirmVC.h
//  电商
//
//  Created by 万宇 on 2017/2/23.
//  Copyright © 2017年 万宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYConfirmVC : UIViewController
//购物车商品详情
@property(nonatomic,strong)NSMutableArray *shopingCarDetails;
//上级页面加减数量
@property(nonatomic,assign)NSInteger number;
@end
