//
//  YYLogInVC.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/3/2.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYLogInVC.h"
#import "UIColor+colorValues.h"
#import <Masonry.h>
#import "UILabel+Addition.h"
#import "YYTabBarController.h"
#import "HttpClient.h"
#import "YYHTTPSHOPConst.h"
#import "CcUserModel.h"

@interface YYLogInVC ()<UITextFieldDelegate>
@property(nonatomic,weak)UILabel *countdownLabel;

@property(nonatomic,weak)UITextField *telNumberField;

@property(nonatomic,weak)UITextField *passWordField;

@end

@implementation YYLogInVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    [self setupUI];
}
-(void)setupUI{
    //添加log图片
    UIImageView *logImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
    [self.view addSubview:logImageView];
    [logImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.offset(130);
        make.width.height.offset(125);
    }];
    
    //添加line1
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(logImageView.mas_bottom).offset(60);
        make.width.offset(225);
        make.height.offset(0.5);
    }];
    //添加电话imageView图标
    UIImageView *telImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_phone_icon"]];
    [self.view addSubview:telImageView];
    [telImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line1.mas_left);
        make.bottom.equalTo(line1.mas_top).offset(-7.5);
        make.width.height.offset(17);
    }];
    //添加电话textField
    UITextField *telNumberField = [[UITextField alloc]init];
    telNumberField.placeholder = @"请输入电话号码";
    telNumberField.keyboardType = UIKeyboardTypeNumberPad;//设置键盘的样式
    [self.view addSubview:telNumberField];
    [telNumberField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(telImageView.mas_right).offset(15);
        make.bottom.equalTo(line1.mas_top).offset(-7.5);
        make.width.offset(122);
    }];
    self.telNumberField = telNumberField;
    telNumberField.delegate = self;
    
    //添加line2
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(line1.mas_bottom).offset(40);
        make.width.offset(225);
        make.height.offset(1);
    }];
    //添加密码imageView图标
    UIImageView *passWordImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_lock_icon"]];
    [self.view addSubview:passWordImageView];
    [passWordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line2.mas_left);
        make.bottom.equalTo(line2.mas_top).offset(-7.5);
        make.width.height.offset(17);
    }];
    //添加密码textField
    UITextField *passWordField = [[UITextField alloc]init];
    passWordField.placeholder = @"请输入验证码";
    passWordField.keyboardType = UIKeyboardTypeNumberPad;//设置键盘的样式
    [self.view addSubview:passWordField];
    [passWordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passWordImageView.mas_right).offset(15);
        make.bottom.equalTo(line2.mas_top).offset(-7.5);
        make.width.offset(110);
    }];
    self.passWordField = passWordField;
    
    //添加获取验证码Btn
    UIButton *getCodeBtn = [[UIButton alloc]init];
    [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCodeBtn setTitleColor:[UIColor colorWithHexString:@"f9f9f9"] forState:UIControlStateNormal];
    getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:9];
    [getCodeBtn setBackgroundColor:[UIColor colorWithHexString:@"66cc00"]];
    [self.view addSubview:getCodeBtn];
    [getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passWordField.mas_right).offset(5);
        make.bottom.equalTo(line2.mas_top).offset(-7.5);
        make.width.offset(50);
        make.height.offset(20);
    }];
    //点击事件
    [getCodeBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    //添加倒计时Label
    UILabel *countdownLabel = [UILabel labelWithText:@"59 S" andTextColor:[UIColor redColor] andFontSize:12];
    countdownLabel.hidden = true;
    [countdownLabel sizeToFit];
    [self.view addSubview:countdownLabel];
    self.countdownLabel = countdownLabel;
    [countdownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(getCodeBtn.mas_right).offset(5);
        make.centerY.equalTo(getCodeBtn);
    }];
    //添加登录Btn
    UIButton *logInBtn = [[UIButton alloc]init];
    [logInBtn setTitle:@"登录" forState:UIControlStateNormal];
    [logInBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    logInBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [logInBtn setBackgroundColor:[UIColor colorWithHexString:@"66cc00"]];
    [self.view addSubview:logInBtn];
    [logInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(line2);
        make.top.equalTo(line2.mas_bottom).offset(30);
        make.width.offset(80);
        make.height.offset(35);
    }];
    //点击事件
    [logInBtn addTarget:self action:@selector(logIn:) forControlEvents:UIControlEventTouchUpInside];
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
        [self showAlertWithMessage:@"请确认电话号码是否输入正确"];
        return;
    }

    //发送获取验证码请求
    NSString *urlString = [API_BASE_URL stringByAppendingPathComponent:[NSString stringWithFormat:@"/personal/vcode.do?id=%@",self.telNumberField.text]];
    HttpClient *httpManager = [HttpClient defaultClient];
    
    [httpManager requestWithPath:urlString method:HttpRequestPost parameters:nil prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *getCodeDic = (NSDictionary*)responseObject;
        if ([getCodeDic[@"code"] isEqualToString:@"0"]) {
            self.countdownLabel.hidden = false;
            self.passWordField.text = getCodeDic[@"result"];
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
                        [button setBackgroundColor:[UIColor colorWithHexString:@"66cc00"]];
                        
                        [button setTitle:@"获取验证码" forState:UIControlStateNormal];
                        button.userInteractionEnabled = true;
                        self.countdownLabel.hidden = true;
                        self.countdownLabel.text = @"59 S";
                    });
                } else {
                    int allTime = 60;
                    int seconds = timeOut % allTime;
                    NSString *timeStr = [NSString stringWithFormat:@"%0.2d", seconds];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [button setBackgroundColor:[UIColor colorWithHexString:@"#cccccc"]];
                        self.countdownLabel.text = [NSString stringWithFormat:@"%@ S",timeStr];
                        
                        button.userInteractionEnabled = false;
                        self.countdownLabel.hidden = false;
                    });
                    timeOut--;
                }
            });
            dispatch_resume(_timer);

        }else{
            [self showAlertWithMessage:@"请确认电话号码正确以及网络是否正常"];
            self.telNumberField.text = nil;
            self.countdownLabel.hidden = true;
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        return;
    }];

}

-(void)logIn:(UIButton*)sender{
    if (![self valiMobile:self.telNumberField.text]||[self.passWordField.text isEqualToString:@""]) {
        [self showAlertWithMessage:@"请确认电话号码和验证码是否输入正确"];
        return;
    }
    NSString *urlString = [API_BASE_URL stringByAppendingPathComponent:[NSString stringWithFormat:@"/personal/login.do?id=%@&vcode=%@",self.telNumberField.text,self.passWordField.text]];
    HttpClient *httpManager = [HttpClient defaultClient];
    [httpManager requestWithPath:urlString method:HttpRequestPost parameters:nil prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        if ([dic[@"code"] isEqualToString:@"0"]) {
            //保存登录电话和验证码
//            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//            [defaults setObject:self.telNumberField.text forKey:@"telNumber"];
//            [defaults setObject:self.passWordField.text forKey:@"passWord"];
            //保存token
            CcUserModel *userModel = [CcUserModel defaultClient];
            userModel.userToken = dic[@"result"];
            userModel.telephoneNum = self.telNumberField.text;
            [userModel saveAllInfo];
            
            //跳转登录首页
            YYTabBarController *firstVC = [[YYTabBarController alloc]init];
            [UIApplication sharedApplication].keyWindow.rootViewController = firstVC;
//            self.view.window.rootViewController = firstVC;

        }else{
            if ([dic[@"result"] isEqualToString:@""]) {
                [self showAlertWithMessage:@"请确认电话号码正确以及网络是否正常"];
            }else{
                
                [self showAlertWithMessage:dic[@"result"]];
            }

            self.passWordField.text = nil;
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        return ;
    }];

}

#pragma UItextdelegate

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
    if (self.telNumberField == textField)  //判断是否是我们想要限定的那个输入框
    {
             if ([toBeString length] > 11) { //如果输入框内容大于20则弹出警告
//            textField.text = [textField.text substringToIndex:11];
            [self showAlertWithMessage:@"您输入的电话号码超过11位"];
            
            return NO;
        }
    }
    return YES; 
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSString * toBeString = textField.text; //得到输入框的内容
    if (self.telNumberField == textField)  //判断是否是我们想要限定的那个输入框
        
    {
        
        if ([textField.text length] < 11){
            [self showAlertWithMessage:@"您输入的电话号码少于11位"];
            
            
        }else if ([textField.text length] == 11){
            if (![self valiMobile:toBeString]) {
                [self showAlertWithMessage:@"请输入正确的11位电话号码"];

            }
        }
    }
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSString * toBeString = textField.text; //得到输入框的内容
    if ([textField.text length] == 11){
        if (![self valiMobile:toBeString]) {
            [self showAlertWithMessage:@"请输入正确的11位电话号码"];
            return false;
        }
    }
    return true;

}
//弹出alert
-(void)showAlertWithMessage:(NSString*)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    //            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    //            [alert addAction:cancelAction];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.telNumberField becomeFirstResponder];
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
