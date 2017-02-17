//
//  YYHomePageViewController.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/17.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYHomePageViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MJRefresh.h>

@interface YYHomePageViewController ()<UITableViewDataSource, UITableViewDelegate,SDWebImageManagerDelegate,SDWebImageOperation>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation YYHomePageViewController

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH - 64) style:UITableViewStylePlain];
        _tableView.backgroundColor = kColor_DefaultGray;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.indicatorStyle =
        _tableView.rowHeight = kScreenW *77/320.0 +10;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
//        [_tableView registerClass:[HomepageTableViewCell class] forCellReuseIdentifier:@"HomepageTableViewCell"];
//        [_tableView registerClass:[HomeBannerTableViewCell class] forCellReuseIdentifier:@"HomeBannerTableViewCell"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [self.view addSubview:_tableView];
        [self.view sendSubviewToBack:_tableView];
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"首页";
    
    
    // 左侧地址按钮
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [leftButton setFrame:CGRectMake(0,0,40, 30)];
    
    [leftButton setTitle:@"北京" forState:UIControlStateNormal];
    
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [leftButton addTarget:self action:@selector(back_click:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    // 右侧通知按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightButton setFrame:CGRectMake(0,0,20, 20)];
    
    [rightButton setBackgroundImage:[UIImage imageNamed:@"notfic_select"] forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(back_click:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    HomeListHead *headModel = self.headSource[section];
//    if (headModel.title == nil) {
//        return nil;
//    }else{
//        HomeSectionView *view = [[HomeSectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 77)];
//        WS(ws);
//        view.moreBtnClick = ^(NSString *title){
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:headModel.targetUri]];
//            ws.subTitle = title;
//            NSDictionary *dict = @{@"EnterChannel_fromIndex" : title};
//            [MobClick event:@"EnterChannel_fromIndex" attributes:dict];
//            
//        };
//        if (self.headSource.count != 0) {
//            HomeListHead *homeHeadModel = self.headSource[section];
//            [view setInfoForView:homeHeadModel];
//        }
//        if (section == 0) {
//            view.isFirst = YES;
//        }
//        return view;
//        
//    }
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    HomeListHead *headModel = self.headSource[section];
//    if (headModel.title == nil) {
//        return 0;
//    }
    return 72 *kiphone6;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
