//
//  YYShopCarTableView.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/3/1.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYShopCarTableView.h"
#import "YYShopCartSingleton.h"
#import "YYShopCarTableViewCell.h"
#import <Masonry.h>
#import "UIColor+colorValues.h"
#import "YYLogInVC.h"

static NSString *shopCarGoodCellId = @"shopCarGoodCell_id";
@interface YYShopCarTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITextField *pickerTextField;

@property (nonatomic, strong) NSMutableArray<NSArray *> *goodsArray;

@property (nonatomic, assign) CGFloat marketPrice;

@property (nonatomic, assign) CGFloat bookingPrice;

@property (nonatomic, strong) NSMutableArray<NSNumber *> *totalPriceArray;

@end

@implementation YYShopCarTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.goodsArray = [YYShopCartSingleton sharedInstance].shopCartGoods;
        self.totalPriceArray = [NSMutableArray array];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor clearColor];
    self.estimatedRowHeight = 150;
    self.rowHeight = UITableViewAutomaticDimension;
    [self registerNib:[UINib nibWithNibName:@"YYShopCarTableViewCell" bundle:nil] forCellReuseIdentifier:shopCarGoodCellId];
}

#pragma tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goodsArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYShopCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shopCarGoodCellId];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.goodsArray.count>0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 100)];
        view.backgroundColor = [UIColor whiteColor];
        UIButton *balanceBtn = [[UIButton alloc]init];
        balanceBtn.backgroundColor = [UIColor colorWithHexString:@"66cc00"];
        [balanceBtn setTitle:@"去结算" forState:UIControlStateNormal];
        [balanceBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
        [view addSubview:balanceBtn];
        [balanceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(view);
            make.width.offset(100);
            make.height.offset(30);
        }];
        [balanceBtn addTarget:self action:@selector(goBalance:) forControlEvents:UIControlEventTouchUpInside];
        return view;
        
    }else{
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.goodsArray.count>0) {
        return 100;
    }else{
        return 0;
    }
    
}


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   UITableViewCellEditingStyleDelete;
}
//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    WS(weakself);
    [tableView setEditing:NO animated:YES];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你确定删除该商品？" preferredStyle:UIAlertControllerStyleAlert];
        //        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            //
            //            [_classArray removeObjectAtIndex:indexPath.row];
            //            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            //            MessageModel *model = weakself.dataArray[indexPath.row];
            //            [weakself singleDelet:model.mid];
            [self.goodsArray removeObjectAtIndex:indexPath.row];
            [self reloadData];
            
        }]];
        
        [self.vc presentViewController:alertController animated:YES completion:nil];
    }
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
//设置进入编辑状态时，Cell不会缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma goBalance
-(void)goBalance:(UIButton*)sender{
    //换登录
    YYLogInVC *liVC = [[YYLogInVC alloc]init];
    [self.vc.navigationController pushViewController:liVC animated:true];
}
@end
