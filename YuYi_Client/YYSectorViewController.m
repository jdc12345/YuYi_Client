//
//  YYSectorViewController.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/21.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYSectorViewController.h"
#import <Masonry.h>
#import "SectorCalendar.h"
#import "UIColor+Extension.h"
#import "YYSectorTableViewCell.h"
@interface YYSectorViewController ()<UIScrollViewDelegate,UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation YYSectorViewController
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.indicatorStyle =
        _tableView.rowHeight = kScreenW *77/320.0 +10;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        //        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        [_tableView registerClass:[YYSectorTableViewCell class] forCellReuseIdentifier:@"YYSectorTableViewCell"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [self.view addSubview:_tableView];
        [self.view sendSubviewToBack:_tableView];
        
    }
    return _tableView;
}
- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.sectorTitle;
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.tableHeaderView = [self updataView];
    
    
    // Do any additional setup after loading the view.
}
- (UIScrollView *)updataView{
    WS(ws);
    
    NSArray *dateList = @[@"01/13",@"01/14",@"01/15",@"01/16",@"01/17",@"01/18",@"01/19"];
    
    UIScrollView *scrollTrendView = [[UIScrollView alloc]init];
    scrollTrendView.contentSize = CGSizeMake(700 *kiphone6, 60 *kiphone6);
    scrollTrendView.pagingEnabled = YES;
    scrollTrendView.showsHorizontalScrollIndicator = NO;
    scrollTrendView.showsVerticalScrollIndicator = NO;
    scrollTrendView.bounces = NO;
    scrollTrendView.delegate = self;
    scrollTrendView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    
    for (int i = 0; i <7; i++) {
        SectorCalendar *sectorView = [[SectorCalendar alloc]init];
        [sectorView setAppointment_date:dateList[i]];
        sectorView.tag = 120 +i;
        
        // block 回调
        sectorView.timeClick = ^(BOOL isMorning){
            for (int j = 0; j <7 ;  j++) {
                SectorCalendar *otherV = (SectorCalendar *)[scrollTrendView viewWithTag:120 +j];
                if (otherV != sectorView) {
                    [otherV resumeView];
                }

            }
        };
        
        [scrollTrendView addSubview:sectorView];
        
        [sectorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(scrollTrendView).with.offset(0);
            make.left.equalTo(scrollTrendView).with.offset(i*100*kiphone6);
            make.size.mas_equalTo(CGSizeMake(100 *kiphone6 ,60 *kiphone6));
        }];
    }
    // [self.view addSubview:scrollTrendView];
    scrollTrendView.contentOffset = CGPointMake(0, 0);
    
    
//    [scrollTrendView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(ws.tableView).with.offset(0);
//        make.left.equalTo(ws.tableView).with.offset(0);
//        make.size.mas_equalTo(CGSizeMake(kScreenW ,70 *kiphone6));
//    }];
    scrollTrendView.frame = CGRectMake(0, 0, kScreenW, 70*kiphone6);
    
    return scrollTrendView;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark ------------Tableview Delegate----------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    [self.navigationController pushViewController:[[YYSectionViewController alloc]init] animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark -
#pragma mark ------------TableView DataSource----------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120 *kiphone6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYSectorTableViewCell *homeTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"YYSectorTableViewCell" forIndexPath:indexPath];
//    [homeTableViewCell createDetailView:2];
//    [homeTableViewCell addStarView];
    homeTableViewCell.iconV.image = [UIImage imageNamed:[NSString stringWithFormat:@"cell%ld",(indexPath.row)%2 +1]];
    homeTableViewCell.backgroundColor = [UIColor cyanColor];
    
    return homeTableViewCell;
    
}
/*

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
