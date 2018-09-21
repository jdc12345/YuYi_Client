//
//  YYHospitalInfoViewController.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/23.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#define kHospitalText @"       河北省涿州市中医医院，位于北京经济圈的紧密层，距天安门仅六十二公里，医院创建于1984年，2008年底改制后注资2亿元进行扩建，是我市唯一一家国有并与北京中医药大学东直门医院、解放军307医院合作的集医疗、预防、保健、康复、科研、教学为一体的大型综合性中西医结合医院。医院占地面积30亩，正在建设中的医院大楼按三级医院标准建造设置，建筑面积45000平方米，开设床位501张，医院共设置临床、医技、行政等科室39个，计划今年底开业。目前，因医院扩建及业务发展需要，现向全国诚聘各类专业技术人才。\n       涿州市医院地处市中心范阳西路129号，市政府东侧，北京天桥至涿州的838路公共汽车通过门前，交通四通八达。医院占地50亩，建筑面积为11万平方米、开放床位1000张，全院职工1400人，专业技术人员900人。2009年医院投入2.6亿元兴建病房楼4.9万平方米。2011年医院又投入5亿元新建9.7万平方米的医技综合大楼，届时医院总建筑面积将达20万平方米。为了加快数字化医院建设，医院又投资近千万安装HIS系统。医院设有：骨科关节外科、脊柱外科、神经外科、普外胃肠外科、肝胆外科、泌尿外科、胸外科、心外科、腺体外科、妇科、产科、肿瘤科、放疗科、神经内科、呼吸内科、消化内科、内分泌科、心内科、肾内科、血液科、儿科、新生儿科、耳鼻喉科、口腔科、眼科、中医科、康复医学科、皮肤科、心理咨询门诊、急诊科、感染科、功能科、检验科、输血科、病理科、药剂科、介入室、内窥镜室、放疗科、等10个医技科室。涿州市医院投入近3亿元先后引进了10万元以上大型医疗设备139台，包括美国GE双层螺旋CT、日立全自动生化分析仪、德国西门子0.2T核磁共振成像系统（MGI ）和64排CT、瑞典医科达公司引进的用于放射性治疗恶性肿瘤的直线加速器。"
#import "YYHospitalInfoViewController.h"
#import "FMActionSheet.h"
#import "ZYAlertSView.h"
#import "YYSpeechViewController.h"
#import "YYAVViewController.h"
#import "YYWordsViewController.h"
#import <RongCallKit/RongCallKit.h>
#import <UIImageView+WebCache.h>
#import "HttpClient.h"
#import <UIImageView+WebCache.h>
#import "UILabel+Addition.h"

@interface YYHospitalInfoViewController ()<RCCallSessionDelegate,UITextViewDelegate,RCIMUserInfoDataSource,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIImageView *iconV;
@property (nonatomic, strong) UITextView *infoTextV;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, weak) ZYAlertSView *alertView;
@property (nonatomic, weak) UIView *backClearView;
@property (nonatomic, assign) BOOL isPending;  // 审核模式
@property (nonatomic, strong) RCUserInfo *userInfo;//后台返回的医院医生信息
@property (nonatomic, strong) UITableView *tableView;//医生信息列表
@property (nonatomic, strong) NSMutableArray *dataSource;//医生信息列表数据源
@property (nonatomic, strong) NSDictionary *curruntSelectedDoctorInfo;//当前选中医生信息
@end

@implementation YYHospitalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.yyInfomationModel.hospitalName isEqualToString:@"Wan Yu Li Tong"]) {
        self.isPending = YES;
        self.title = @"详情";
    }else{
        self.title = @"医院详情";
    }
    self.view.backgroundColor = [UIColor whiteColor];

    
    [self createSomeViews];
//加载该医院医生列表
    [self loadDoctorListData];
    // Do any additional setup after loading the view.
}

-(void)createSomeViews{
    self.iconV = [[UIImageView alloc]init];
    self.iconV.image= [UIImage imageNamed:@"cell1"];
    
    [self createIconV];
    
    UILabel *hospital = [[UILabel alloc]init];
    if (self.isPending) {
        hospital.text = @"介绍";
    }else{
        hospital.text = @"医院介绍";
    }
    hospital.textColor = [UIColor colorWithHexString:@"333333"];
    hospital.font = [UIFont boldSystemFontOfSize:14];
    
    
    
    self.infoTextV = [[UITextView alloc]init];
//    self.infoTextV.backgroundColor = [UIColor cyanColor];
    self.infoTextV.editable = NO;
    self.infoTextV.delegate = self;
    self.infoTextV.font = [UIFont systemFontOfSize:14];
    self.infoTextV.textColor = [UIColor colorWithHexString:@"666666"];
    if (self.isPending) {
        self.infoTextV.text = @"万宇利通 联系方式 0312-3601032";
    }else{
        self.infoTextV.text = self.yyInfomationModel.introduction;
    }
    
//    UILabel *lineL = [[UILabel alloc]init];
//    lineL.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    
    UIButton *sureBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
//    sureBtn.layer.cornerRadius = 1.5 *kiphone6;
//    sureBtn.layer.borderWidth = 0.5 *kiphone6;
//    sureBtn.layer.borderColor = [UIColor colorWithHexString:@"25f368"].CGColor;
//    sureBtn.clipsToBounds = YES;
    if (self.isPending) {
//        [sureBtn setTitle:@"咨询" forState:UIControlStateNormal];
        sureBtn.hidden = YES;
    }else{
        [sureBtn setTitle:@"咨询" forState:UIControlStateNormal];
    }
    sureBtn.backgroundColor = [UIColor colorWithHexString:@"1ebeec"];
    [sureBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
//    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
//    [sureBtn addTarget:self action:@selector(buttonClick1:) forControlEvents:UIControlEventTouchDown];
    [sureBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:self.iconV];
    [self.view addSubview:hospital];
    [self.view addSubview:self.infoTextV];
    [self.view addSubview:sureBtn];
//    [self.view addSubview:lineL];
    _sureBtn = sureBtn;
    
    WS(ws);
    [ws.iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(64 *kiphone6H);
        make.left.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW,224 *kiphone6H));
    }];
    [hospital mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.iconV.mas_bottom).offset(10 *kiphone6H);
        make.left.equalTo(ws.view).offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(64 ,14 *kiphone6));
    }];

    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(44*kiphone6H);
        if (kScreenH >736) {
            make.bottom.offset(-34);
        }else{
            make.bottom.offset(0);
        }
        
    }];
//    [lineL mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(ws.view).with.offset(-49 *kiphone6);
//        make.centerX.equalTo(ws.view);
//        make.size.mas_equalTo(CGSizeMake(kScreenW *kiphone6 ,1 *kiphone6));
//    }];
    [ws.infoTextV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hospital.mas_bottom).offset(10 *kiphone6H);
        make.left.offset(10 *kiphone6);
        make.right.offset(-10 *kiphone6);
        make.bottom.offset(-44*kiphone6H);
    }];
    
    if (![self.yyInfomationModel.info_id isEqualToString:@""]) {
        [self.iconV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mPrefixUrl,self.yyInfomationModel.picture]]];
//        self.infoTextV.text = self.yyInfomationModel.introduction;
    }

    if(self.isPending){
        self.iconV.image= [UIImage imageNamed:@"cell1"];
    }
    
}
//添加图片上的透明view
- (void)createIconV{
    UIView *alphaView = [[UIView alloc]init];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.6;
    
    UILabel *hospitalLabel = [[UILabel alloc]init];
    hospitalLabel.text = @"涿州市中医院";
    hospitalLabel.textColor = [UIColor whiteColor];
    hospitalLabel.font = [UIFont fontWithName:kPingFang_S size:15];
    
    UILabel *starLabel =[[UILabel alloc]init];
    starLabel.text = @"三级甲等";
    starLabel.textColor = [UIColor whiteColor];
    starLabel.font = [UIFont fontWithName:kPingFang_S size:11];

    
    
    [self.iconV addSubview:alphaView];
    [alphaView addSubview:hospitalLabel];
    [alphaView addSubview:starLabel];
    
    [alphaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW ,40 *kiphone6H));
    }];
    [hospitalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(10 *kiphone6);
//        make.size.mas_equalTo(CGSizeMake(90  ,15 *kiphone6));
    }];
    [starLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.equalTo(hospitalLabel.mas_right).offset(15 *kiphone6);
//        make.size.mas_equalTo(CGSizeMake(90 *kiphone6 ,11 *kiphone6));
    }];
    
    if (![self.yyInfomationModel.info_id isEqualToString:@""]) {
        hospitalLabel.text = self.yyInfomationModel.hospitalName;
        starLabel.text = self.yyInfomationModel.grade;
    }
}
//请求医生信息
-(void)loadDoctorListData{
//    有咨询权限医生的列表
//http://59.110.169.148:8080/physician/doctory2.do?cid=1
    NSString *doctorListUrl = [NSString stringWithFormat:@"%@%@",mRCDoctorTokenUrl,self.yyInfomationModel.info_id];
    [[HttpClient defaultClient]requestWithPath:doctorListUrl method:0 parameters:nil prepareExecute:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSNumber *code = responseObject[@"code"];
        NSString *codeStr = [NSString stringWithFormat:@"%@",code];
        if ([codeStr isEqualToString:@"0"]) {
            NSArray *listArr = responseObject[@"physicianList"];
            for (NSDictionary *dic in listArr) {
                [self.dataSource addObject:dic];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];

}
#pragma mark -click
//咨询按钮点击
-(void)buttonClick{
    self.tableView.hidden = !self.tableView.hidden;
}
//选中医生后选择联系方式
-(void)didSelectedRow{
    //大蒙布View
    UIView *backClearView = [[UIView alloc]init];
    backClearView.backgroundColor = [UIColor colorWithHexString:@"#333333"];
    backClearView.alpha = 0.85;
    [self.view.window addSubview:backClearView];
    [backClearView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.offset(0);
    }];
    backClearView.userInteractionEnabled = YES;
    self.backClearView = backClearView;
    //叉号
    UIImage *image = [UIImage imageNamed:@"consult_close"];
    UIImageView *closeView = [[UIImageView alloc]init];
    closeView.image = image;
    [backClearView addSubview:closeView];
    [closeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10*kiphone6);
        make.top.offset(34*kiphone6);
        make.height.offset(image.size.height);
        make.width.offset(image.size.width);
    }];
    //添加tap手势：
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(event:)];
    //将手势添加至需要相应的view中
    [backClearView addGestureRecognizer:tapGesture];
    NSArray *nameList = @[@"语音",@"视频",@"文字咨询"];
    NSArray *iconList = @[@"consult_video",@"consult_Voice",@"consult_writing"];
    NSInteger peopleCount = 2;        // 人数
    for (int i = 0; i <= peopleCount ; i++) {
        CGFloat y_padding = 100 *kiphone6H;
        
        UIImage *image = [UIImage imageNamed:iconList[i]];
        UIImageView *btnView = [[UIImageView alloc]initWithFrame:CGRectMake(0,i *(y_padding+24*kiphone6H), 72*kiphone6H,  72*kiphone6H)];
        btnView.image = image;
        btnView.layer.cornerRadius = 36*kiphone6H;
        btnView.layer.masksToBounds = true;
        btnView.backgroundColor = [UIColor whiteColor];
        btnView.tag = 200 +i;
        btnView.userInteractionEnabled = true;
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapaClick:)];
        [btnView addGestureRecognizer:tapGest];
        
        
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
        nameLabel.font = [UIFont systemFontOfSize:15];
        nameLabel.text = nameList[i];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        //        if (i != 2) {
        //            UILabel *lineLabel = [[UILabel alloc]init];
        //            lineLabel.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
        //
        //            [btnView addSubview:lineLabel];
        //
        //            [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //                make.bottom.equalTo(btnView);
        //                make.left.equalTo(btnView);
        //                make.size.mas_equalTo(CGSizeMake(alertW,1));
        //            }];
        //
        //        }
        
        
        
        [backClearView addSubview:btnView];
        [backClearView addSubview:nameLabel];
        [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.offset(159*kiphone6H+i *(y_padding+24*kiphone6H));
            make.width.height.offset(72*kiphone6H);
        }];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(btnView);
            //            make.size.mas_equalTo(CGSizeMake(alertW,12));
            make.top.equalTo(btnView.mas_bottom).offset(10*kiphone6H);
        }];
    }

    
////    [button setBackgroundColor:[UIColor colorWithHexString:@"25f368"]];
//    
//    CGFloat alertW = 72 *kiphone6;
//    CGFloat alertH = 348 *kiphone6H;
//    
//    // 选项view
//    UIView *selectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, alertW, alertH)];
//    selectView.backgroundColor = [UIColor clearColor];
//    NSArray *nameList = @[@"语音咨询",@"视频咨询",@"文字咨询"];
//    NSArray *iconList = @[@"consult_video",@"consult_Voice",@"consult_writing"];
//    NSInteger peopleCount = 2;        // 人数
//    for (int i = 0; i <= peopleCount ; i++) {
//        CGFloat y_padding = 100 *kiphone6H;
//        
//        UIImage *image = [UIImage imageNamed:iconList[i]];
//        UIImageView *btnView = [[UIImageView alloc]initWithFrame:CGRectMake(0,i *(y_padding+24*kiphone6H), alertW,  72*kiphone6H)];
//        btnView.image = image;
//        btnView.backgroundColor = [UIColor whiteColor];
//        btnView.tag = 200 +i;
//        
//        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapaClick:)];
//        [btnView addGestureRecognizer:tapGest];
//        
//        
//        UILabel *nameLabel = [[UILabel alloc]init];
//        nameLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
//        nameLabel.font = [UIFont systemFontOfSize:15];
//        nameLabel.text = nameList[i];
//        nameLabel.textAlignment = NSTextAlignmentCenter;
////        if (i != 2) {
////            UILabel *lineLabel = [[UILabel alloc]init];
////            lineLabel.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
////            
////            [btnView addSubview:lineLabel];
////            
////            [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
////                make.bottom.equalTo(btnView);
////                make.left.equalTo(btnView);
////                make.size.mas_equalTo(CGSizeMake(alertW,1));
////            }];
////            
////        }
// 
// 
//        
//        [selectView addSubview:btnView];
//        [selectView addSubview:nameLabel];
//        
//        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(btnView);
////            make.size.mas_equalTo(CGSizeMake(alertW,12));
//            make.top.equalTo(btnView.mas_bottom).offset(10*kiphone6H);
//        }];
//    }
//    self.selectView = selectView;
//
//    ZYAlertSView *alertV = [[ZYAlertSView alloc]initWithContentSize:CGSizeMake(alertW, alertH) TitleView:nil selectView:selectView sureView:nil];
//    [alertV show];
//    self.alertView = alertV;
}
- (void)alertClick:(UIButton *)sender{
    if ([sender.currentTitle isEqualToString:@"取消"]) {
        [self.alertView dismiss:nil];
    }else{
        
    }
}
- (void)tapaClick:(UITapGestureRecognizer *)tapGesture{
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)tapGesture;
    NSInteger index = singleTap.view.tag -200;
    [self.backClearView removeFromSuperview];
    //    是否在发送的所有消息中携带当前登录的用户信息
    [[RCIM sharedRCIM] setEnableMessageAttachUserInfo:true];

    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    
    //把后台返回的医院医生信息赋值，以便在融云通过用户回调方法(RCIMUserInfoDataSource)去取医生信息，进而显示在接通前的界面
//    NSString *imageUrlStr = [NSString stringWithFormat:@"%@%@",mPrefixUrl,self.curruntSelectedDoctorInfo[@"Avatar"]];
    self.userInfo = [[RCUserInfo alloc]initWithUserId:self.curruntSelectedDoctorInfo[@"id"] name:self.curruntSelectedDoctorInfo[@"TrueName"] portrait:[NSString stringWithFormat:@"%@%@",mPrefixUrl,self.curruntSelectedDoctorInfo[@"Avatar"]]];
    
        YYWordsViewController *wordVC = [[YYWordsViewController alloc]init];
        //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
        wordVC.conversationType = ConversationType_PRIVATE;
        //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
        wordVC.targetId = self.curruntSelectedDoctorInfo[@"id"];
        //            NSLog(@"医院id =。%@",responseObject[@"id"]);
        if (index == 0) {
            
            wordVC.modalityVC = @"speech";
            
            
        }else if(index == 1){
            wordVC.modalityVC = @"av";
            
        }else{
            wordVC.modalityVC = @"empty";
        }
        [self.navigationController pushViewController:wordVC animated:YES];
    
    
    
    
    
//    [[HttpClient defaultClient]requestWithPath:[NSString stringWithFormat:@"%@%@",mRCDoctorTokenUrl,self.yyInfomationModel.info_id] method:0 parameters:nil prepareExecute:^{
//
//    } success:^(NSURLSessionDataTask *task, id responseObject) {
////        RCUserModel *userModel_rc = [RCUserModel defaultClient];
////        userModel_rc.token = responseObject[@"token"];
////        userModel_rc.Avatar = responseObject[@"Avatar"];
////        userModel_rc.TrueName = responseObject[@"TrueName"];
////        userModel_rc.info_id = responseObject[@"id"];
//
//        //把后台返回的医院医生信息赋值，以便在融云通过用户回调方法(RCIMUserInfoDataSource)去取医生信息，进而显示在接通前的界面
//        self.userInfo = [[RCUserInfo alloc]initWithUserId:responseObject[@"id"] name:@"医生" portrait:@"http://a3.qpic.cn/psb?/V10dl1Mt1s0RoL/qvT5ZwDSegULprXup78nlo3*XNUqCRH8shghIkAnQTs!/b/dLMAAAAAAAAA&bo=ewJ7AgAAAAADByI!&rf=viewer_4"];
//
//        if (!responseObject[@"id"]) {
//            [SVProgressHUD showInfoWithStatus:@"该医院暂未开放该功能"];
//        }else{
//            YYWordsViewController *wordVC = [[YYWordsViewController alloc]init];
//            //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
//            wordVC.conversationType = ConversationType_PRIVATE;
//            //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
//            wordVC.targetId = responseObject[@"id"];
////            NSLog(@"医院id =。%@",responseObject[@"id"]);
//            if (index == 0) {
//
//                wordVC.modalityVC = @"speech";
//
//
//            }else if(index == 1){
//                wordVC.modalityVC = @"av";
//
//            }else{
//                wordVC.modalityVC = @"empty";
//            }
//            [self.navigationController pushViewController:wordVC animated:YES];
//        }
//
//
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@",error);
//    }];

   }
//执行手势触发的方法：
- (void)event:(UITapGestureRecognizer *)gesture
{
    //移除view
    [gesture.view removeFromSuperview];

}
/**
 
 *此方法中要提供给融云用户的信息，建议缓存到本地，然后改方法每次从您的缓存返回
 
 */

#pragma mark - RCIMUserInfoDataSource

- (void)getUserInfoWithUserId:(NSString *)userId completion:(void(^)(RCUserInfo* userInfo))completion
{
    
    return completion(self.userInfo);
        
}

- (void)getUserInfoWithUserId:(NSString *)userId n:(void (^)(RCUserInfo *))completion
{
   return completion(self.userInfo);
}

/////////////////
- (void)emptyClick{
    CGFloat alertW = 335 *kiphone6;
    CGFloat alertH = 310 *kiphone6;
    
    // titleView
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, alertW, 80 *kiphone6)];
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"提示";
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    titleLabel.font = [UIFont systemFontOfSize:20];
    
    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    
    [titleView addSubview:titleLabel];
    [titleView addSubview:lineLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(titleView);
        make.size.mas_equalTo(CGSizeMake(120 ,20));
    }];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleView);
        make.bottom.equalTo(titleView);
        make.size.mas_equalTo(CGSizeMake(kScreenW ,1));
    }];
    // 选项view
    UIView *selectView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame), alertW, 170 *kiphone6)];
    
    UILabel *promptLabel = [[UILabel alloc]init];
    promptLabel.text = @"你还没有完善个人信息无法挂号，现在去完善?";
    promptLabel.textColor = [UIColor colorWithHexString:@"333333"];
    promptLabel.font = [UIFont systemFontOfSize:16];
    promptLabel.numberOfLines = 2;
    
    [selectView addSubview:promptLabel];
    [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(selectView);
        make.size.mas_equalTo(CGSizeMake(225 *kiphone6 ,40));
    }];
    
    // 取消确定view
    UIView *sureView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(selectView.frame), alertW, 60 *kiphone6)];
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(alertClick:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    
    [sureView addSubview:cancelBtn];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sureView);
        make.top.equalTo(sureView);
        make.size.mas_equalTo(CGSizeMake(alertW/2.0, 60 *kiphone6));
    }];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"去完善" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(alertClick:) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.backgroundColor = [UIColor colorWithHexString:@"25f368"];
    
    [sureView addSubview:sureBtn];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(sureView);
        make.top.equalTo(sureView);
        make.size.mas_equalTo(CGSizeMake(sureView.frame.size.width/2.0, 60 *kiphone6));
    }];
    
    
    
    ZYAlertSView *alertV = [[ZYAlertSView alloc]initWithContentSize:CGSizeMake(alertW, alertH) TitleView:titleView selectView:selectView sureView:sureView];
    [alertV show];
    self.alertView = alertV;
}


//-(void)buttonClick1:(UIButton *)button{
//    [button setBackgroundColor:[UIColor whiteColor]];
//    
//}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.backClearView removeFromSuperview];
}

#pragma - tableViewDelegate+datesource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"doctorlistCell" forIndexPath:indexPath];
    NSDictionary *dic = self.dataSource[indexPath.row];
    cell.textLabel.text = dic[@"TrueName"];
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mPrefixUrl,dic[@"Avatar"]]]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.curruntSelectedDoctorInfo = self.dataSource[indexPath.row];
    self.tableView.hidden = true;
    [self didSelectedRow];
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]init];
    header.backgroundColor = [UIColor whiteColor];
    UILabel *itemLabel = [UILabel labelWithText:@"医生列表" andTextColor:[UIColor blackColor] andFontSize:12];
    itemLabel.backgroundColor = [UIColor whiteColor];
    [header addSubview:itemLabel];
    [itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.bottom.top.offset(0);
        make.width.offset(100);
    }];
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor darkTextColor];
    line.alpha = 0.3;
    [header addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.bottom.right.offset(0);
        make.height.offset(0.5);
    }];
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
#pragma - 懒加载
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.indicatorStyle =
//        _tableView.rowHeight = kScreenW *77/320.0 +10;
        _tableView.rowHeight = 50;
        _tableView.estimatedRowHeight = UITableViewAutomaticDimension;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollEnabled = NO;
        _tableView.layer.borderColor = [UIColor blackColor].CGColor;
        _tableView.layer.borderWidth = 0.5;
        //        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"doctorlistCell"];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.offset(0);
            make.width.offset(kScreenW-100);
            make.height.offset(50*self.dataSource.count+50);
        }];
        [self.view bringSubviewToFront:_tableView];
        _tableView.hidden = true;
        
    }
    return _tableView;
}
- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return _dataSource;
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
