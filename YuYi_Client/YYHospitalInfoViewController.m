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

@interface YYHospitalInfoViewController ()

@property (nonatomic, strong) UIImageView *iconV;
@property (nonatomic, strong) UITextView *infoTextV;
@property (nonatomic, strong) UIButton *sureBtn;


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
    FMActionSheet *sheet = [[FMActionSheet alloc] initWithTitle:@""
                                                   buttonTitles:[NSArray arrayWithObjects:@"语音咨询",@"视频咨询",@"文字咨询",nil]
                                              cancelButtonTitle:@""
                                                       delegate:(id<FMActionSheetDelegate>)self];
    sheet.titleFont = [UIFont systemFontOfSize:20];
    sheet.titleBackgroundColor = [UIColor colorWithHexString:@"f4f5f8"];
    sheet.titleColor = [UIColor colorWithHexString:@"666666"];
    sheet.lineColor = [UIColor colorWithHexString:@"dbdce4"];
    [sheet showWithFrame:CGRectMake((kScreenW - 200 *kiphone6)/2.0, (kScreenH - 135 *kiphone6)/2.0, 200 *kiphone6, 135 *kiphone6)];
    [button setBackgroundColor:[UIColor colorWithHexString:@"25f368"]];
    
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
