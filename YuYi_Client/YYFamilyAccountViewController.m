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

@interface YYFamilyAccountViewController ()<UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIView *cardView;
@property (nonatomic, assign) CGFloat currentH;

@property (nonatomic, weak) UIImageView *iconV;
@property (nonatomic, weak) UISegmentedControl *genderSel;


@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, weak) UIImageView *userIcon;
@property (nonatomic, strong) UIImage *chooseImage;

@end

@implementation YYFamilyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    self.title = @"添加家庭用户";
    
    if (self.titleStr) {
        NSLog(@"设置标题 %@",self.titleStr);
        self.title = self.titleStr;
    }
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
    
    
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"avatar.jpg"]];
    imageV.layer.cornerRadius = 30 *kiphone6;
    imageV.clipsToBounds = YES;
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeUserIcon:)];
    [imageV addGestureRecognizer:tapGest];
    imageV.userInteractionEnabled = YES;
    
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
    
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"性        别";
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    titleLabel.font = [UIFont systemFontOfSize:14];
    
    
    [self.cardView addSubview:titleLabel];
    
    WS(ws);

    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.cardView).with.offset(20 *kiphone6);
        make.top.equalTo(ws.cardView).with.offset(85 +4 *55 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(64 ,14 *kiphone6));
    }];
    
    
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.cardView);
        make.top.equalTo(ws.cardView).with.offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(60 *kiphone6 ,60 *kiphone6));
    }];
    
    
    UILabel *promtyLabel = [[UILabel alloc]initWithFrame:CGRectMake((104 +130 + 10)*kiphone6, 100 +3 *55 *kiphone6 , 80, 11)];
    promtyLabel.text = @"选填项";
    promtyLabel.textColor = [UIColor colorWithHexString:@"cccccc"];
    promtyLabel.font = [UIFont systemFontOfSize:11];
    [self.cardView addSubview:promtyLabel];
    
//    UIButton *optionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [optionBtn setImage:[UIImage imageNamed:@"agree"] forState:UIControlStateNormal];
//    [optionBtn setImage:[UIImage imageNamed:@"agree-Selected"] forState:UIControlStateSelected];
//    [optionBtn sizeToFit];
//    
////    [self.cardView addSubview:optionBtn];
//    [optionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(promtyLabel.mas_left);
//        make.top.equalTo(promtyLabel.mas_bottom).with.offset(5 *kiphone6);
//    }];
    
//    UILabel *wordsLabel = [[UILabel alloc]init];
//    wordsLabel.text = @"同意此手机号账户查看我的家庭用户成员信息";
//    wordsLabel.textColor = [UIColor colorWithHexString:@"666666"];
//    wordsLabel.font = [UIFont systemFontOfSize:11];
//    [self.cardView addSubview:wordsLabel];
    
    NSArray *array = [NSArray arrayWithObjects:@"男",@"女", nil];
    //初始化UISegmentedControl
    UISegmentedControl *wordsLabel = [[UISegmentedControl alloc]initWithItems:array];
    //
    [wordsLabel setSelectedSegmentIndex:0];
    self.genderSel = wordsLabel;
//    [wordsLabel addTarget:self action:@selector() forControlEvents:UIControlEventTouchUpInside];
    //添加到视图
    [self.cardView addSubview:wordsLabel];
    
    
    [wordsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cardView).with.offset(104 *kiphone6);
        make.centerY.equalTo(titleLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(130 *kiphone6 ,30 *kiphone6));
    }];
    
    
    [self.cardView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view).with.offset(74 );
        make.left.equalTo(ws.view).with.offset(10);
        make.bottom.equalTo(wordsLabel.mas_bottom).with.offset(20);
        make.width.mas_equalTo(kScreenW - 20 );
    }];
    
    if (self.personalModel) {
        UITextField *textField1 = (UITextField *)[self.cardView viewWithTag:200];
        UITextField *textField2 = (UITextField *)[self.cardView viewWithTag:201];
        UITextField *textField3 = (UITextField *)[self.cardView viewWithTag:202];
        UITextField *textField4 = (UITextField *)[self.cardView viewWithTag:203];
        
        
        textField1.text = self.personalModel.nickName;
        textField2.text = self.personalModel.age;
        textField3.text = self.personalModel.trueName;
        
        if (![self.personalModel.telephone isEqualToString:@"0"]) {
            textField4.text = self.personalModel.telephone;
        }
        [wordsLabel setSelectedSegmentIndex:[self.personalModel.gender integerValue]];
    }
    
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
    NSData *data = UIImageJPEGRepresentation(originImage, 0.2f);
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
    // 添加性别
    if (self.genderSel.selectedSegmentIndex == 0 ) {
        [dict setValue:@"1" forKey:@"gender"];;
    }else{
        [dict setValue:@"0" forKey:@"gender"];;
    }
    [dict setValue:self.personalModel.info_id forKey:@"id"];

    NSLog(@"%ld",self.genderSel.selectedSegmentIndex);
    [[HttpClient defaultClient]requestWithPath:mAddFamily method:1 parameters:dict prepareExecute:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *result;
        if ([responseObject[@"code"] isEqualToString:@"0"]) {
            if (self.titleStr) {
                result = @"修改用户信息成功";
            }else{
                result = @"添加用户成功";
            }
            
        }else{
            result = responseObject[@"result"];
        }
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:result preferredStyle:UIAlertControllerStyleAlert];
        //       UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            if ([responseObject[@"code"] isEqualToString:@"0"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }else{
            }
            
        }];
        
        //       [alert addAction:cancelAction];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeUserIcon:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
    
}
//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"]){
        //先把图片转成NSData
        self.chooseImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data;
        if (UIImagePNGRepresentation(self.chooseImage) == nil){
            data = UIImageJPEGRepresentation(self.chooseImage, 1.0);
        }else{
            data = UIImagePNGRepresentation(self.chooseImage);
        }
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        _filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        /****图片本地持久化*******/
        
        
        
        //        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        //        NSString *myfilePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"picture.png"]];
        //        // 保存文件的名称
        //        [UIImagePNGRepresentation(self.chooseImage)writeToFile: myfilePath  atomically:YES];
        //        NSUserDefaults *userDef= [NSUserDefaults standardUserDefaults];
        //        [userDef setObject:myfilePath forKey:kImageFilePath];
        
        //创建一个选择后图片的小图标放在下方
        //类似微薄选择图后的效果
        self.iconV.image = [self.chooseImage  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
    }
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)sendInfo
{
    NSLog(@"图片的路径是：%@", _filePath);
    
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
