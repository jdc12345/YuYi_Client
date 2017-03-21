//
//  YYMyMedicinalStateVC.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/3/21.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYMyMedicinalStateVC.h"
#import "UILabel+Addition.h"
#import <Masonry.h>
#import "UIColor+colorValues.h"
#import "YYStateTableViewCell.h"
#import "YYModel.h"
#import "YYMedicinalStateModel.h"

static NSString *cellId = @"cell_id";
@interface YYMyMedicinalStateVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,weak)UILabel *stateLbel;
@end

@implementation YYMyMedicinalStateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的药品状态";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    
}
-(void)loadData{
    NSArray *stateArr = @[@{@"time":@"08:10",@"state":@"亲，药品清单已接受，正在配药"},@{@"time":@"08:30",@"state":@"亲，配药已完成，现在准备煎药"},@{@"time":@"9：20",@"state":@"亲，药已经开始煎了，请耐心等待"},@{@"time":@"10：20",@"state":@"亲，药已煎好,快来拿药吧"}];
    NSArray *models = [NSArray yy_modelArrayWithClass:[YYMedicinalStateModel class] json:stateArr];
    self.dataArr = models;
    [self setupUI];
}
-(void)setupUI{
    //添加药品状态栏
    UIView *medicineState = [[UIView alloc]init];
    [self.view addSubview:medicineState];
    [medicineState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(0);
        make.height.offset(70);
    }];
    [medicineState setBackgroundColor:[UIColor colorWithHexString:@"#f9f9f9"]];
    UIImageView *mImageView = [[UIImageView alloc]init];//添加药品图标
    mImageView.image = [UIImage imageNamed:@"medicinal"];
    [medicineState addSubview:mImageView];
    [mImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(medicineState);
        make.left.offset(20);
    }];
    UILabel *mineStateLabel = [UILabel labelWithText:@"我的药品状态" andTextColor:[UIColor colorWithHexString:@"333333"] andFontSize:13];//添加我的药品状态标题
    [medicineState addSubview:mineStateLabel];
    [mineStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(medicineState.mas_centerY).offset(-3);
        make.left.equalTo(mImageView.mas_right).offset(10);
    }];
    UILabel *dateLabel = [UILabel labelWithText:@"2017-3-20" andTextColor:[UIColor colorWithHexString:@"333333"] andFontSize:13];//添加我的药品状态下时间label
    [medicineState addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(medicineState.mas_centerY).offset(3);
        make.left.equalTo(mImageView.mas_right).offset(10);
    }];
    UILabel *stateLabel = [UILabel labelWithText:@"当前状态:煎药中" andTextColor:[UIColor colorWithHexString:@"333333"] andFontSize:12];
    [medicineState addSubview:stateLabel];
    self.stateLbel = stateLabel;
    [stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(medicineState);
        make.right.offset(-15);
    }];
    //添加进度条
    UIView *progressBar = [[UIView alloc]init];
    progressBar.backgroundColor = [UIColor colorWithHexString:@"#25f368"];
    [self.view addSubview:progressBar];
    [progressBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.equalTo(medicineState.mas_bottom);
        make.height.offset(2);
        make.width.offset(kScreenW*0.2*self.dataArr.count);
    }];
    //添加状态进度
    UITableView *stateTableView = [[UITableView alloc]init];
    [self.view addSubview:stateTableView];
    stateTableView.delegate = self;
    stateTableView.dataSource = self;
    stateTableView.rowHeight = UITableViewAutomaticDimension;
    stateTableView.estimatedRowHeight = 100;
    stateTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    stateTableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 15)];
    [stateTableView registerClass:[YYStateTableViewCell class] forCellReuseIdentifier:cellId];
    [stateTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(progressBar.mas_bottom);
    }];

}
#pragma UITableViewDelegate/dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYStateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    YYMedicinalStateModel *model = self.dataArr[indexPath.row];
    cell.timeLabel.text = model.time;
    cell.stateLabel.text = model.state;
    if (indexPath.row==self.dataArr.count-2) {
        cell.progressBar.backgroundColor = [UIColor colorWithHexString:@"#25f368"];
        
    }
    if (indexPath.row==self.dataArr.count-1) {
        cell.progressBar.hidden = true;
        cell.iconView.image = [UIImage imageNamed:@"Selected"];
        self.stateLbel.text = [NSString stringWithFormat:@"当前状态：%@", model.state];
    }
    return cell;
}

//设置导航栏高度适应
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = false;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = true;
}

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
