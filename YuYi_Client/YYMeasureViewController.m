//
//  YYMeasureViewController.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/17.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYMeasureViewController.h"
#import "YYMeasureTableViewCell.h"
//#import "FMActionSheet.h"
#import "YYAutoMeasureViewController.h"
#import "YYHandleMeasureViewController.h"
#import "YYConnectViewController.h"
#import "YYCurruntBloodPressureVC.h"

@interface YYMeasureViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
//@property (nonatomic, strong) FMActionSheet *fmActionS;
@property (nonatomic, assign) NSInteger currentRow;

@end

@implementation YYMeasureViewController

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.indicatorStyle =
        _tableView.rowHeight = kScreenW *77/320.0 +10;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        //        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        [_tableView registerClass:[YYMeasureTableViewCell class] forCellReuseIdentifier:@"YYMeasureTableViewCell"];
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
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"测量";
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 5 *kiphone6)];
    headView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = headView;
    // Do any additional setup after loading the view.
}
#pragma mark -
#pragma mark ------------TableView Delegate----------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0) {
        YYCurruntBloodPressureVC *autuMVC = [[YYCurruntBloodPressureVC alloc]init];
        autuMVC.navTitle = @"当前血压";
        [self.navigationController pushViewController:autuMVC animated:YES];
    }else if (indexPath.row == 1){
        YYAutoMeasureViewController *autuMVC = [[YYAutoMeasureViewController alloc]init];
        autuMVC.navTitle = @"当前体温";
        [self.navigationController pushViewController:autuMVC animated:YES];
    }else{
        YYConnectViewController *connectVC = [[YYConnectViewController alloc]init];
        [self.navigationController pushViewController:connectVC animated:YES];
    }
//    if (indexPath.row != 2) {
// 
//    FMActionSheet *sheet = [[FMActionSheet alloc] initWithTitle:@""
//                                                   buttonTitles:[NSArray arrayWithObjects:@"自动输入",@"手动输入", nil]
//                                              cancelButtonTitle:@"取消"
//                                                       delegate:(id<FMActionSheetDelegate>)self
//                                                        buttonW:kScreenW];
//    sheet.titleFont = [UIFont systemFontOfSize:20];
//    sheet.titleBackgroundColor = [UIColor colorWithHexString:@"f4f5f8"];
//    sheet.titleColor = [UIColor colorWithHexString:@"666666"];
//    sheet.lineColor = [UIColor colorWithHexString:@"dbdce4"];
//    [sheet show];
//        self.currentRow = indexPath.row;
//    }else{
//        YYConnectViewController *connectVC = [[YYConnectViewController alloc]init];
//        [self.navigationController pushViewController:connectVC animated:YES];
//    }
}
#pragma mark -
#pragma mark ------------TableView DataSource----------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120 *kiphone6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYMeasureTableViewCell *homeTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"YYMeasureTableViewCell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        homeTableViewCell.cardView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"picture-one"]];
        homeTableViewCell.iconV.image = [UIImage imageNamed:[NSString stringWithFormat:@"measure_heater"]];
        homeTableViewCell.titleLabel.text = @"血压计";
        homeTableViewCell.introduceLabel.text = @"血压测量记录";
    
    }else if(indexPath.row == 1){
        homeTableViewCell.cardView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"picture-two"]];
        homeTableViewCell.iconV.image = [UIImage imageNamed:[NSString stringWithFormat:@"measure_temp"]];
        homeTableViewCell.titleLabel.text = @"体温计";
        homeTableViewCell.introduceLabel.text = @"体温测量记录";
    }else{
        [homeTableViewCell addOtherCell];
        homeTableViewCell.iconV.image = [UIImage imageNamed:[NSString stringWithFormat:@"add_equ"]];
        homeTableViewCell.introduceLabel.text = @"添加其他设备";
        
    }
//    homeTableViewCell.backgroundColor = [UIColor blackColor];
    [homeTableViewCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return homeTableViewCell;
    
}
//#pragma mark - ......::::::: UIActionSheetDelegate :::::::......
//
//- (void)actionSheet:(FMActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//    NSLog(@"clickedButtonAtIndex:%ld",buttonIndex);
//    if (buttonIndex == 0) {
//        if (_currentRow == 0) {
//            YYAutoMeasureViewController *autuMVC = [[YYAutoMeasureViewController alloc]init];
//            autuMVC.navTitle = @"当前血压";
//            [self.navigationController pushViewController:autuMVC animated:YES];
//        }else{
//            YYAutoMeasureViewController *autuMVC = [[YYAutoMeasureViewController alloc]init];
//            autuMVC.navTitle = @"当前体温";
//            [self.navigationController pushViewController:autuMVC animated:YES];
//        }
//        
//        
//    }else if(buttonIndex == 1){
//        if (_currentRow == 0) {
//            YYHandleMeasureViewController *autuMVC = [[YYHandleMeasureViewController alloc]init];
//            autuMVC.navTitle = @"当前血压";
//            [self.navigationController pushViewController:autuMVC animated:YES];
//        }else{
//            YYHandleMeasureViewController *autuMVC = [[YYHandleMeasureViewController alloc]init];
//            autuMVC.navTitle = @"当前体温";
//            [self.navigationController pushViewController:autuMVC animated:YES];
//        }
//    }else{
//        
//    }
//    
//}
//
//- (UIFont *)actionSheet:(FMActionSheet *)actionSheet buttonTextFontAtIndex:(NSInteger)bottonIndex {
//    return [UIFont systemFontOfSize:20];
//}
//
//- (UIColor *)actionSheet:(FMActionSheet *)actionSheet buttonTextColorAtIndex:(NSInteger)bottonIndex {
//    if (bottonIndex == 0) {
//        return [UIColor whiteColor];
//    }
//    
//    return [UIColor whiteColor];
//}
//
//- (UIColor *)actionSheet:(FMActionSheet *)actionSheet buttonBackgroundColorAtIndex:(NSInteger)bottonIndex {
//    return [UIColor whiteColor];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
