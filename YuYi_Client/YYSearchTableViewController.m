//
//  YYSearchTableViewController.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/3/1.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYSearchTableViewController.h"
#import "YYSearchRecordSingleton.h"
#import "UIColor+colorValues.h"
#import <Masonry.h>
#import "HttpClient.h"
#import "YYModel.h"
#import "YYMedinicalDetailModel.h"
#import "YYMedicinalDetailVC.h"

static NSString *dentifier=@"cellforappliancelist";
@interface YYSearchTableViewController ()<UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *hehearray;
@property (nonatomic, strong) UISearchController *searchController;
@property (strong,nonatomic) NSMutableArray  *searchingList;
@property (strong,nonatomic) NSMutableArray  *searchedList;

@property(nonatomic,weak)UITableView *tableView;
@end

@implementation YYSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    for (int i=0; i<50; i++) {
        [self.hehearray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    _searchController=[[UISearchController  alloc]initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, 20, self.searchController.searchBar.frame.size.width, 44.0);
    [self.searchController.searchBar setTintColor:[UIColor colorWithHexString:@"25f368"]];
    //先取出cancleButton
    self.searchController.searchBar.showsCancelButton = true;
    UIButton *cancleButton = [self.searchController.searchBar valueForKey:@"_cancelButton"];
    [cancleButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    // 先取出textfield
    UITextField*searchField=[self.searchController.searchBar valueForKey:@"_searchField"];
    [searchField setBackgroundColor:[UIColor colorWithHexString:@"#f2f2f2"]];
    [[[self.searchController.searchBar.subviews.firstObject subviews] firstObject] removeFromSuperview];// 直接把背景imageView干掉
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 44)];
    view.backgroundColor = [UIColor whiteColor];
    [self.searchController.searchBar insertSubview:view atIndex:0];

    self.searchController.searchBar.placeholder = @"搜索医院、药品";
//    [self.searchController.searchBar setValue:@"取消" forKey:@"_cancelButtonText"];
    //tableView
    //解决状态栏透明
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIView *stateView = [[UIView alloc]init];
    stateView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:stateView];
    [stateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(20);
    }];
    //tableView
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, kScreenW, kScreenH-20)];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:dentifier];
    self.navigationController.navigationBar.hidden = true;
    [UIApplication sharedApplication].statusBarHidden = false;
    //搜索记录
    self.searchedList = [YYSearchRecordSingleton sharedInstance].searchRecords;
}

#pragma 懒加载
-(NSMutableArray *)hehearray
{
    if (_hehearray==nil) {
        _hehearray=[NSMutableArray array];
    }
    return _hehearray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchController.active) {
        return [self.searchingList count];
    }else{
        return [self.searchedList count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dentifier forIndexPath:indexPath];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:dentifier];
    }
    if (self.searchController.active) {
        YYMedinicalDetailModel *model = self.searchingList[indexPath.row];
        [cell.textLabel setText:model.drugsName];
    }
    else{
        YYMedinicalDetailModel *model = self.searchedList[indexPath.row];
        [cell.textLabel setText:model.drugsName];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //保存搜索过的内容?????bug1(本地保存+不能重复保存)+跳转医院
    [self.searchedList addObject:self.searchingList[indexPath.row]];
    if (self.searchCayegory==0) {//跳转医药详情页面
        YYMedinicalDetailModel *model = self.searchingList[indexPath.row];
        YYMedicinalDetailVC *detailVC = [[YYMedicinalDetailVC alloc]init];
        detailVC.id = model.id;
        [self.navigationController pushViewController:detailVC animated:true];
    }
   

}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView*footView = [[UIView alloc]init];
    if (self.searchedList.count!=0) {
        UIButton *clearBtn = [[UIButton alloc]init];
        [clearBtn addTarget:self action:@selector(clearSearedList:) forControlEvents:UIControlEventTouchUpInside];
        [clearBtn setTitle:@"清除全部" forState:UIControlStateNormal];
        [clearBtn setTitleColor:[UIColor colorWithHexString:@"25f368"] forState:UIControlStateNormal];
        clearBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [clearBtn sizeToFit];
        [footView addSubview:clearBtn];
        [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(footView);
            make.left.offset(25);
            make.width.offset(60);
        }];
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(15, 0, kScreenW, 1)];
        line1.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(15, 53, kScreenW, 1)];
        line2.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        [footView addSubview:line1];
        [footView addSubview:line2];
        return footView;
    }else{
        tableView.tableFooterView.backgroundColor = [UIColor whiteColor];
        return nil;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.searchController.active) {
        return 0;
    }
    return 54;
}
#pragma searchResultUpdating

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchString = [self.searchController.searchBar text];
    
    //NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    
    if (self.searchingList!= nil) {
        [self.searchingList removeAllObjects];
    }
    //向数据库请求搜索结果
    NSString *urlStr = [NSString string];
    if (self.searchCayegory==1) {
        urlStr = [hospitalSearchInfo stringByAppendingString:searchString];
    }else if(self.searchCayegory==0){
        urlStr = [medicinalSearchInfo stringByAppendingString:searchString];
    }
   
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    HttpClient *client = [HttpClient defaultClient];
    [client requestWithPath:urlStr method:HttpRequestPost parameters:nil prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *responseDic = (NSDictionary*)responseObject;
        NSArray *responseArr = responseDic[@"result"];
        NSArray *resultArr = [NSArray yy_modelArrayWithClass:[YYMedinicalDetailModel class] json:responseArr];
        /*for (YYMedinicalDetailModel *model in resultArr) {
            [self.searchingList addObject:model.drugsName];
        }*/
        self.searchingList = [NSMutableArray arrayWithArray:resultArr];
        //刷新表格
        
        [self.tableView reloadData];

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        return ;
    }];

    //过滤数据
    //self.searchingList= [NSMutableArray arrayWithArray:[_hehearray filteredArrayUsingPredicate:preicate]];
    
    }
#pragma btnClicks
-(void)back:(UIButton*)sender{
    [self.navigationController popViewControllerAnimated:true];
}
-(void)clearSearedList:(UIButton*)sender{
    [self.searchedList removeAllObjects];
    [self.tableView reloadData];
}
-(NSMutableArray *)searchingList{
    if (_searchingList==nil) {
        _searchingList = [NSMutableArray array];
    }
    return _searchingList;
}
//
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = true;
    self.searchController.searchBar.showsCancelButton = true;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.searchController.active = NO;
    self.navigationController.navigationBar.hidden = false;
    [self.searchController.searchBar removeFromSuperview];
    
}
@end
