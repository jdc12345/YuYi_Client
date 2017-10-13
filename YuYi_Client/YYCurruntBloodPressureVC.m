//
//  YYCurruntBloodPressureVC.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/9/22.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYCurruntBloodPressureVC.h"
#import "YYMemberTableViewCell.h"
#import "HttpClient.h"
#import "YYCardView.h"
#import "CcUserModel.h"
#import "YYHomeUserModel.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "YYFamilyAccountViewController.h"
#import "YYHandleMeasureViewController.h"
#import "UIBarButtonItem+Helper.h"
#import "UILabel+Addition.h"

@interface YYCurruntBloodPressureVC ()<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UIView *memberView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, weak) YYCardView *cardView;//头部cardview
@property (nonatomic, assign) NSInteger currentUser;

@end

@implementation YYCurruntBloodPressureVC

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    self.title = self.navTitle;
    [self httpRequestForUser];
    if ([self.title isEqualToString:@"当前血压"]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"手动输入" normalColor:[UIColor colorWithHexString:@"#333333"] highlightedColor:[UIColor colorWithHexString:@"#333333"] target:self action:@selector(addHanderInfo:)];
    }
    
}
//手动输入点击事件
-(void)addHanderInfo:(UIButton *)button{
    YYCurruntBloodPressureVC *autuMVC = [[YYCurruntBloodPressureVC alloc]init];
    autuMVC.navTitle = @"手动输入";
    [self.navigationController pushViewController:autuMVC animated:YES];

}
//请求用户数据
- (void)httpRequestForUser{
    [SVProgressHUD show];
    NSString *userToken = [CcUserModel defaultClient].userToken;
    [[HttpClient defaultClient]requestWithPath:[NSString stringWithFormat:@"%@%@",mHomeusers,userToken] method:0 parameters:nil prepareExecute:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"homeUsers = %@",responseObject);
        if ([responseObject[@"code"] isEqualToString:@"0"]) {
            NSArray *usersList = responseObject[@"result"];
            for (NSDictionary *dict in usersList) {
                YYHomeUserModel *homeUser = [YYHomeUserModel mj_objectWithKeyValues:dict];
                [self.dataSource addObject:homeUser];
                if (!self.cardView) {
                    [self createOtherView];
                }
            }
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}
//布局头部cardview
- (void)createOtherView{
    YYCardView *cardView = [[YYCardView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 167*kiphone6H)];
    [self.view addSubview:cardView];
    self.cardView = cardView;
    
    if ([self.title isEqualToString:@"当前血压"]) {
        NSString *highStr = @"141";
        NSString *lowStr = @"80";
        cardView.highPressureField.text = highStr;
        cardView.lowPressureField.text = lowStr;
//        NSInteger maxP = [dict_blood[@"systolic"] integerValue];//高压
//        NSInteger minP = [dict_blood[@"diastolic"] integerValue];//低压
//        NSInteger temp = [dict_temperature[@"temperaturet"] integerValue];//体温
//        if (temp>36&&temp<37.3&&maxP>90&&maxP<140&&minP>60&&minP<90){//正常
//            self.imageV.image = [UIImage imageNamed:@"data_normal"];
//        }else{//异常
//            self.imageV.image = [UIImage imageNamed:@"data_abnormal"];
//        }
        NSInteger maxP = [highStr integerValue];//高压
        NSInteger minP = [lowStr integerValue];//低压
        if (maxP>90&&maxP<140&&minP>60&&minP<90){//正常
            cardView.resultLabel.text = @"*当前血压正常";
            cardView.resultLabel.textColor = [UIColor colorWithHexString:@"56f29f"];
        }else if (maxP<90){//高压偏低
            cardView.resultLabel.text = @"*当前血压高压偏低";
            cardView.resultLabel.textColor = [UIColor redColor];
        }else if (minP<60){//低压偏低
            cardView.resultLabel.text = @"*当前血压低压偏低";
            cardView.resultLabel.textColor = [UIColor redColor];
        }else if (maxP>140){//高压偏高
            cardView.resultLabel.text = @"*当前血压高压偏高";
            cardView.resultLabel.textColor = [UIColor redColor];
        }else if (minP>90){//低压偏高
            cardView.resultLabel.text = @"*当前血压低压偏高";
            cardView.resultLabel.textColor = [UIColor redColor];
        }
    }else{//手动输入(在代理方法中监听血压数值来改变文字颜色)
        cardView.highPressureField.delegate = self;
        cardView.lowPressureField.delegate = self;
    }
    //添加“数据录入”“保存”按钮以及tableview的背景memberView
    self.memberView  = [[UIView alloc] init];
    self.memberView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.memberView];
    [self.memberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardView.mas_bottom);
        make.left.right.bottom.offset(0);
    }];
    
    [self createMemberView];
}
//布局memberView
- (void)createMemberView{
    UIView *header = [[UIView alloc]init];
    header.backgroundColor = [UIColor whiteColor];
    //数据录入label
    UILabel *headerLabel = [UILabel labelWithText:@"数据录入" andTextColor:[UIColor colorWithHexString:@"333333"] andFontSize:15];
    [self.memberView addSubview:headerLabel];
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10*kiphone6);
        make.centerY.equalTo(self.memberView.mas_top).offset(24.5*kiphone6H);
    }];
    //tableview
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView registerClass:[YYMemberTableViewCell class] forCellReuseIdentifier:@"YYMemberTableViewCell"];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.memberView addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(49*kiphone6H);
        make.left.right.offset(0);
        make.bottom.offset(-124*kiphone6H);
    }];
    //保存btn
    UIButton *sureBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    sureBtn.layer.cornerRadius = 3;
    sureBtn.layer.masksToBounds = true;
    [sureBtn setTitle:@"保存" forState:UIControlStateNormal];
    sureBtn.backgroundColor = [UIColor colorWithHexString:@"1ebeec"];
    [sureBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.memberView addSubview:sureBtn];

    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-40 *kiphone6H);
        make.left.offset(10*kiphone6);
        make.right.offset(-10*kiphone6);
        make.height.offset(44*kiphone6H);
    }];
    
}
#pragma - UItextdelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

{  //string就是此时输入的那个字符 textField就是此时正在输入的那个输入框 返回YES就是可以改变输入框的值 NO相反
    if ([string isEqualToString:@"\n"])  //按会车可以改变
    {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (toBeString.length>3) {//限制长度
        return NO;
    }
    if (self.cardView.highPressureField.text.length == 0 || self.cardView.lowPressureField.text.length == 0){
        self.cardView.resultLabel.text = @"*当前数据为空";
        self.cardView.resultLabel.textColor = [UIColor colorWithHexString:@"1ebeec"];
        
    }else{//有数据
        NSInteger maxP = [self.cardView.highPressureField.text integerValue];//高压
        NSInteger minP = [self.cardView.lowPressureField.text integerValue];//低压
        if (self.cardView.highPressureField == textField) {
            maxP = [toBeString integerValue];//高压
        }
        if (self.cardView.lowPressureField == textField) {
            minP = [toBeString integerValue];//低压
        }
        if (maxP>90&&maxP<140&&minP>60&&minP<90){//正常
            self.cardView.resultLabel.text = @"*当前血压正常";
            self.cardView.resultLabel.textColor = [UIColor colorWithHexString:@"56f29f"];
        }else if (maxP<90){//高压偏低
            self.cardView.resultLabel.text = @"*当前血压高压偏低";
            self.cardView.resultLabel.textColor = [UIColor redColor];
        }else if (minP<60){//低压偏低
            self.cardView.resultLabel.text = @"*当前血压低压偏低";
            self.cardView.resultLabel.textColor = [UIColor redColor];
        }else if (maxP>140){//高压偏高
            self.cardView.resultLabel.text = @"*当前血压高压偏高";
            self.cardView.resultLabel.textColor = [UIColor redColor];
        }else if (minP>90){//低压偏高
            self.cardView.resultLabel.text = @"*当前血压低压偏高";
            self.cardView.resultLabel.textColor = [UIColor redColor];
        }
        
    }
    return YES;
    
}

#pragma mark -
#pragma mark ------------TableView Delegate----------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.dataSource.count) {
        YYFamilyAccountViewController *familyAVC = [[YYFamilyAccountViewController alloc]init];
        [self.navigationController pushViewController:familyAVC animated:YES];
    }else{
        self.currentUser = indexPath.row;
    }
}
#pragma mark -
#pragma mark ------------TableView DataSource----------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count +1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60 *kiphone6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YYMemberTableViewCell *homeTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"YYMemberTableViewCell" forIndexPath:indexPath];
    
    if (indexPath.row == self.dataSource.count) {
        homeTableViewCell.iconV.image = [UIImage imageNamed:@"add_member"];
        homeTableViewCell.titleLabel.text = @"添加人员";
        homeTableViewCell.titleLabel.textColor = [UIColor colorWithHexString:@"c7c5c5"];
    }else{
        homeTableViewCell.titleLabel.highlightedTextColor = [UIColor whiteColor];
        homeTableViewCell.selectedBackgroundView = [[UIView alloc] initWithFrame:homeTableViewCell.frame] ;
        homeTableViewCell.selectedBackgroundView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
        
        YYHomeUserModel *homeUser = self.dataSource[indexPath.row];
        homeTableViewCell.titleLabel.text = homeUser.trueName;
        [homeTableViewCell.iconV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mPrefixUrl,homeUser.avatar]]];
    }
    return homeTableViewCell;
    
}

//保存按钮点击事件
-(void)buttonClick:(UIButton *)button{
    [self httpRequest];
    
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
- (void)httpRequest{
    NSString *urlStr ;
    NSDictionary *parametersDict;
    
    // token
    NSString *usertoken = [CcUserModel defaultClient].userToken;
    // humeuserId
    NSInteger current = self.currentUser;
    YYHomeUserModel *homeUser = self.dataSource[current];
    NSLog(@"%@,%@,%@,%@",usertoken,homeUser.info_id,self.cardView.highPressureField.text,self.cardView.lowPressureField.text);
    if (self.cardView.highPressureField.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入高压"];
        return;
    }
    if (self.cardView.lowPressureField.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入低压"];
        return;
    }
    urlStr = mBloodpressure;
    parametersDict = @{@"token":usertoken,
                       @"humeuserId":homeUser.info_id,
                       @"systolic":self.cardView.highPressureField.text,
                       @"diastolic":self.cardView.lowPressureField.text
                       };
    NSLog(@"参数：　%@",parametersDict);
    
    [[HttpClient defaultClient]requestWithPath:urlStr method:1 parameters:parametersDict prepareExecute:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma mark ------------view appear----------------------

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = false;

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = true;
    
}

@end
