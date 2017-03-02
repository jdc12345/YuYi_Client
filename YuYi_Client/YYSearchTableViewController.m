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
static NSString *dentifier=@"cellforappliancelist";
@interface YYSearchTableViewController ()<UISearchResultsUpdating>
@property(nonatomic,strong)NSMutableArray *hehearray;
@property (nonatomic, strong) UISearchController *searchController;
@property (strong,nonatomic) NSMutableArray  *searchingList;
@property (strong,nonatomic) NSMutableArray  *searchedList;
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
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
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
    self.searchController.searchBar.placeholder = @"搜索医院、药品";
//    [self.searchController.searchBar setValue:@"取消" forKey:@"_cancelButtonText"];
    //tableView
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:dentifier];
    self.navigationController.navigationBar.hidden = true;
    [UIApplication sharedApplication].statusBarHidden = YES;
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
        [cell.textLabel setText:self.searchingList[indexPath.row]];
    }
    else{
        [cell.textLabel setText:self.searchedList[indexPath.row]];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //保存搜索过的内容
    [self.searchedList addObject:[tableView cellForRowAtIndexPath:indexPath].textLabel.text];
   

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
    
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    
    if (self.searchingList!= nil) {
        [self.searchingList removeAllObjects];
    }
    //过滤数据
    self.searchingList= [NSMutableArray arrayWithArray:[_hehearray filteredArrayUsingPredicate:preicate]];
    
    //刷新表格
    
    [self.tableView reloadData];
}
#pragma btnClicks
-(void)back:(UIButton*)sender{
    [self.navigationController popViewControllerAnimated:true];
}
-(void)clearSearedList:(UIButton*)sender{
    [self.searchedList removeAllObjects];
    [self.tableView reloadData];
}
//
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.searchController.active = NO;
    self.navigationController.navigationBar.hidden = false;
    [self.searchController.searchBar removeFromSuperview];
    
}
@end
