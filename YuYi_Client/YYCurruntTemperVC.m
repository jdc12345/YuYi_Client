//
//  YYCurruntTemperVC.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/9/24.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYCurruntTemperVC.h"
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

static float transY = 0.f;//滑块移动总值

static float temp = 32.00f;//开始滑动时候温度初始值

@interface YYCurruntTemperVC ()<UITableViewDelegate,UITextFieldDelegate,HealthMeasureApiDelegate>
{
    HealthMeasureApi *_healthMeaApi;//api实例
    
}
@property (nonatomic, strong) UIView *memberView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, weak) YYCardView *cardView;//头部cardview
@property (nonatomic, assign) NSInteger currentUser;

@property (nonatomic, strong) UILabel *displayLabel;//显示体温label
@property (nonatomic, strong) UILabel *resultLabel;//显示体温总结
//刻度范围
@property(nonatomic)float fw;
@property (nonatomic, assign) BOOL isFull;//是否达到最多的六个人
@property (nonatomic, strong) YYHomeUserModel *curruntUserModel;//当前用户数据
@property (nonatomic, strong) UIImageView *curruntMemberImg;//当前用户Img
@property (nonatomic, strong) UIButton *nameBtn;//显示当前用户名字按钮(三角)
@property (nonatomic, strong) UIView *bottomView;//底部显示用户列表背景
@property (nonatomic, assign) NSInteger state;//手机蓝牙状态
@property (nonatomic, weak) UIImageView *sliderImage;//温度指示滑块
@property (nonatomic, weak) UIImageView *tempImage;//温度计底图
@end

@implementation YYCurruntTemperVC
- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.navTitle;
    self.view.backgroundColor = [UIColor colorWithHexString:@"474d5b"];
    [self httpRequestForUser];
    if ([self.title isEqualToString:@"当前体温"]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"手动输入" normalColor:[UIColor colorWithHexString:@"#333333"] highlightedColor:[UIColor colorWithHexString:@"#333333"] target:self action:@selector(addHanderInfo:)];
    }
    //测量血压仪和温度计
    //测量血压仪
    /**
     BTTYPEBLOODPRE,//血压计
     BTTYPEBLOODSUGER,//血糖仪
     BTTYPEHUMANSCALE, //人体秤
     BTTYPEFATSCALE, //脂肪秤
     BTTYPEURICACID,//尿酸
     BTTYPECHOL,//血脂
     BTTYPETPT,//额温
     BTTYPEALL   //所有设备
     **/
    
    //        if ((_type == BTTYPEHUMANSCALE)||(_type == BTTYPEFATSCALE)) {//测量体重需要的参数
    //            [JkezApiInit setApiUserDataWithHeight:195 sex:0 age:27];
    //        }
    _type = BTTYPETPT;//额温
    _healthMeaApi = [HealthMeasureApi healthMeasureWithType:_type];
    _healthMeaApi.healthMeasureDelegate = self;
}
//手机蓝牙状态
-(void)healthMeasureBlueToothState:(BTSTATE)state {
    NSLog(@"MeasureDemostate %d",state);
    _state = state;
}

//获取测量设备蓝牙名称
-(void)healthMeasureBlueToothName:(NSString *)name Mac:(NSString *)mac {
    NSLog(@"MeasureDemoBTName: %@",name);
    //    _contentLable.text = name;
}

//连接成功
-(void)healthMeasureConnectSuccess {
    NSLog(@"MeasureDemoSuccess");
    self.resultLabel.text = @"设备连接成功，请开始测量";
}

//监听设备断开
-(void)healthMeasureDisconnect {
    self.resultLabel.text = @"设备已经断开";
    //    _contentLable.text = @"设备已经断开";
    //    count = 0;
}

//返回有效值
-(void)healthMeasureWithType:(BTMEASURETYTE)type state:(HEALTHMEAUSRESTATE)state data:(id)data {
    NSLog(@"MeasureDemo:state: %d,type:%d",state,type);
    
    if(type == BTTYPETPT) {
        TptApiData *tptdata = (TptApiData *)data;
        if (NOMAL == state) {//体温计直接获取到数据
            self.displayLabel.text = [NSString stringWithFormat:@"%.1f ℃",tptdata.temperature];
            self.resultLabel.text = [NSString stringWithFormat:@"体温:%.1f ℃",tptdata.temperature];
            CGFloat distance = (tptdata.temperature-32.0f)/0.2*4.9;
            if (distance>0 && distance<=245) {//在可能出现的范围
                [self.sliderImage mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.tempImage.mas_bottom).offset(-103- distance);
                }];
            }else if(distance>245){//测量体温超过42度
                [self.sliderImage mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(self.tempImage.mas_bottom).offset(-103- 250);
                }];
            }
        }else if(ERROR == state) {
            self.displayLabel.text = @"异常";
            self.resultLabel.text = [NSString stringWithFormat:@"异常:%@",tptdata.err];
        }
    }
}

//-------------------------华丽的分割线----------------------------------

//手动输入点击事件
-(void)addHanderInfo:(UIButton *)button{
    YYCurruntTemperVC *autuMVC = [[YYCurruntTemperVC alloc]init];
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
        }
        if (self.dataSource.count == 6) {
            self.isFull = YES;
        }else{
            self.isFull = NO;
        }
        YYHomeUserModel *userModel;
        if (self.dataSource.count >0&&!self.curruntUserModel){//第一次加载
            userModel = self.dataSource[0];
            self.curruntUserModel = userModel;
        }else if(self.dataSource.count >0&&self.curruntUserModel){//刷新
            for (YYHomeUserModel *uModel in self.dataSource) {
                if ([uModel.info_id isEqualToString:self.curruntUserModel.info_id]) {
                    userModel = self.curruntUserModel;
                }
            }
        }
        [self setUpUI];
        [self.tableView reloadData];
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
       [SVProgressHUD dismiss]; 
    }];
}

- (void)setUpUI {
    //保存btn
    UIButton *sureBtn = [[UIButton  alloc]init];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"button_temp"] forState:UIControlStateNormal];
    [sureBtn setTitle:@"保存" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(30*kiphone6H);
    }];
    //显示体温label
    UILabel *displayLabel = [UILabel labelWithText:@"等待连接设备，请按下设备启动按钮" andTextColor:[UIColor colorWithHexString:@"1ebeec"] andFontSize:40];
    [self.view addSubview:displayLabel];
    [displayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(30*kiphone6H);
    }];
    
    //显示体温结果总结label
    
    NSString *result = @"*当前数据为空";
    UILabel *resultLabel = [UILabel labelWithText:result andTextColor:[UIColor colorWithHexString:@"1ebeec"] andFontSize:15];
    [self.view addSubview:resultLabel];
    [resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(displayLabel.mas_bottom);
    }];
    NSString *curruntTemper;
    if ([self.title isEqualToString:@"当前体温"]) {
        curruntTemper = @"";
        displayLabel.text = @"等待测量";
        resultLabel.text = @"等待连接设备，请按下设备启动按钮";
    }else{
        curruntTemper = @"0";
        displayLabel.text = @"等待输入";
    }
    float tempC = [curruntTemper floatValue];//体温
//    if (tempC == 0) {
//        resultLabel.text = @"*当前数据为空";
//        displayLabel.textColor = [UIColor colorWithHexString:@"1ebeec"];
//        resultLabel.textColor = [UIColor colorWithHexString:@"1ebeec"];
//    }else if (tempC > 32 && tempC < 36){
//        resultLabel.text = @"*当前体温过低,请查看测量部位";
//        displayLabel.textColor = [UIColor colorWithHexString:@"1ebeec"];
//        resultLabel.textColor = [UIColor colorWithHexString:@"1ebeec"];
//    }else if (tempC >= 36 && tempC < 37){
//        resultLabel.text = @"*当前体温正常";
//        displayLabel.textColor = [UIColor colorWithHexString:@"f654f5"];
//        resultLabel.textColor = [UIColor colorWithHexString:@"f654f5"];
//    }else if (tempC >= 37 && tempC <= 42){
//        resultLabel.text = @"*当前体温过高,请尽快就医";
//        displayLabel.textColor = [UIColor colorWithHexString:@"f6547a"];
//        resultLabel.textColor = [UIColor colorWithHexString:@"f6547a"];
//    }else{
//        resultLabel.text = @"*体温测量结果不符合实际，请重新测量";
//        displayLabel.textColor = [UIColor colorWithHexString:@"f6547a"];
//        resultLabel.textColor = [UIColor colorWithHexString:@"f6547a"];
//    }
    self.displayLabel = displayLabel;
    self.resultLabel = resultLabel;
    //温度计
    UIImageView *tempImage = [[UIImageView alloc]init];
    tempImage.image = [UIImage imageNamed:@"Thermometer"];
    [self.view addSubview:tempImage];
    [tempImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(resultLabel.mas_bottom);
    }];
    tempImage.userInteractionEnabled = true;
    self.tempImage = tempImage;
    _fw = 42.0f;//最高42度。1刻度代表0.2度。1刻度长4.9
    for(int i=0;i<=50;i++){
        if(i%5==0){
            UILabel *labelleaf = [[UILabel alloc]initWithFrame:CGRectMake(15, 4.9*i+52,20, 15)];
            labelleaf.textColor = [UIColor colorWithHexString:@"ffffff"];
            NSString *z = [NSString stringWithFormat:@"%.0f",_fw-i*0.2];
            if(_fw-i*0.2==36 || _fw-i*0.2==37){
                labelleaf.textColor = [UIColor greenColor];
            }
            labelleaf.text = z;
            labelleaf.font =[UIFont systemFontOfSize:10];
            labelleaf.textAlignment = 1;
            [tempImage addSubview:labelleaf];
        }
    }
    //滑块
    UIImageView *sliderImage = [[UIImageView alloc]init];
    sliderImage.image = [UIImage imageNamed:@"slider_temp"];
    [tempImage addSubview:sliderImage];
    [sliderImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.equalTo(tempImage.mas_bottom).offset(-103);
    }];
    sliderImage.userInteractionEnabled = true;
    self.sliderImage = sliderImage;
    if ([self.title isEqualToString:@"手动输入"]) {
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        [sliderImage addGestureRecognizer:panGestureRecognizer];
    }else{//确定当前体温的滑块位置
        CGFloat distance = (tempC-32.0f)/0.2*4.9;
        if (distance>0 && distance<=245) {//在可能出现的范围
            [sliderImage mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(tempImage.mas_bottom).offset(-103- distance);
            }];
        }else if(distance>245){//测量体温超过42度
            [sliderImage mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(tempImage.mas_bottom).offset(-103- 250);
            }];
        }
    }
    //底部用户列表
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(tempImage.mas_bottom).offset(17.5*kiphone6H);
    }];
    self.bottomView = bottomView;

    if (self.dataSource.count < 6) {
        YYHomeUserModel *addModel = [[YYHomeUserModel alloc]init];
        addModel.avatar = @"temper_member_add";
        addModel.trueName = @"";
        [self.dataSource addObject:addModel];
    }
    for (int i = 0; i < self.dataSource.count; i++) {
        YYHomeUserModel *userModel = self.dataSource[i];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mPrefixUrl,userModel.avatar]];
        
        // icon
        
        UIImageView *userImage = [[UIImageView alloc]init];
        userImage.userInteractionEnabled = YES;
        userImage.tag = 140 +i;
        
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeUserData:)];
        
        [userImage addGestureRecognizer:tapGest];
        if (i == self.dataSource.count -1 && !self.isFull) {//加号按钮
            userImage.image = [UIImage  imageNamed:userModel.avatar];
        }else{
            [userImage sd_setImageWithURL:url];
            userImage.layer.borderWidth = 1;
            userImage.layer.borderColor = [UIColor colorWithHexString:@"d7cbfd"].CGColor;
        }
        userImage.layer.cornerRadius = 45/2.0;
        userImage.clipsToBounds = YES;
        
        [bottomView addSubview:userImage];
        if (i == 0) {
            self.curruntMemberImg = userImage;//首次显示的用户
        }
        CGFloat x_padding = 10+(45+18.5)*i;
        [userImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.offset(x_padding);
            make.size.mas_equalTo(CGSizeMake(45, 45));
        }];
    }
    UIButton *nameBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    [self.view addSubview:nameBtn];
    [nameBtn setImage:[UIImage imageNamed:@"triangle_temper"] forState:UIControlStateNormal];
    [nameBtn setTitle:self.curruntUserModel.trueName forState:UIControlStateNormal];
    [nameBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    nameBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [nameBtn setBackgroundColor:[UIColor clearColor]];
    CGSize imageSize = nameBtn.imageView.frame.size;
    CGSize titleSize = nameBtn.titleLabel.frame.size;
    nameBtn.titleEdgeInsets = UIEdgeInsetsMake(-imageSize.height - 5, -imageSize.width, 0, 0);
    nameBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, -titleSize.height-5, -titleSize.width);

    [nameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomView.mas_top);
        make.centerX.equalTo(self.curruntMemberImg.mas_centerX).offset(14*kiphone6);
        make.height.offset(28*kiphone6H);
    }];
    self.nameBtn = nameBtn;
    
    //根据手机蓝牙状态提示用户
    switch (_state) {
        case BTSTATEUNSUPPORTED:
            [SVProgressHUD showInfoWithStatus:@"该手机蓝牙不支持"];
            [SVProgressHUD dismissWithDelay:2.0f];
            break;
        case BTSTATEUNAUTHORIZED:
            [SVProgressHUD showInfoWithStatus:@"该手机未授权"];
            [SVProgressHUD dismissWithDelay:2.0f];
            break;
        case BTSTATEPOWEREDOFF:
            [SVProgressHUD showInfoWithStatus:@"尚未打开蓝牙,请在设置中打开"];
            [SVProgressHUD dismissWithDelay:2.0f];
            break;
        case BTSTATEOTHER:
            [SVProgressHUD showInfoWithStatus:@"该手机蓝牙处于异常状态"];
            [SVProgressHUD dismissWithDelay:2.0f];
            break;
            
        default:
            break;
    }

}
//点击用户头像手势事件
- (void)changeUserData:(UITapGestureRecognizer *)tapGest{
    
    NSInteger imageTag = (tapGest.view.tag+10);
    if(imageTag == 149 +self.dataSource.count &&!self.isFull){//点击的是添加按钮
        YYFamilyAccountViewController *familyAVC = [[YYFamilyAccountViewController alloc]init];
        [self.navigationController pushViewController:familyAVC animated:YES];
    }else{
        UIImageView *curImage = (UIImageView *)[self.bottomView viewWithTag:imageTag];
        self.curruntMemberImg = curImage;
        self.curruntUserModel = self.dataSource[tapGest.view.tag-140];
        [self.nameBtn setTitle:self.curruntUserModel.trueName forState:UIControlStateNormal];
        [self.nameBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.bottomView.mas_top);
            make.left.offset(10+(45+18.5)*(tapGest.view.tag-140));
//            make.centerX.equalTo(self.curruntMemberImg.mas_centerX).offset(14*kiphone6);
            make.height.offset(28*kiphone6H);
        }];
    }
}
//最高42度。1刻度代表0.2度。1刻度长4.9
- (void) handlePan:(UIPanGestureRecognizer*) recognizer
{
   CGPoint translation = [recognizer translationInView:self.view];
    if (translation.y<0 && translation.y+transY>-245) {//向上拖动
        recognizer.view.center = CGPointMake(recognizer.view.center.x,
                                             recognizer.view.center.y + translation.y);
        transY+=translation.y;//滑块已经移动的距离
        temp += -translation.y/4.9*0.2;//温度成比例的变动
    }
    if (transY<0 && translation.y>0 && translation.y<-transY) {//向下拖动
        recognizer.view.center = CGPointMake(recognizer.view.center.x,
                                             recognizer.view.center.y + translation.y);
        transY+=translation.y;//滑块已经移动的距离
        temp += -translation.y/4.9*0.2;//温度成比例的变动
    }
    NSLog(@"%.f,------->%.f",translation.y,temp);
    [recognizer setTranslation:CGPointZero inView:self.view];
    if (temp == 0) {
        _displayLabel.text = [NSString stringWithFormat:@"%.1f℃",temp];
        _resultLabel.text = @"*当前数据为空";
        _displayLabel.textColor = [UIColor colorWithHexString:@"1ebeec"];
        _resultLabel.textColor = [UIColor colorWithHexString:@"1ebeec"];
    }else if (temp > 0 && temp < 36){
        _displayLabel.text = [NSString stringWithFormat:@"%.1f℃",temp];
        _resultLabel.text = @"*当前体温过低,请查看测量部位";
        _displayLabel.textColor = [UIColor colorWithHexString:@"1ebeec"];
        _resultLabel.textColor = [UIColor colorWithHexString:@"1ebeec"];
    }else if (temp >= 36 && temp < 37){
        _displayLabel.text = [NSString stringWithFormat:@"%.1f℃",temp];
        _resultLabel.text = @"*当前体温正常";
        _displayLabel.textColor = [UIColor colorWithHexString:@"f654f5"];
        _resultLabel.textColor = [UIColor colorWithHexString:@"f654f5"];
    }else if (temp >= 37){
        _displayLabel.text = [NSString stringWithFormat:@"%.1f℃",temp];
        _resultLabel.text = @"*当前体温过高,请尽快就医";
        _displayLabel.textColor = [UIColor colorWithHexString:@"f6547a"];
        _resultLabel.textColor = [UIColor colorWithHexString:@"f6547a"];
    }
}
//保存按钮点击事件
-(void)buttonClick:(UIButton *)button{
    [self httpRequest];
    
}
- (void)httpRequest{
    NSString *urlStr ;
    NSDictionary *parametersDict;
    
    // token
    NSString *usertoken = [CcUserModel defaultClient].userToken;
    // humeuserId
    YYHomeUserModel *homeUser = self.curruntUserModel;
    NSString *temper;
    if (![self.displayLabel.text containsString:@"℃"]) {
        [SVProgressHUD showInfoWithStatus:@"请测量或者滑动输入体温"];
        return;
    }else{
        NSRange range = [self.displayLabel.text rangeOfString:@"℃"];
        temper = [self.displayLabel.text substringToIndex:range.location];
    }
    
    if ([temper isEqualToString:@"0"]) {
        [SVProgressHUD showInfoWithStatus:@"请输入体温"];
        return;
    }
    urlStr = mTemperature;
    parametersDict = @{@"token":usertoken,
                       @"humeuserId":homeUser.info_id,
                       @"temperaturet":temper
                       };
    NSLog(@"参数：　%@",parametersDict);
    
    [[HttpClient defaultClient]requestWithPath:urlStr method:1 parameters:parametersDict prepareExecute:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"保存失败"];
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
    [_healthMeaApi disconnect];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    BOOL success = [_healthMeaApi connectWithDelegate:self];
    if (!success) {
        NSLog(@"请检查APPKEY");
        [SVProgressHUD showWithStatus:@"设备连接失败，请重试"];
    }
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
