//
//  YYPInfomartionViewController.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/24.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYPInfomartionViewController.h"
#import "UIColor+Extension.h"
#import "YYHomeNewTableViewCell.h"
#import <Masonry.h>
#import "YYSectionViewController.h"
#import "YYPersonalTableViewCell.h"
#import "YYRecardTableViewCell.h"
#import "YYPInfomationTableViewCell.h"
#import "ZYActionSheet.h"
#import "ZYAlertSView.h"
#import "UIColor+Extension.h"
#import "UIBarButtonItem+Helper.h"
#import "CcUserModel.h"
#import "HttpClient.h"
#import <UIImageView+WebCache.h>
#import <UIImageView+WebCache.h>
#import "YYTabBarController.h"
@interface YYPInfomartionViewController ()<UITableViewDataSource, UITableViewDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSArray *iconList;

@property (nonatomic, weak) ZYAlertSView *alertView;
@property (nonatomic, weak) UIView *selectView;
@property (nonatomic, weak) UIImageView *manV;
@property (nonatomic, weak) UIImageView *womanV;


@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, weak) UIImageView *userIcon;
@property (nonatomic, strong) UIImage *chooseImage;
@property (nonatomic, weak) YYPInfomationTableViewCell *genderCell;


@end

@implementation YYPInfomartionViewController

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces = NO;
        _tableView.indicatorStyle =
        _tableView.rowHeight = kScreenW *77/320.0 +10;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[YYPInfomationTableViewCell class] forCellReuseIdentifier:@"YYPInfomationTableViewCell"];
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
    self.title = @"个人编辑";
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    
    
    self.dataSource = [[NSMutableArray alloc]initWithArray:@[@"用户名",@"性别",@"年龄",@"身份证号码"]];
    //    self.iconList =@[@"Personal-EMR-icon-",@"Personal-message-icon-",@"Personal-shopping -icon-",@"order_icon_",@"family-icon--1",@"equipment-icon-",@"goods-icon-",@"Set-icon-"];
    
    
    //    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 70 *kiphone6)];
    //    headView.backgroundColor = [UIColor whiteColor];
    //    UIImageView *imageV =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_icon"]];
    //    [headView addSubview:imageV];
    //    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(headView).with.offset(20 *kiphone6);
    //        make.left.equalTo(headView).with.offset(20 *kiphone6);
    //        make.size.mas_equalTo(CGSizeMake((kScreenW -40*kiphone6), 30 *kiphone6));
    //    }];
    //   self.tableView.tableHeaderView = [self personInfomation];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithbackGroundColor:[UIColor colorWithHexString:@"25f368"] title:@"保存" target:self action:@selector(saveInfo)];
    [self tableView];
    
    // Do any additional setup after loading the view.
}
//- (UIView *)personInfomation{
//    
//    UIView *personV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 90 *kiphone6)];
//    personV.backgroundColor = [UIColor whiteColor];
//    
//    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 10)];
//    headerView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
//    
//    [personV addSubview:headerView];
//    
//    UIImageView *iconV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"LIM_"]];
//    iconV.layer.cornerRadius = 25;
//    iconV.clipsToBounds = YES;
//    //
//    UILabel *nameLabel = [[UILabel alloc]init];
//    nameLabel.text = @"李美丽";
//    nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
//    nameLabel.font = [UIFont systemFontOfSize:14];
//    //
//    UILabel *idName = [[UILabel alloc]init];
//    idName.text = @"用户：18328887563";
//    idName.textColor = [UIColor colorWithHexString:@"333333"];
//    idName.font = [UIFont systemFontOfSize:13];
//    //
//    [personV addSubview:iconV];
//    [personV addSubview:nameLabel];
//    [personV addSubview:idName];
//    //
//    [iconV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(personV).with.offset(10);
//        make.left.equalTo(personV).with.offset(25 *kiphone6);
//        make.size.mas_equalTo(CGSizeMake(50 *kiphone6, 50 *kiphone6));
//    }];
//    //
//    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(personV).with.offset(31.5 *kiphone6);
//        make.left.equalTo(iconV.mas_right).with.offset(10 *kiphone6);
//        make.size.mas_equalTo(CGSizeMake(140 *kiphone6, 14 *kiphone6));
//    }];
//    //
//    [idName mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(nameLabel.mas_bottom).with.offset(10 *kiphone6);
//        make.left.equalTo(nameLabel.mas_left);
//        make.size.mas_equalTo(CGSizeMake(260 *kiphone6, 13 *kiphone6));
//    }];
//    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeUserIcon:)];
//    [personV addGestureRecognizer:tapGest];
//    
//    return personV;
//}

#pragma mark -
#pragma mark ------------Tableview Delegate----------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1) {
        CGFloat alertW = 200 *kiphone6;
        CGFloat alertH = 130 *kiphone6;
        // titleView
        UIView *titleV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, alertW, 50)];
        titleV.backgroundColor = [UIColor whiteColor];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 18, 100, 14)];
        titleLabel.text = @"性别";
        titleLabel.textColor = [UIColor colorWithHexString:@"666666"];
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [titleV addSubview:titleLabel];
        
        
        // 选项view
        UIView *selectView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, alertW, alertH - 50)];
        
        NSArray *nameList = @[@"男",@"女"];
        NSArray *imageStr = @[@"circle-icon-selected-2",@"circle-icon-uncheck-2"];
        NSInteger peopleCount = 2;        // 人数
        for (int i = 0; i < peopleCount ; i++) {
            CGFloat y_padding = 45 *kiphone6;
            
            UIView *btnView = [[UIView alloc]initWithFrame:CGRectMake(0,i *y_padding, alertW,  y_padding)];
            btnView.backgroundColor = [UIColor whiteColor];
            btnView.tag = 200 +i;
            
            UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapaClick:)];
            [btnView addGestureRecognizer:tapGest];
            
            
            UILabel *nameLabel = [[UILabel alloc]init];
            nameLabel.textColor = [UIColor colorWithHexString:@"666666"];
            nameLabel.font = [UIFont systemFontOfSize:12];
            nameLabel.text = nameList[i];
            nameLabel.textAlignment = NSTextAlignmentCenter;
            if (i != 2) {
                UILabel *lineLabel = [[UILabel alloc]init];
                lineLabel.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
                
                [btnView addSubview:lineLabel];
                
                [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(btnView);
                    make.left.equalTo(btnView);
                    make.size.mas_equalTo(CGSizeMake(alertW,1));
                }];
                
            }
            

            UIImageView *imageGreenV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageStr[i]]];
            if ([self.genderCell.seeRecardLabel.text isEqualToString:@"女"]) {
                if (i == 1) {
                    imageGreenV.image = [UIImage imageNamed:@"circle-icon-selected-2"];
                }else{
                    imageGreenV.image = [UIImage imageNamed:@"circle-icon-uncheck-2"];
                }
            }
            imageGreenV.clipsToBounds = YES;
            
            
            
            [btnView addSubview:nameLabel];
            [btnView addSubview:imageGreenV];
            
            [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(btnView);
                make.size.mas_equalTo(CGSizeMake(alertW,12));
            }];
            [imageGreenV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(btnView).with.offset(-16);
                make.centerY.equalTo(btnView);
                make.size.mas_equalTo(CGSizeMake(10,10));
            }];
            if (i == 0) {
                self.manV = imageGreenV;
            }else{
                self.womanV = imageGreenV;
            }
            [selectView addSubview:btnView];
        }
        self.selectView = selectView;
        
        ZYAlertSView *alertV = [[ZYAlertSView alloc]initWithContentSize:CGSizeMake(alertW, alertH) TitleView:titleV selectView:selectView sureView:nil];
        [alertV show];
        self.alertView = alertV;

//       ZYActionSheet *sheet = [[ZYActionSheet alloc] initWithTitle:@"性别"
//                                                       buttonTitles:[NSArray arrayWithObjects:@"男",@"女", nil]
//                                                  cancelButtonTitle:@""
//                                                           delegate:(id<ZYActionSheetDelegate>)self
//                                                            buttonW:200 *kiphone6];
//        sheet.titleFont = [UIFont systemFontOfSize:20];
//        sheet.titleBackgroundColor = [UIColor colorWithHexString:@"f4f5f8"];
//        sheet.titleColor = [UIColor colorWithHexString:@"666666"];
//        sheet.lineColor = [UIColor colorWithHexString:@"dbdce4"];
//        [sheet showWithFrame:CGRectMake((kScreenW - 200 *kiphone6)/2.0, (kScreenH - 135 *kiphone6)/2.0, 200 *kiphone6, 135 *kiphone6)];
    }
//    [self.navigationController pushViewController:[[YYSectionViewController alloc]init] animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark -
#pragma mark ------------TableView DataSource----------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40 *kiphone6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80 *kiphone6;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *allHeadSectionV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 80 *kiphone6)];
    allHeadSectionV.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, kScreenW, 70 *kiphone6)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *iconV = [[UIImageView alloc]init];
    [iconV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mPrefixUrl,self.personalModel.avatar]]];
    iconV.layer.cornerRadius = 25;
    iconV.clipsToBounds = YES;
    
    self.userIcon = iconV;
    
    [headerView addSubview:iconV];
    
    [iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.left.equalTo(headerView).with.offset(25 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(50 *kiphone6, 50 *kiphone6));
    }];
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"头像";
    nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
    nameLabel.font = [UIFont systemFontOfSize:15];
    
    
    [headerView addSubview:nameLabel];
    
    WS(ws);
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.right.equalTo(headerView).with.offset(-10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(35 ,15));
    }];
    
    [allHeadSectionV addSubview:headerView];
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeUserIcon:)];
        [allHeadSectionV addGestureRecognizer:tapGest];
    return allHeadSectionV;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYPInfomationTableViewCell *homeTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"YYPInfomationTableViewCell" forIndexPath:indexPath];
    
   
    
    homeTableViewCell.titleLabel.text = self.dataSource[indexPath.row];
    if (indexPath.row ==  0) {
        [homeTableViewCell setType:@"celltextfield"];
        homeTableViewCell.editInfoText.text = self.personalModel.trueName;//@"18511694068";
         homeTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else if (indexPath.row ==  1) {
        if ([self.personalModel.gender isEqualToString:@"0"]) {
            homeTableViewCell.seeRecardLabel.text = @"女";
        }else{
            homeTableViewCell.seeRecardLabel.text = @"男";
        }
        self.genderCell = homeTableViewCell;
        
    }else if (indexPath.row ==  2) {
        [homeTableViewCell setType:@"celltextfield"];
        homeTableViewCell.editInfoText.text = self.personalModel.age;//@"26";
         homeTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else if (indexPath.row ==  3) {
        [homeTableViewCell setType:@"celltextfield"];
        homeTableViewCell.editInfoText.text = self.personalModel.idCard;//@"2301221993077220014";
        homeTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else if (indexPath.row ==  4) {
        homeTableViewCell.seeRecardLabel.text = @"黑龙江省哈尔滨";
        homeTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //    homeTableViewCell.iconV.image = [UIImage imageNamed:self.iconList[indexPath.row]];
    
    return homeTableViewCell;
    
}


- (void)tapaClick:(UITapGestureRecognizer *)tapGesture{
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)tapGesture;
    NSInteger index = singleTap.view.tag -200;
    NSArray *imageStr = @[@"circle-icon-selected-2",@"circle-icon-uncheck-2"];
    [self.alertView dismiss:nil];
    if (index == 0) {
        self.manV.image = [UIImage imageNamed:imageStr[0]];
        self.womanV.image = [UIImage imageNamed:imageStr[1]];
        self.genderCell.seeRecardLabel.text = @"男";
    }else if(index == 1){
        self.manV.image = [UIImage imageNamed:imageStr[1]];
        self.womanV.image = [UIImage imageNamed:imageStr[0]];
        self.genderCell.seeRecardLabel.text = @"女";
    }
}

#pragma mark ----------pickerView代理事件------------
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
        self.userIcon.image = [self.chooseImage  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
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

- (void)saveInfo{
    NSLog(@"保存个人信息");
    NSString *userToken = [CcUserModel defaultClient].userToken;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity:2];
    for (int i = 0; i<4; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        YYPInfomationTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        // cell.editInfoText.text;
        NSLog(@"%@",cell.editInfoText.text);
        if (i == 0 &&![cell.editInfoText.text isEqualToString:@""]) {
            [dict setObject:cell.editInfoText.text forKey:@"trueName"];
        }else if(i == 1&&![cell.seeRecardLabel.text isEqualToString:@""]){
            NSString *gender;
            if ([cell.seeRecardLabel.text isEqualToString:@"男"]) {
                gender = @"1";
            }else{
                gender = @"0";
            }
            [dict setObject:gender forKey:@"gender"];
        }else if(i == 2&&![cell.editInfoText.text isEqualToString:@""]){
            [dict setObject:cell.editInfoText.text forKey:@"age"];
        }else if(i == 3&&![cell.editInfoText.text isEqualToString:@""]){
            [dict setObject:cell.editInfoText.text forKey:@"idCard"];
        }
    }
    NSLog(@"%@",dict);
    //UIImage图片转成Base64字符串：
    UIImage *originImage = self.userIcon.image;
    NSData *data = UIImageJPEGRepresentation(originImage, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [dict setValue:userToken forKey:@"token"];
    [dict setValue:encodedImageStr forKey:@"avatar"];
    [[HttpClient defaultClient]requestWithPath:[NSString stringWithFormat:@"%@",mChangeInfo] method:1 parameters:dict prepareExecute:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *messageStr;
        if ([responseObject[@"code"] isEqualToString:@"0"]) {
            messageStr = @"用户信息保存成功";
        }else{
            messageStr = @"用户信息保存失败";
        }
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:messageStr preferredStyle:UIAlertControllerStyleAlert];
 //       UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            if(self.isFirstLogin){
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
        
 //       [alert addAction:cancelAction];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)viewWillDisappear:(BOOL)animated{
    if (self.isFirstLogin) {
        YYTabBarController *firstVC = [[YYTabBarController alloc]init];
        [UIApplication sharedApplication].keyWindow.rootViewController = firstVC;
    }
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
