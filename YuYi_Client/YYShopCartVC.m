//
//  YYShopCartVC.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/2/28.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYShopCartVC.h"
#import "YYShopCartEmptyView.h"
#import "YYShopCarTableView.h"
#import "YYShopCartSingleton.h"
#import "UIColor+colorValues.h"
@interface YYShopCartVC ()
@property (nonatomic, weak) YYShopCartEmptyView *shopCartEmptyView;
@property (nonatomic, weak) YYShopCarTableView *shopCartView;


@property (nonatomic, strong) NSMutableArray<NSDictionary *> *goodsList;
@end

@implementation YYShopCartVC
- (NSMutableArray<NSDictionary *> *)goodsList {
//    return [[JXTWSQLiteManager sharedManager] getAllGoodsInShopCartWithUserId:JXTWUserId];
    YYShopCartSingleton *shopCart = [YYShopCartSingleton sharedInstance];

    return shopCart.shopCartGoods;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.automaticallyAdjustsScrollViewInsets = true;
    self.navigationController.navigationBar.translucent = false;
    [self setupUI];
}
- (void)setupUI {
    self.title = @"购物车";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    
    if (!self.goodsList.count) {
        self.shopCartEmptyView.hidden = false;
    } else {
        self.shopCartView.hidden = false;
    }
}
#pragma mark - 懒加载

- (YYShopCartEmptyView *)shopCartEmptyView {
    if (!_shopCartEmptyView) {
        YYShopCartEmptyView *emptyView = [[YYShopCartEmptyView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:emptyView];
        _shopCartEmptyView = emptyView;
        _shopCartEmptyView.hidden = true;
        _shopCartEmptyView.vc = self;
    }
    return _shopCartEmptyView;
}
- (YYShopCarTableView *)shopCartView {
    if (!_shopCartView) {
        YYShopCarTableView *shopCartView = [[YYShopCarTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        shopCartView.vc = self;
//        __weak typeof(self) weakSelf = self;
//        shopCartView.goodDetailButtonBlock = ^(JXTWGoodModel *goodModel){
//            JXTWPKgoodswebViewController *webVC = [[JXTWPKgoodswebViewController alloc] init];
//            webVC.Model = goodModel;
//            [weakSelf.navigationController pushViewController:webVC animated:true];
//        };
//        shopCartView.noGoodsBlock = ^{
//            weakSelf.shopCartEmptyView.hidden = false;
//            weakSelf.shopCartView.hidden = true;
//        };
        [self.view addSubview:shopCartView];
        _shopCartView = shopCartView;
        _shopCartView.hidden = true;
    }
    return _shopCartView;
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
