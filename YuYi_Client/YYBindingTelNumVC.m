//
//  YYBindingTelNumVC.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/9/28.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYBindingTelNumVC.h"
#import "UILabel+Addition.h"
#import "HttpClient.h"
#import "CcUserModel.h"
#import "UIBarButtonItem+Helper.h"

@interface YYBindingTelNumVC ()<UITextFieldDelegate>
@property(nonatomic,weak)UITextField *telNumberField;

@property(nonatomic,weak)UITextField *passWordField;
@end

@implementation YYBindingTelNumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定手机号";
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" normalColor:[UIColor colorWithHexString:@"1ebeec"] highlightedColor:[UIColor colorWithHexString:@"1ebeec"] target:self action:@selector(changeTelNum)];
    [self setupUI];
}
-(void)setupUI{
    //添加输入区域背景
    UIView *inputView = [[UIView alloc]initWithFrame:CGRectMake(0, 74*kiphone6H, kScreenW, kScreenH-10*kiphone6H)];
    inputView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:inputView];
//    [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.offset(10*kiphone6H);
//        make.left.right.bottom.offset(0);
//    }];
    //添加当前绑定手机号label
    CcUserModel *model = [CcUserModel defaultClient];
    UILabel *curruntTelNumLabel = [UILabel labelWithText:[NSString stringWithFormat:@"当前绑定手机号：%@",model.telephoneNum] andTextColor:[UIColor colorWithHexString:@"333333"] andFontSize:14];
    [inputView addSubview:curruntTelNumLabel];
    [curruntTelNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(inputView.mas_top).offset(30*kiphone6H);
        make.left.offset(15*kiphone6);
    }];
    //添加修改绑定label背景
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    [inputView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(60*kiphone6H);
        make.height.offset(40*kiphone6H);
    }];
    //添加修改绑定label
    UILabel *bindingLabel = [UILabel labelWithText:@"修改绑定" andTextColor:[UIColor colorWithHexString:@"6a6a6a"] andFontSize:13];
    [inputView addSubview:bindingLabel];
    [bindingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15*kiphone6);
        make.centerY.equalTo(backView);
    }];
    //添加电话label
    UILabel *telNumLabel = [UILabel labelWithText:@"填写新手机号" andTextColor:[UIColor colorWithHexString:@"666666"] andFontSize:14];
    [inputView addSubview:telNumLabel];
    [telNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15*kiphone6);
        make.top.equalTo(backView.mas_bottom).offset(30*kiphone6H);
        make.width.offset(90);
    }];
    
    //添加电话textField
    UITextField *telNumberField = [[UITextField alloc]init];
    telNumberField.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
    telNumberField.layer.borderWidth = 1;
    telNumberField.layer.cornerRadius = 5;
    telNumberField.layer.masksToBounds = true;
    telNumberField.placeholder = @"请输入电话号码";
    //设置左边视图的宽度
    telNumberField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    //设置显示模式为永远显示(默认不显示 必须设置 否则没有效果)
    telNumberField.leftViewMode = UITextFieldViewModeAlways;
    telNumberField.font = [UIFont systemFontOfSize:14];
    telNumberField.textColor = [UIColor colorWithHexString:@"333333"];
    telNumberField.keyboardType = UIKeyboardTypeNumberPad;//设置键盘的样式
    [inputView addSubview:telNumberField];
    [telNumberField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(telNumLabel.mas_right).offset(10*kiphone6);
        make.centerY.equalTo(telNumLabel);
        make.right.offset(-15*kiphone6);
        make.height.offset(30*kiphone6H);
    }];
    self.telNumberField = telNumberField;
    telNumberField.delegate = self;
    
    //添加获取验证码Btn
    UIButton *getCodeBtn = [[UIButton alloc]init];
    getCodeBtn.layer.masksToBounds = true;
    getCodeBtn.layer.cornerRadius = 2;
    [getCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [getCodeBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [getCodeBtn setBackgroundColor:[UIColor colorWithHexString:@"#1ebeec"]];
    getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [inputView addSubview:getCodeBtn];
    [getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15*kiphone6);
        make.top.equalTo(telNumberField.mas_bottom).offset(20*kiphone6H);
        make.width.offset(100*kiphone6);
        make.height.offset(30*kiphone6H);
    }];
    //点击事件
    [getCodeBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    //添加密码textField
    UITextField *passWordField = [[UITextField alloc]init];
    passWordField.layer.borderColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
    passWordField.layer.borderWidth = 1;
    passWordField.layer.cornerRadius = 2;
    passWordField.layer.masksToBounds = true;
    passWordField.font = [UIFont systemFontOfSize:14];
    passWordField.textColor = [UIColor colorWithHexString:@"333333"];
    passWordField.placeholder = @"请输入验证码";
    //设置左边视图的宽度
    passWordField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    //设置显示模式为永远显示(默认不显示 必须设置 否则没有效果)
    passWordField.leftViewMode = UITextFieldViewModeAlways;
    passWordField.keyboardType = UIKeyboardTypeNumberPad;//设置键盘的样式
    [inputView addSubview:passWordField];
    [passWordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(telNumberField);
        make.right.equalTo(getCodeBtn.mas_left);
        make.top.equalTo(telNumberField.mas_bottom).offset(20*kiphone6H);
        make.height.offset(30*kiphone6H);
    }];
    self.passWordField = passWordField;
    //添加验证码label
    UILabel *codeNumLabel = [UILabel labelWithText:@"填 写 验 证 码" andTextColor:[UIColor colorWithHexString:@"666666"] andFontSize:14];
    [inputView addSubview:codeNumLabel];
    [codeNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15*kiphone6);
        make.centerY.equalTo(passWordField);
    }];
    
    
//    //添加选择按钮
//    UIButton *selectBtn = [[UIButton alloc]init];
//    [selectBtn setImage:[UIImage imageNamed:@"logo_selected"] forState:UIControlStateNormal];
//    [self.view addSubview:selectBtn];
//    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(inputView.mas_bottom).offset(15*kiphone6);
//        make.centerY.equalTo(curruntTelNumLabel);
//        make.right.equalTo(curruntTelNumLabel.mas_left).offset(-5*kiphone6);
//    }];
//    //添加登录Btn
//    UIButton *logInBtn = [[UIButton alloc]init];
//    logInBtn.layer.masksToBounds = true;
//    logInBtn.layer.cornerRadius = 20;
//    [logInBtn setTitle:@"登录" forState:UIControlStateNormal];
//    [logInBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
//    logInBtn.titleLabel.font = [UIFont systemFontOfSize:18];
//    [logInBtn setBackgroundColor:[UIColor colorWithHexString:@"#1ebeec"]];
//    [self.view addSubview:logInBtn];
//    [logInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.top.equalTo(curruntTelNumLabel.mas_bottom).offset(40*kiphone6);
//        make.width.offset(325*kiphone6);
//        make.height.offset(44*kiphone6);
//    }];
//    //点击事件
//    [logInBtn addTarget:self action:@selector(logIn:) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(event:)];
    //将手势添加至需要相应的view中
    [self.view addGestureRecognizer:tapGesture];
}
//执行手势触发的方法：
- (void)event:(UITapGestureRecognizer *)gesture
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];//取消键盘
    
    
    
}
-(void)buttonClick:(UIButton *)button{
    if (![self valiMobile:self.telNumberField.text]) {
        [SVProgressHUD showInfoWithStatus:@"请确认电话号码是否输入正确"];
        return;
    }
    
    //发送获取验证码请求
    NSString *urlString = [NSString stringWithFormat:@"%@/personal/vcode.do?id=%@",mPrefixUrl,self.telNumberField.text];
    HttpClient *httpManager = [HttpClient defaultClient];
    
    [httpManager requestWithPath:urlString method:HttpRequestPost parameters:nil prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *getCodeDic = (NSDictionary*)responseObject;
        if ([getCodeDic[@"code"] isEqualToString:@"0"]) {
            //倒计时时间
            __block NSInteger timeOut = 59;
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            //每秒执行一次
            dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
            dispatch_source_set_event_handler(_timer, ^{
                
                //倒计时结束，关闭
                if (timeOut <= 0) {
                    dispatch_source_cancel(_timer);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [button setBackgroundColor:[UIColor colorWithHexString:@"#1ebeec"]];
                        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        [button setTitle:@"发送验证码" forState:UIControlStateNormal];
                        button.userInteractionEnabled = true;
                    });
                } else {
                    int allTime = 60;
                    int seconds = timeOut % allTime;
                    NSString *timeStr = [NSString stringWithFormat:@"%0.2d", seconds];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [button setBackgroundColor:[UIColor colorWithHexString:@"#cccccc"]];
                        [button setTitle:[NSString stringWithFormat:@"%@ S",timeStr] forState:UIControlStateNormal];
                        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                        button.userInteractionEnabled = false;
                    });
                    timeOut--;
                }
            });
            dispatch_resume(_timer);
            
        }else{
            [SVProgressHUD showInfoWithStatus:@"请确认电话号码正确以及网络是否正常"];
            self.telNumberField.text = nil;
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        return;
    }];
    
}
//判断手机号码格式是否正确
- (BOOL)valiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}
-(void)changeTelNum{
    [SVProgressHUD show];
        //保存token
        CcUserModel *userModel = [CcUserModel defaultClient];
        NSString *urlString = [NSString stringWithFormat:@"%@/personal/modifymobile.do?newMobile=%@&vcode=%@&token=%@",mPrefixUrl,self.telNumberField.text,self.passWordField.text,userModel.userToken];
        HttpClient *httpManager = [HttpClient defaultClient];
        [httpManager requestWithPath:urlString method:HttpRequestPost parameters:nil prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            [SVProgressHUD dismiss];
            NSDictionary *dic = (NSDictionary *)responseObject;
            if ([dic[@"code"] isEqualToString:@"0"]) {
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                userModel.userToken = dic[@"result"];
                userModel.telephoneNum = self.telNumberField.text;
                [userModel saveAllInfo];
            }

        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [SVProgressHUD dismiss];
            return ;
        }];
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
