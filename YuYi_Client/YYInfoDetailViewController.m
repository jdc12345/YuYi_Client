//
//  YYInfoDetailViewController.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/27.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYInfoDetailViewController.h"
#import "HttpClient.h"
#import <UIImageView+WebCache.h>

#define UILABEL_LINE_SPACE 10
@interface YYInfoDetailViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *infomationS;

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *starLabel;
@property (nonatomic, strong) UILabel *introduceLabel;
@property (nonatomic, strong) UILabel *typeLabel;

@property (nonatomic, strong) NSDictionary *dic;//医院信息数据
@end

@implementation YYInfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.infomationS = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH -64)];
    self.infomationS.delegate = self;
    self.infomationS.contentOffset = CGPointMake(0, 0);
    self.infomationS.backgroundColor = [UIColor whiteColor];
    [self httpRequest];
    self.title = @"资讯详情";
    self.view.backgroundColor = [UIColor colorWithHexString:@"cccccc"];

    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.infomationS];
    ;
    // Do any additional setup after loading the view.
}
- (void)createSubView{
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cell1"]];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"涿州市中医院";
    titleLabel.font = [UIFont fontWithName:kPingFang_M size:18];
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    UILabel *detailLabel = [[UILabel alloc]init];
    detailLabel.text = @"三级甲等";
    detailLabel.font = [UIFont systemFontOfSize:15];
    detailLabel.textColor = [UIColor colorWithHexString:@"333333"];
    detailLabel.textAlignment = NSTextAlignmentCenter;
    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = [UIColor colorWithHexString:@"dadada"];
    
    UILabel *infoLabel = [[UILabel alloc]init];
    
    infoLabel.text = @"涿州市中医院";
    infoLabel.textColor = [UIColor colorWithHexString:@"333333"];
    infoLabel.font = [UIFont systemFontOfSize:14];
//    infoLabel.editable = NO;
    infoLabel.numberOfLines = 0;
    
    self.imageV = imageV;
    self.titleLabel = titleLabel;
    self.starLabel = detailLabel;
    self.introduceLabel = infoLabel;

//    
    [self.infomationS addSubview:imageV];
    [self.infomationS addSubview:titleLabel];
    [self.infomationS addSubview:detailLabel];
    [self.infomationS addSubview:lineLabel];
    [self.infomationS addSubview:infoLabel];
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mPrefixUrl,self.dic[@"picture"]]]];
    self.titleLabel.text = self.dic[@"title"];
    self.starLabel.text = self.dic[@"smallTitle"];
    self.introduceLabel.text = self.dic[@"content"];
//    self.typeLabel.text = self.dic[@"type"];
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infomationS).with.offset(0);
        make.left.equalTo(self.infomationS).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW ,210*kiphone6));
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageV.mas_bottom).with.offset(30 *kiphone6);
        make.left.offset(20 *kiphone6);
        make.right.offset(-20 *kiphone6);
        make.size.mas_equalTo(CGSizeMake(kScreenW -40 *kiphone6,18*kiphone6));
    }];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(20 *kiphone6);
        make.left.equalTo(titleLabel.mas_left);
        make.size.mas_equalTo(CGSizeMake(kScreenW -40 *kiphone6,15*kiphone6));
    }];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(detailLabel.mas_bottom).with.offset(25 *kiphone6);
        make.left.equalTo(titleLabel.mas_left).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW -20 *kiphone6,1*kiphone6));
    }];
    
    UIFont *font = [UIFont systemFontOfSize:14];
    // 调整行间距
    [self setLabelSpace:self.introduceLabel withValue:self.introduceLabel.text withFont:font];
    //获取文字内容高度
    CGFloat labelHeight = [self getSpaceLabelHeight:self.introduceLabel.text withFont:font withWidth:kScreenW-40*kiphone6];
    
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineLabel.mas_bottom).with.offset(20 *kiphone6);
        make.left.right.equalTo(titleLabel);
        make.height.offset(labelHeight+30);
        //scrollView不能滑动，因为系统虽然知道了各个子view的大小和相互之间的约束，但却不知道子view与scrollView之间的约束。也就是说，没法通过子view去计算scrollView的contentSize。修正的方法是加下边这一行代码
        make.bottom.equalTo(infoLabel.superview.mas_bottom).offset(-5);
    }];
    
}
//给UILabel设置行间距和字间距
-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = UILABEL_LINE_SPACE; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 34.0;//首行缩进
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;//行首缩进
    paraStyle.tailIndent = 0;//行尾缩进
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}
//计算UILabel的高度(带有行间距的情况)
-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = UILABEL_LINE_SPACE;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 34.0;//首行缩进
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;//行首缩进
    paraStyle.tailIndent = 0;//行尾缩进
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark ------------Http client----------------------
- (void)httpRequest{
    [[HttpClient defaultClient]requestWithPath:[NSString stringWithFormat:@"%@%@",mHomepageInfoDetail,self.info_id] method:0 parameters:nil prepareExecute:^{
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        self.dic = (NSDictionary*)responseObject[@"result"];
        [self createSubView];
//        [self.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mPrefixUrl,responseObject[@"picture"]]]];
//        self.titleLabel.text = responseObject[@"title"];
//        self.starLabel.text = responseObject[@"smalltitle"];
//        self.introduceLabel.text = responseObject[@"articleText"];
//        self.typeLabel.text = responseObject[@"type"];
//        [self.introduceLabel layoutIfNeeded];
//        self.infomationS.contentSize = CGSizeMake(kScreenW, CGRectGetMaxY(self.introduceLabel.frame));
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
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
