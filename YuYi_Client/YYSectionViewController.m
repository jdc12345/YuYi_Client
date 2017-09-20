//
//  YYSectionViewController.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/21.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//
#define leftTableWidth  [UIScreen mainScreen].bounds.size.width * 0.3
#define rightTableWidth [UIScreen mainScreen].bounds.size.width * 0.7
#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight    [UIScreen mainScreen].bounds.size.height

#define leftCellIdentifier  @"leftCellIdentifier"
#define rightCellIdentifier @"rightCellIdentifier"

#import "YYSectionViewController.h"
#import "YYSectorViewController.h"
#import "HttpClient.h"
#import <MJExtension.h>
#import "SectionModel.h"

@interface YYSectionViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *leftTableView;

@property (nonatomic, weak) UITableView *rightTableView;

@property (nonatomic, strong) NSMutableArray *leftDataSource;

@property (nonatomic, strong) NSMutableArray *rightDataSourceList;

@property (nonatomic, assign) NSInteger sectionCount;//右侧tab的数据源在左侧tab对应的行

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSArray *responeList;


@end

@implementation YYSectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"涿州市中医院";
    self.leftDataSource = [[NSMutableArray alloc]initWithArray:@[@"内科",@"外科",@"妇产科",@"儿科",@"眼科",@"耳鼻喉科",@"口腔科",@"中医科"]];
    self.rightDataSourceList = [[NSMutableArray alloc]initWithArray:@[@[@"呼吸内科门诊",@"消化内科门诊",@"心脑血管内科门诊",@"肾内科门诊",@"神经内科内科门诊",@"感染内科门诊",@"普内科门诊"],@[@"呼吸外科",@"消化外科",@"心脑血管外科",@"肾外科",@"神经外科",@"感染外科",@"普外科"],@[@"呼吸妇产科",@"消化妇产科",@"心脑血管妇产科",@"肾妇产科",@"神经妇产科",@"感染妇产科",@"普妇产科"],@[@"呼吸儿科",@"消化儿科",@"心脑血管儿科",@"肾儿科",@"神经儿科",@"感染儿科",@"普儿科"],@[@"呼吸眼科",@"消化眼科",@"心脑血管眼科",@"肾眼科",@"神经眼科",@"感染眼科",@"普眼科"],@[@"呼吸耳鼻喉科",@"消化耳鼻喉科",@"心脑血管耳鼻喉科",@"肾耳鼻喉科",@"神经耳鼻喉科",@"感染内耳鼻喉科",@"普耳鼻喉科"],@[@"呼吸口腔科",@"消化口腔科",@"心脑血管口腔科",@"肾口腔科",@"神经口腔科",@"感染口腔科",@"普口腔科"],@[@"呼吸中医科",@"消化中医科",@"心脑血管中医科",@"肾中医科",@"神经中医科",@"感染中医科",@"普中医科"]]];
    [self httpRequest];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    

    // Do any additional setup after loading the view.
}
#pragma mark - tableView 数据源代理方法 -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView == self.leftTableView) return 1;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.leftTableView) return self.leftDataSource.count;
    NSArray *current_list = self.rightDataSourceList[self.sectionCount];
    return current_list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    // 左边的 view
    if (tableView == self.leftTableView) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:leftCellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = self.leftDataSource[indexPath.row];//[NSString stringWithFormat:@"%ld", indexPath.row];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
        cell.textLabel.highlightedTextColor = [UIColor colorWithHexString:@"1dbeec"];//cell选中的文字颜色
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];//cell选中的背景view
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        NSIndexPath*indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
        [self.leftTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        // 右边的 view
    } else {
        NSArray *currentDataSource = self.rightDataSourceList[self.sectionCount];
        
        cell = [tableView dequeueReusableCellWithIdentifier:rightCellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = currentDataSource[indexPath.row];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        //[NSString stringWithFormat:@"第%ld组-第%ld行", indexPath.section, indexPath.row];
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    // if (tableView == self.rightTableView) return [NSString stringWithFormat:@"第 %ld 组", section];
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60 *kiphone6;
}

#pragma mark - UITableViewDelegate 代理方法 -
//- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
//
//    这两个方法都不准确
//}
//
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
//
//    这两个方法都不准确
//}

//MARK: - 一个方法就能搞定 右边滑动时跟左边的联动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    // 如果是 左侧的 tableView 直接return
//    if (scrollView == self.leftTableView) return;
//    
//    // 取出显示在 视图 且最靠上 的 cell 的 indexPath
//    NSIndexPath *topHeaderViewIndexpath = [[self.rightTableView indexPathsForVisibleRows] firstObject];
//    
//    // 左侧 talbelView 移动的 indexPath
//    NSIndexPath *moveToIndexpath = [NSIndexPath indexPathForRow:topHeaderViewIndexpath.section inSection:0];
//    
//    // 移动 左侧 tableView 到 指定 indexPath 居中显示
//    [self.leftTableView selectRowAtIndexPath:moveToIndexpath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    
}

//MARK: - 点击 cell 的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 选中 左侧 的 tableView
    if (tableView == self.leftTableView) {
        
//        NSIndexPath *moveToIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        // 将右侧 tableView 移动到指定位置
//        [self.rightTableView selectRowAtIndexPath:moveToIndexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        self.sectionCount = indexPath.row;
        [self.rightTableView reloadData];
        // 取消选中效果
//        [self.leftTableView deselectRowAtIndexPath:moveToIndexPath animated:YES];
    }else{
        NSDictionary *dict = self.responeList[indexPath.section];
        NSArray *array = dict[@"clinicList"];
        NSDictionary *rightDict = array[indexPath.row];
        NSString *cid = rightDict[@"id"];
        NSArray *currentDataSource = self.rightDataSourceList[self.sectionCount];
        YYSectorViewController *sectorVC = [[YYSectorViewController alloc]init];
        sectorVC.sectorTitle = currentDataSource[indexPath.row];
        sectorVC.cid = cid;
        [self.navigationController pushViewController:sectorVC animated:YES];
        [self.rightTableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark - 懒加载 tableView -
// MARK: - 左边的 tableView
- (UITableView *)leftTableView {
    
    if (!_leftTableView) {

        UITableView *tableView = [[UITableView alloc] init];//WithFrame:CGRectMake(0, 0, leftTableWidth, ScreenHeight)];
        
        [self.view addSubview:tableView];
        
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.offset(0);
            make.size.mas_equalTo(CGSizeMake(120 *kiphone6, kScreenH));
        }];
        
        _leftTableView = tableView;
        
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.bounces = NO;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:leftCellIdentifier];
        tableView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
        tableView.tableFooterView = [[UIView alloc] init];
        
    }
    return _leftTableView;
}

// MARK: - 右边的 tableView
- (UITableView *)rightTableView {
    
    if (!_rightTableView) {
        UITableView *tableView = [[UITableView alloc] init];//WithFrame:CGRectMake(leftTableWidth, 0, rightTableWidth, ScreenHeight)];
        
        [self.view addSubview:tableView];
        
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_leftTableView.mas_top).offset(64);
            make.left.equalTo(_leftTableView.mas_right);
            make.size.mas_equalTo(CGSizeMake(255 *kiphone6, kScreenH));
        }];
        
        _rightTableView = tableView;
        
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.bounces = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.sectionCount = 0;
        
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:rightCellIdentifier];
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.tableFooterView = [[UIView alloc] init];
        
    }
    return _rightTableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark ------------Http client----------------------
- (void)httpRequest{
    [[HttpClient defaultClient]requestWithPath:[NSString stringWithFormat:@"%@%@",mHospitalClass,self.info_id] method:0 parameters:nil prepareExecute:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        [self.leftDataSource removeAllObjects];
        [self.rightDataSourceList removeAllObjects];
        NSArray *dataList = responseObject[@"result"];
        for (NSDictionary *dict in dataList) {
            SectionModel *sectionModel = [SectionModel mj_objectWithKeyValues:dict];
            [self.dataSource addObject:sectionModel];
            
            [self.leftDataSource addObject:sectionModel.departmentName];
            NSMutableArray *singleRightData = [[NSMutableArray alloc]initWithCapacity:2];
            for (NSDictionary *singleDict in sectionModel.clinicList) {
                [singleRightData addObject:singleDict[@"clinicName"]];
            }
            [self.rightDataSourceList addObject:singleRightData];
        }
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
        self.responeList = dataList;
        
    
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
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
