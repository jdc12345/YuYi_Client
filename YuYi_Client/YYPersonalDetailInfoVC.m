//
//  YYPersonalDetailInfoVC.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/9/29.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYPersonalDetailInfoVC.h"
#import "UILabel+Addition.h"
#import "YYChangePersonInfoTVCell.h"
#import "CcUserModel.h"
#import "HttpClient.h"
#import <UIImageView+WebCache.h>

@interface YYPersonalDetailInfoVC ()<UITableViewDataSource, UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSString *filePath;//图片路径
@property (nonatomic, weak) UIImageView *iconV;//头像
@property (nonatomic, strong) UIImage *chooseImage;//选中的图片
@property (nonatomic, strong) UIButton *womanBtn;
@property (nonatomic, strong) UIButton *manBtn;
@end

@implementation YYPersonalDetailInfoVC
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces = NO;
        _tableView.indicatorStyle =
        _tableView.rowHeight = kScreenW *77/320.0 +10;
//        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[YYChangePersonInfoTVCell class] forCellReuseIdentifier:@"YYChangePersonInfoTVCell"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [self.view addSubview:_tableView];
        [self.view sendSubviewToBack:_tableView];
        
    }
    return _tableView;
}
- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    self.view.backgroundColor = [UIColor whiteColor];
    //tableviewFooter
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 100*kiphone6H)];
    footerView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    UIButton *saveBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    saveBtn.layer.cornerRadius = 3;
    saveBtn.clipsToBounds = YES;
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.backgroundColor = [UIColor colorWithHexString:@"1ebeec"];
    [saveBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    [footerView addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10*kiphone6);
        make.right.offset(-10*kiphone6);
        make.height.offset(44*kiphone6H);
        make.top.offset(40*kiphone6H);
    }];
    [saveBtn addTarget:self action:@selector(saveInfo) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = footerView;
    self.tableView.tableHeaderView = [self personInfomation];

}
//头部试图
- (UIView *)personInfomation{
    
    //添加背景视图
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 160*kiphone6H)];
    backView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    //添加头像
    UIImageView *iconView = [[UIImageView alloc]init];
    UIImage *iconImage = [UIImage imageNamed:@"avatar.jpg"];
    if ([self.personalModel.avatar isEqualToString:@""]) {
        iconView.image = iconImage;
    }else{
        [iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mPrefixUrl,self.personalModel.avatar]]];
    }
    
    [backView addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView);
        make.top.offset(20*kiphone6H);
        make.width.height.offset(74);
    }];
    iconView.layer.cornerRadius=74*0.5;//裁成圆角
    iconView.layer.masksToBounds=YES;//隐藏裁剪掉的部分
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeUserIcon:)];
    [iconView addGestureRecognizer:tapGest];
    iconView.userInteractionEnabled = YES;
    self.iconV = iconView;

    //标题label
    UILabel *titlelabel = [UILabel labelWithText:@"修改头像" andTextColor:[UIColor colorWithHexString:@"333333"] andFontSize:14];
    [backView addSubview:titlelabel];
    [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(iconView);
        make.top.equalTo(iconView.mas_bottom).offset(10*kiphone6H);
    }];
    
    return backView;
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
#pragma mark -
#pragma mark ------------TableView DataSource----------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45 *kiphone6H;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYChangePersonInfoTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YYChangePersonInfoTVCell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.titleLable.text = @"用户名";
        cell.textField.text = self.personalModel.trueName;
    }else if (indexPath.row == 1){
        cell.titleLable.text = @"性别";
        cell.textField.hidden = true;
        UIButton *womanBtn = [[UIButton alloc]init];
        [womanBtn setImage:[UIImage imageNamed:@"click-Choice_personal"] forState:UIControlStateSelected];
        [womanBtn setImage:[UIImage imageNamed:@"Choice_personal"] forState:UIControlStateNormal];
        [womanBtn setTitle:@"女" forState:UIControlStateNormal];
        womanBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [womanBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        [cell.contentView addSubview:womanBtn];
        [womanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.titleLable.mas_right).offset(15*kiphone6);
            make.centerY.offset(0);
        }];
        [womanBtn addTarget:self action:@selector(ganderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        UIButton *manBtn = [[UIButton alloc]init];
        [manBtn setImage:[UIImage imageNamed:@"click-Choice_personal"] forState:UIControlStateSelected];
        [manBtn setImage:[UIImage imageNamed:@"Choice_personal"] forState:UIControlStateNormal];
        [manBtn setTitle:@"男" forState:UIControlStateNormal];
        manBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [manBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        [cell.contentView addSubview:manBtn];
        [manBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(womanBtn.mas_right).offset(15*kiphone6);
            make.centerY.offset(0);
        }];
        [manBtn addTarget:self action:@selector(ganderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        womanBtn.tag = 101;
        manBtn.tag = 102;
        self.womanBtn = womanBtn;
        self.manBtn = manBtn;
        if ([self.personalModel.gender integerValue] == 0) {
            self.womanBtn.selected = true;
        }else{
            self.manBtn.selected = true;
        }
    }else{
        cell.titleLable.text = @"年龄";
        cell.textField.text = self.personalModel.age;
    }
   
    return cell;
    
}
//性别按钮点击事件
-(void)ganderBtnClick:(UIButton*)sender{
    sender.selected = !sender.selected;
    if (sender.selected == true) {
        if (sender.tag == 101) {
           self.manBtn.selected = false;
        }else{
           self.womanBtn.selected = false;
        }
        
    }
    
}
#pragma mark -
#pragma mark ------------Http client----------------------
- (void)saveInfo{
    NSLog(@"保存个人信息");
    NSString *userToken = [CcUserModel defaultClient].userToken;
    
    BOOL isEmpty = NO;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity:2];
    for (int i = 0; i<3; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        YYChangePersonInfoTVCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        // cell.editInfoText.text;
        NSLog(@"%@",cell.textField.text);
        if (i == 0 &&![cell.textField.text isEqualToString:@""]) {
            [dict setObject:cell.textField.text forKey:@"trueName"];
        }else if(i == 1){
            NSString *gender;
            if (self.manBtn.selected) {
                gender = @"1";
            }
            if (self.womanBtn.selected) {
                gender = @"0";
            }
            [dict setObject:gender forKey:@"gender"];
        }else if(i == 2&&![cell.textField.text isEqualToString:@""]){
            [dict setObject:cell.textField.text forKey:@"age"];
        }
        if ([cell.textField.text isEqualToString:@""] && i != 1) {
            isEmpty = YES;
        }
    }
    if (isEmpty) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"信息填写不完整" preferredStyle:UIAlertControllerStyleAlert];
        //       UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) { }];
        //       [alert addAction:cancelAction];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        NSLog(@"%@",dict);
        //UIImage图片转成Base64字符串：
        UIImage *originImage = self.iconV.image;
        
        
        //        UIImage *image = [UIImage imageNamed:@"HD"];
        //        //第一个参数是图片对象，第二个参数是压的系数，其值范围为0~1。
        //        NSData * imageData = UIImageJPEGRepresentation(image, 0.2);
        //        originImage = [UIImage imageWithData:imageData];
        
        
        NSData *data = UIImageJPEGRepresentation(originImage, 0.2f);
        NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [dict setValue:userToken forKey:@"token"];
        [dict setValue:encodedImageStr forKey:@"avatar"];
        [SVProgressHUD show];
        [[HttpClient defaultClient]requestWithPath:[NSString stringWithFormat:@"%@",mChangeInfo] method:1 parameters:dict prepareExecute:^{
            
        } success:^(NSURLSessionDataTask *task, id responseObject) {
            [SVProgressHUD dismiss];
            NSLog(@"%@",responseObject);
            NSString *messageStr;
            if ([responseObject[@"code"] isEqualToString:@"0"]) {
                messageStr = @"用户信息保存成功";
            }else{
                messageStr = @"用户信息保存失败";
            }
            [SVProgressHUD showInfoWithStatus:messageStr];

        } failure:^(NSURLSessionDataTask *task, NSError *error) {
          [SVProgressHUD dismiss];  
        }];
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
