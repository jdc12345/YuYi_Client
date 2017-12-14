//
//  ViewController.m
//  电商
//
//  Created by 万宇 on 2017/1/5.
//  Copyright © 2017年 万宇. All rights reserved.
//

#import "ViewController.h"
#import "HttpClient.h"
#import "CcUserModel.h"
#import "YYMedicinalStateModel.h"
#import "YYMineMedicinalModel.h"
#import <MJExtension.h>
#import "UILabel+Addition.h"
#import "headerTitleBtn.h"

static NSString* cellid = @"business_cell";
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
//商城首页药品分类按钮数据
@property (nonatomic,strong) NSMutableArray *mineMedicineArr;//所有药方
@property (nonatomic,strong) NSMutableArray *medicinalTitleArr;//药方名字集合
@property (nonatomic,strong) NSArray *stateModels;//我的药品状态
//“全部”按钮
@property (nonatomic,weak) UIButton *allBtn;
//“药方时间”
@property (nonatomic,strong) NSString *data;
@property (nonatomic,weak) UILabel *curruntMedicinalLabel;//显示当前药方的label
@property (nonatomic, strong) UITableView *tableView;//显示药方列表
@property (nonatomic, strong) UIScrollView *scrollTrendView;//显示药品状态的scrollow
@end

@implementation ViewController
-(NSMutableArray *)mineMedicineArr{
    if (_mineMedicineArr == nil) {
        _mineMedicineArr = [NSMutableArray arrayWithCapacity:2];
    }
    return _mineMedicineArr;
}
-(NSMutableArray *)medicinalTitleArr{
    if (_medicinalTitleArr == nil) {
        _medicinalTitleArr = [NSMutableArray arrayWithCapacity:2];
    }
    return _medicinalTitleArr;
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10*kiphone6, 80*kiphone6, kScreenW-20*kiphone6, 45*kiphone6*self.mineMedicineArr.count) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.indicatorStyle =
        _tableView.rowHeight = kScreenW *77/320.0 +10;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"mineMedicineTVCell"];
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的药品";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar    setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"333333"],NSFontAttributeName:[UIFont systemFontOfSize:17.0f]}];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"back"]];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back"]];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithHexString:@"333333"]];
    [self loadMineMedicinalData];
}
-(void)loadMineMedicinalData{
    HttpClient *httpManager = [HttpClient defaultClient];
        //取token
//    CcUserModel *userModel = [CcUserModel defaultClient];
//    NSString *userToken = userModel.userToken;
    NSString *urlString = [NSString stringWithFormat:@"%@/prescription/findList2.do?token=%@",mPrefixUrl,mDefineToken];
    [SVProgressHUD show];
    [httpManager requestWithPath:urlString method:HttpRequestGet parameters:nil prepareExecute:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"] isEqualToString:@"0"]) {
           NSArray *mineMedicineArr = responseObject[@"result"];
            if (mineMedicineArr.count>0) {
            for (NSDictionary *dic in mineMedicineArr) {
                YYMineMedicinalModel *medicinalModel = [YYMineMedicinalModel mj_objectWithKeyValues:dic];
                [self.mineMedicineArr addObject:medicinalModel];//存所有药方
                NSMutableArray *stateArr = [NSMutableArray array];
                for (NSDictionary *dic in medicinalModel.boilMedicineList) {
                    YYMedicinalStateModel *stateModel = [YYMedicinalStateModel mj_objectWithKeyValues:dic];
                    [stateArr addObject:stateModel];
                }
                medicinalModel.boilMedicineList = [stateArr copy];//每一个药方的状态集
                NSRange rang = [medicinalModel.createTimeString rangeOfString:@" "];
                NSInteger location = rang.location;
                NSString *timeStr = [medicinalModel.createTimeString substringToIndex:location];
                timeStr = [timeStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
                NSString *medicinalTitle = [NSString stringWithFormat:@"%@-%@",timeStr,medicinalModel.title];
                [self.medicinalTitleArr addObject:medicinalTitle];//存所有显示药方名字的字符串集
            }
            [self setupUI];
                
        }else{
            [self loadEmptyView];
            }
        }else{
            [self loadEmptyView];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
        return ;
    }];
}
//加载空页面
-(void)loadEmptyView{
    
    UIImageView *emptyView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nothing"]];
    [self.view addSubview:emptyView];
    [emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(155*kiphone6);
        make.centerX.equalTo(self.view);
    }];
    UILabel *noticelabel = [UILabel labelWithText:@"这里什么都没有" andTextColor:[UIColor colorWithHexString:@"bababa"] andFontSize:15];
    [self.view addSubview:noticelabel];
    [noticelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(emptyView.mas_bottom).offset(30*kiphone6);
        make.centerX.equalTo(emptyView);
    }];
}
-(void)setupUI{
    self.view.backgroundColor = [UIColor colorWithHexString:@"474d5b"];
    //标题背景btn
    UIButton *backBtn = [[UIButton alloc]init];
    backBtn.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    backBtn.layer.masksToBounds = true;
    backBtn.layer.cornerRadius = 4;
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(10*kiphone6);
        make.right.offset(-10*kiphone6);
        make.height.offset(70*kiphone6);
    }];
    [backBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *titleLabel = [UILabel labelWithText:self.medicinalTitleArr[0] andTextColor:[UIColor colorWithHexString:@"333333"] andFontSize:17];
    [backBtn addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(15*kiphone6);
    }];
    self.curruntMedicinalLabel = titleLabel;
    //
    headerTitleBtn *moreBtn = [[headerTitleBtn alloc]init];
    [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [moreBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [backBtn addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.offset(-15*kiphone6);
        make.width.offset(80*kiphone6);
    }];
    moreBtn.userInteractionEnabled = false;
    UIScrollView *scrollTrendView = [[UIScrollView alloc]init];
    YYMineMedicinalModel *medicinalModel = self.mineMedicineArr[0];
    scrollTrendView.contentSize = CGSizeMake(medicinalModel.boilMedicineList.count*kScreenW, kScreenH-80*kiphone6-64);
    scrollTrendView.pagingEnabled = YES;
    scrollTrendView.showsHorizontalScrollIndicator = NO;
    scrollTrendView.showsVerticalScrollIndicator = NO;
    scrollTrendView.bounces = NO;
    scrollTrendView.delegate = self;
    scrollTrendView.backgroundColor = [UIColor colorWithHexString:@"474d5b"];
    [self.view addSubview:scrollTrendView];
    scrollTrendView.contentOffset = CGPointMake(0, 0);
    scrollTrendView.frame = CGRectMake(0, 80*kiphone6, kScreenW, kScreenH-80*kiphone6-64);
    self.scrollTrendView = scrollTrendView;

    //药品状态
    //顶部line
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(kScreenW*0.5, 34*kiphone6, kScreenW*3, 2)];
    line.backgroundColor = [UIColor colorWithHexString:@"1bdeec"];
    [scrollTrendView addSubview:line];
    //底部view
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 425*kiphone6, kScreenW*4, kScreenH-505*kiphone6-64)];
    bottomView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    [scrollTrendView addSubview:bottomView];
    NSArray *numbersArr = @[@"step_1",@"step_2",@"step_3",@"step_4"];
    NSArray *titlesArr = @[@"准备药材中",@"配药已完成",@"中药熬制中",@"中药已熬制完成"];
    NSArray *picturesArr = @[@"picture1",@"picture2",@"picture3",@"picture4"];
    NSArray *instructionsArr = @[@"医务人员正在准备药材哦!",@"配药已完成,医务人员正在火速将药品送往熬药处哦!",@"熬制中药需要较长时间,请你耐心等候哦!",@"您的中药已熬好，请尽快到医院取药处取药！取药时间：早9：00~晚18：00"];
    for (int i = 0; i < 4; i++) {
        UIImageView *stepView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:numbersArr[i]]];
        [scrollTrendView addSubview:stepView];
        stepView.frame = CGRectMake(kScreenW*0.5-15*kiphone6+i*kScreenW, 20*kiphone6, 30*kiphone6, 30*kiphone6);
        UILabel *steplabel = [UILabel labelWithText:titlesArr[i] andTextColor:[UIColor colorWithHexString:@"1bdeec"] andFontSize:17];
        [scrollTrendView addSubview:steplabel];
        [steplabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(stepView.mas_bottom).offset(15*kiphone6);
            make.centerX.equalTo(stepView);
        }];
        UIImageView *picView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:picturesArr[i]]];
        [scrollTrendView addSubview:picView];
        picView.frame = CGRectMake(kScreenW*0.5-150*kiphone6+i*kScreenW, 100*kiphone6, 300*kiphone6, 300*kiphone6);
        //底部label
        UILabel *instructionLabel = [UILabel labelWithText:instructionsArr[i] andTextColor:[UIColor colorWithHexString:@"333333"] andFontSize:17];
        instructionLabel.numberOfLines = 0;
        instructionLabel.textAlignment = NSTextAlignmentCenter;
        [bottomView addSubview:instructionLabel];
        [instructionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bottomView.mas_centerY);
            make.centerX.equalTo(stepView);
            make.width.offset(300*kiphone6);
        }];
    }
    self.tableView.frame = CGRectMake(10*kiphone6, 80*kiphone6, kScreenW-20*kiphone6, 0);

}
//点击更多事件
-(void)moreBtnClick:(UIButton*)sender{
    if (self.tableView.frame.size.height>0) {
        [UIView animateWithDuration:0.5 animations:^{
            self.tableView.frame = CGRectMake(10*kiphone6, 80*kiphone6, kScreenW-20*kiphone6, 0);
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.tableView.frame = CGRectMake(10*kiphone6, 80*kiphone6, kScreenW-20*kiphone6, 45*kiphone6*self.mineMedicineArr.count);
        }];
    }
}
#pragma mark -
#pragma mark ------------TableView DataSource----------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.medicinalTitleArr.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45 *kiphone6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mineMedicineTVCell" forIndexPath:indexPath];
        cell.textLabel.text = self.medicinalTitleArr[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YYMineMedicinalModel *medicinalModel = self.mineMedicineArr[indexPath.row];
    _scrollTrendView.contentSize = CGSizeMake(medicinalModel.boilMedicineList.count*kScreenW, kScreenH-80*kiphone6-64);
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.frame = CGRectMake(10*kiphone6, 80*kiphone6, kScreenW-20*kiphone6, 0);
    }];
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
}

//设置导航栏高度适应
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = false;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = true;
    [SVProgressHUD dismiss];
}

@end
