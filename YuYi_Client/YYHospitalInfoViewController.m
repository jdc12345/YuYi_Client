//
//  YYHospitalInfoViewController.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/23.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#define kHospitalText @"       河北省涿州市中医医院，位于北京经济圈的紧密层，距天安门仅六十二公里，医院创建于1984年，2008年底改制后注资2亿元进行扩建，是我市唯一一家国有并与北京中医药大学东直门医院、解放军307医院合作的集医疗、预防、保健、康复、科研、教学为一体的大型综合性中西医结合医院。医院占地面积30亩，正在建设中的医院大楼按三级医院标准建造设置，建筑面积45000平方米，开设床位501张，医院共设置临床、医技、行政等科室39个，计划今年底开业。目前，因医院扩建及业务发展需要，现向全国诚聘各类专业技术人才。\n       涿州市医院地处市中心范阳西路129号，市政府东侧，北京天桥至涿州的838路公共汽车通过门前，交通四通八达。医院占地50亩，建筑面积为11万平方米、开放床位1000张，全院职工1400人，专业技术人员900人。2009年医院投入2.6亿元兴建病房楼4.9万平方米。2011年医院又投入5亿元新建9.7万平方米的医技综合大楼，届时医院总建筑面积将达20万平方米。为了加快数字化医院建设，医院又投资近千万安装HIS系统。医院设有：骨科关节外科、脊柱外科、神经外科、普外胃肠外科、肝胆外科、泌尿外科、胸外科、心外科、腺体外科、妇科、产科、肿瘤科、放疗科、神经内科、呼吸内科、消化内科、内分泌科、心内科、肾内科、血液科、儿科、新生儿科、耳鼻喉科、口腔科、眼科、中医科、康复医学科、皮肤科、心理咨询门诊、急诊科、感染科、功能科、检验科、输血科、病理科、药剂科、介入室、内窥镜室、放疗科、等10个医技科室。涿州市医院投入近3亿元先后引进了10万元以上大型医疗设备139台，包括美国GE双层螺旋CT、日立全自动生化分析仪、德国西门子0.2T核磁共振成像系统（MGI ）和64排CT、瑞典医科达公司引进的用于放射性治疗恶性肿瘤的直线加速器。"
#import "YYHospitalInfoViewController.h"
#import "UIColor+Extension.h"
#import <Masonry.h>
#import "FMActionSheet.h"
#import "ZYAlertSView.h"
#import "YYSpeechViewController.h"
#import "YYAVViewController.h"
#import "YYWordsViewController.h"

@interface YYHospitalInfoViewController ()

@property (nonatomic, strong) UIImageView *iconV;
@property (nonatomic, strong) UITextView *infoTextV;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, weak) ZYAlertSView *alertView;
@property (nonatomic, weak) UIView *selectView;


@end

@implementation YYHospitalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"医院详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createSomeViews];
    // Do any additional setup after loading the view.
}

-(void)createSomeViews{
    self.iconV = [[UIImageView alloc]init];
    self.iconV.image= [UIImage imageNamed:@"cell1"];
    
    [self createIconV];
    
    
    
    UILabel *hospital = [[UILabel alloc]init];
    hospital.text = @"医院介绍";
    hospital.textColor = [UIColor colorWithHexString:@"333333"];
    hospital.font = [UIFont boldSystemFontOfSize:14];
    
    
    
    self.infoTextV = [[UITextView alloc]init];
//    self.infoTextV.backgroundColor = [UIColor cyanColor];
    self.infoTextV.editable = NO;
    self.infoTextV.delegate = self;
    self.infoTextV.font = [UIFont systemFontOfSize:12];
    self.infoTextV.textColor = [UIColor colorWithHexString:@"666666"];
    self.infoTextV.text = kHospitalText;
    
    UILabel *lineL = [[UILabel alloc]init];
    lineL.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    
    UIButton *sureBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    sureBtn.layer.cornerRadius = 1.5 *kiphone6;
    sureBtn.layer.borderWidth = 0.5 *kiphone6;
    sureBtn.layer.borderColor = [UIColor colorWithHexString:@"25f368"].CGColor;
    sureBtn.clipsToBounds = YES;
    [sureBtn setTitle:@"医患咨询" forState:UIControlStateNormal];
    sureBtn.backgroundColor = [UIColor whiteColor];
    [sureBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [sureBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [sureBtn addTarget:self action:@selector(buttonClick1:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:self.iconV];
    [self.view addSubview:hospital];
    [self.view addSubview:self.infoTextV];
    [self.view addSubview:sureBtn];
    [self.view addSubview:lineL];
    _sureBtn = sureBtn;
    
    WS(ws);
    [ws.iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view).with.offset(64 *kiphone6);
        make.left.equalTo(ws.view);
        make.size.mas_equalTo(CGSizeMake(kScreenW *kiphone6 ,225 *kiphone6));
    }];
    [hospital mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.iconV.mas_bottom).with.offset(10 *kiphone6);
        make.left.equalTo(ws.view).with.offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(64 *kiphone6 ,14 *kiphone6));
    }];

    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.view).with.offset(-9.5 *kiphone6);
        make.centerX.equalTo(ws.view);
        make.size.mas_equalTo(CGSizeMake(190 *kiphone6 ,30 *kiphone6));
    }];
    [lineL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.view).with.offset(-49 *kiphone6);
        make.centerX.equalTo(ws.view);
        make.size.mas_equalTo(CGSizeMake(kScreenW *kiphone6 ,1 *kiphone6));
    }];
    [ws.infoTextV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hospital.mas_bottom).with.offset(10 *kiphone6);
        make.left.equalTo(ws.view).with.offset(10 *kiphone6);
        make.right.equalTo(ws.view).with.offset(-10 *kiphone6);
        make.bottom.equalTo(lineL.mas_top);
    }];
    
}
- (void)createIconV{
    UIView *alphaView = [[UIView alloc]init];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.5;
    
    UILabel *hospitalLabel = [[UILabel alloc]init];
    hospitalLabel.text = @"涿州市中医院";
    hospitalLabel.textColor = [UIColor whiteColor];
    hospitalLabel.font = [UIFont fontWithName:kPingFang_S size:15];
    
    UILabel *starLabel =[[UILabel alloc]init];
    starLabel.text = @"三级甲等";
    starLabel.textColor = [UIColor whiteColor];
    starLabel.font = [UIFont fontWithName:kPingFang_S size:11];

    
    
    [self.iconV addSubview:alphaView];
    [self.iconV addSubview:hospitalLabel];
    [self.iconV addSubview:starLabel];
    
    WS(ws);
    [alphaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.iconV);
        make.left.equalTo(ws.iconV);
        make.size.mas_equalTo(CGSizeMake(kScreenW *kiphone6 ,40 *kiphone6));
    }];
    [hospitalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(alphaView.mas_bottom).with.offset(-12.5 *kiphone6);
        make.left.equalTo(alphaView.mas_left).with.offset(10 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(90 *kiphone6 ,15 *kiphone6));
    }];
    [starLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(alphaView.mas_centerY);
        make.left.equalTo(hospitalLabel.mas_right).with.offset(15 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(90 *kiphone6 ,11 *kiphone6));
    }];
    
}
-(void)buttonClick:(UIButton *)button{
    
    [button setBackgroundColor:[UIColor colorWithHexString:@"25f368"]];
    
    CGFloat alertW = 200 *kiphone6;
    CGFloat alertH = 135 *kiphone6;
    
    // 选项view
    UIView *selectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, alertW, alertH)];
    
    NSArray *nameList = @[@"语音咨询",@"视频咨询",@"文字咨询"];
    NSInteger peopleCount = 2;        // 人数
    for (int i = 0; i <= peopleCount ; i++) {
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
                make.bottom.equalTo(btnView);
                make.left.equalTo(btnView);
                make.size.mas_equalTo(CGSizeMake(alertW,1));
            }];
            
        }
 
 
        [btnView addSubview:nameLabel];
        
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(btnView);
            make.size.mas_equalTo(CGSizeMake(alertW,12));
        }];
        
        [selectView addSubview:btnView];
    }
    self.selectView = selectView;

    ZYAlertSView *alertV = [[ZYAlertSView alloc]initWithContentSize:CGSizeMake(alertW, alertH) TitleView:nil selectView:selectView sureView:nil];
    [alertV show];
    self.alertView = alertV;
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
    [self.alertView dismiss:nil];
    if (index == 0) {
        YYSpeechViewController *speechVC = [[YYSpeechViewController alloc]init];
        [self.navigationController pushViewController:speechVC animated:NO];
    }else if(index == 1){
        YYAVViewController *avVC = [[YYAVViewController alloc]init];
        [self.navigationController pushViewController:avVC animated:YES];
    }else{
        YYWordsViewController *wordVC = [[YYWordsViewController alloc]init];
        [self.navigationController pushViewController:wordVC animated:YES];
    }
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
    
    WS(ws);
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


-(void)buttonClick1:(UIButton *)button{
    [button setBackgroundColor:[UIColor whiteColor]];
    
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
