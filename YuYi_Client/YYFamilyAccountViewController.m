//
//  YYFamilyAccountViewController.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/27.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYFamilyAccountViewController.h"
#import <Masonry.h>
#import "UIColor+Extension.h"
#import "UIBarButtonItem+Helper.h"
#import "CcUserModel.h"
#import "HttpClient.h"

@interface YYFamilyAccountViewController ()

@property (nonatomic, strong) UIView *cardView;
@property (nonatomic, assign) CGFloat currentH;

@property (nonatomic, weak) UIImageView *iconV;

@end

@implementation YYFamilyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    self.title = @"添加家庭用户";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" normalColor:[UIColor colorWithHexString:@"25f368"] highlightedColor:[UIColor colorWithHexString:@"25f368"] target:self action:@selector(addFamily)];
    [self createSubView];
    // Do any additional setup after loading the view.
}
- (void)createSubView{
    NSArray *titleList  = @[@"家人关系",@"年        龄",@"姓        名",@"手  机  号"];
    
    
    
    self.cardView = [[UIView alloc]init];
    self.cardView.backgroundColor = [UIColor whiteColor];
    self.cardView.layer.cornerRadius = 2.5;
    self.cardView.clipsToBounds = YES;
    
    [self.view addSubview:self.cardView];
    
    [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(90);
        make.left.equalTo(self.view).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(kScreenW - 20 , 200));
    }];
    
    
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cell1"]];
    imageV.layer.cornerRadius = 30 *kiphone6;
    imageV.clipsToBounds = YES;
    
    self.iconV = imageV;
    
    for (int i = 0; i < 4; i++) {
        UITextField *inputText = [[UITextField alloc]init];
        inputText.tag = i +200;
        inputText.layer.borderColor = [UIColor colorWithHexString:@"f2f2f2"].CGColor;
        inputText.layer.borderWidth = 0.5;
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.text = titleList[i];
        titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
        titleLabel.font = [UIFont systemFontOfSize:14];
        
        
        [self.cardView addSubview:inputText];
        [self.cardView addSubview:titleLabel];
        
        WS(ws);
        [inputText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.cardView).with.offset(104 *kiphone6);
            make.top.equalTo(ws.cardView).with.offset(85 +i *55 *kiphone6);
            make.size.mas_equalTo(CGSizeMake(130 *kiphone6 ,30 *kiphone6));
        }];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.cardView).with.offset(20 *kiphone6);
            //            make.top.equalTo(ws.cardView).with.offset(85 +i *55 *kiphone6);
            make.centerY.equalTo(inputText.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(64 ,14 *kiphone6));
        }];
    }
    
    
    [self.cardView addSubview:imageV];
    
    
    
    WS(ws);
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.cardView);
        make.top.equalTo(ws.cardView).with.offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(60 *kiphone6 ,60 *kiphone6));
    }];
    
    
    UILabel *promtyLabel = [[UILabel alloc]initWithFrame:CGRectMake(104 *kiphone6, 285 , 80, 11)];
    promtyLabel.text = @"选添项";
    promtyLabel.textColor = [UIColor colorWithHexString:@"cccccc"];
    promtyLabel.font = [UIFont systemFontOfSize:11];
    [self.cardView addSubview:promtyLabel];
    
    UIButton *optionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [optionBtn setImage:[UIImage imageNamed:@"agree"] forState:UIControlStateNormal];
    [optionBtn setImage:[UIImage imageNamed:@"agree-Selected"] forState:UIControlStateSelected];
    [optionBtn sizeToFit];
    
    [self.cardView addSubview:optionBtn];
    [optionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(promtyLabel.mas_left);
        make.top.equalTo(promtyLabel.mas_bottom).with.offset(5 *kiphone6);
    }];
    
    UILabel *wordsLabel = [[UILabel alloc]init];
    wordsLabel.text = @"同意此手机号账户查看我的家庭用户成员信息";
    wordsLabel.textColor = [UIColor colorWithHexString:@"666666"];
    wordsLabel.font = [UIFont systemFontOfSize:11];
    [self.cardView addSubview:wordsLabel];
    
    
    [wordsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(optionBtn.mas_right).with.offset(5 *kiphone6);
        make.centerY.equalTo(optionBtn.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kScreenW *kiphone6 ,11 *kiphone6));
    }];
    
    
    [self.cardView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view).with.offset(74 );
        make.left.equalTo(ws.view).with.offset(10);
        make.bottom.equalTo(wordsLabel.mas_bottom).with.offset(20);
        make.width.mas_equalTo(kScreenW - 20 );
    }];
    
}
- (void)addFamily{
    NSString *userToken = [CcUserModel defaultClient].userToken;
    
    UITextField *textField1 = (UITextField *)[self.cardView viewWithTag:200];
    UITextField *textField2 = (UITextField *)[self.cardView viewWithTag:201];
    UITextField *textField3 = (UITextField *)[self.cardView viewWithTag:202];
    UITextField *textField4 = (UITextField *)[self.cardView viewWithTag:203];
    
    NSString *nickName = [NSString stringWithFormat:@"&nickName=%@",textField1.text];
    NSString *age = [NSString stringWithFormat:@"&age=%@",textField2.text];
    NSString *trueName = [NSString stringWithFormat:@"&trueName=%@",textField3.text];
    NSString *telephone = [NSString stringWithFormat:@"&telephone=%@",textField4.text];
    
    
    //UIImage图片转成Base64字符串：
    UIImage *originImage = self.iconV.image;
    NSData *data = UIImageJPEGRepresentation(originImage, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity:2];
    [dict setValue:userToken forKey:@"token"];
    if (![nickName isEqualToString:@"&nickName="]) {
        [dict setValue:textField1.text forKey:@"nickName"];
    }
    if (![age isEqualToString:@"&age="]) {
        [dict setValue:textField2.text forKey:@"age"];
    }
    if (![trueName isEqualToString:@"&trueName="]) {
        [dict setValue:textField3.text forKey:@"trueName"];
    }
    if (![telephone isEqualToString:@"&telephone="]) {
        [dict setValue:textField4.text forKey:@"telephone"];;
    }
    if (![encodedImageStr isEqualToString:@""]) {
        [dict setValue:encodedImageStr forKey:@"avatar"];;
    }
    [[HttpClient defaultClient]requestWithPath:mAddFamily method:1 parameters:dict prepareExecute:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
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
