//
//  YYConfirmVC.m
//  电商
//
//  Created by 万宇 on 2017/2/23.
//  Copyright © 2017年 万宇. All rights reserved.
//

#import "YYConfirmVC.h"
#import "UIColor+colorValues.h"
#import "Masonry.h"

@interface YYConfirmVC ()
@property(nonatomic,weak)UIView *line;
//收货信息三个label
@property(nonatomic,strong)NSArray *preArr;
@property(nonatomic,strong)NSArray *infoArr;
//
@property(nonatomic,weak)UIImageView *medicinalImage;
@end

@implementation YYConfirmVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认付款";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar    setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"333333"],NSFontAttributeName:[UIFont systemFontOfSize:17.0f]}];
    self.navigationController.navigationBar.layer.masksToBounds = false;// 去掉横线（没有这一行代码导航栏的最下面还会有一个横线）
    //line1
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height-2, self.view.frame.size.width, 2)];
    [self.navigationController.navigationBar addSubview:line];
    self.line = line;
    line.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    [self loadData];
    [self setupUI];

}
-(void)loadData{
    self.preArr = @[@"收货人:",@"详细地址:",@"联系电话:"];
    self.infoArr = @[@"LIM&LIM:",@"北京市 朝阳区***** ***",@"184*********"];
}
//UI布局
- (void)setupUI {
  //收货信息
    //lowView
    UIView *lowView = [[UIView alloc]init];
    lowView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lowView];
    [lowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(64);
        make.left.bottom.right.offset(0);
    }];
    //titleLabel
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"收货信息";
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textColor = [UIColor colorWithHexString:@"999999"];
    [lowView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(20);
    }];
    NSMutableArray *labArr = [NSMutableArray array];
    for (int i=0; i<3; i++) {
        UILabel *label = [[UILabel alloc]init];
        label.text = [NSString stringWithFormat:@"%@ %@",self.preArr[i],self.infoArr[i]];
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor colorWithHexString:@"333333"];
        label.numberOfLines = 2;
        [lowView addSubview:label];
        if (i==0) {
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(20);
                make.top.equalTo(titleLabel.mas_bottom).offset(10);
            }];
        }
        if (i==1) {
            UILabel *lab1 = labArr[0];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(20);
                make.top.equalTo(lab1.mas_bottom).offset(10);
            }];
        }
        if (i==2) {
            UILabel *lab2 = labArr[1];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(20);
                make.top.equalTo(lab2.mas_bottom).offset(10);
            }];
        }
        [labArr addObject:label];
    }
    //地址编辑editBtn按钮
    UIButton *editBtn = [[UIButton alloc]init];
    [editBtn setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    [lowView addSubview:editBtn];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.top.offset(20);
        make.width.height.offset(30);
    }];
    [editBtn addTarget:self action:@selector(addressEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    //line1
    UIView *line = [[UIView alloc]init];
    [lowView addSubview:line];
    line.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    UILabel *label3 = labArr[2];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.offset(-20);
        make.top.equalTo(label3.mas_bottom).offset(20);
        make.height.offset(1);
    }];
    //药品图片
    UIImageView *medicinalImage = [[UIImageView alloc]init];
    UIImage *im = self.shopingCarDetails[0];
    [medicinalImage setImage:im];
    [lowView addSubview:medicinalImage];
   
    [medicinalImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(20);
        make.left.offset(20);
        make.width.height.offset(75);
    }];
//     self.medicinalImage = medicinalImage;
    medicinalImage = self.medicinalImage;

    //line2
    UIView *line2 = [[UIView alloc]init];
    [lowView addSubview:line2];
    line2.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.offset(-20);
        make.top.equalTo(line.mas_bottom).offset(115);
        make.height.offset(1);
    }];
    //line3
    UIView *line3 = [[UIView alloc]init];
    [lowView addSubview:line3];
    line3.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.offset(-20);
        make.top.equalTo(line2.mas_bottom).offset(55);
        make.height.offset(1);
    }];

}
//地址编辑按钮点击事件
-(void)addressEditBtn:(UIButton*)sender{
    NSLog(@"此处跳转地址编辑页面-----");
}
//传递药品详情

//-(void)setShopingCarDetails:(NSMutableArray *)shopingCarDetails{
//    _shopingCarDetails = shopingCarDetails;
//    UIImage *image = shopingCarDetails[0];
//    [self.medicinalImage setImage:image];
//    
//}
//移除导航栏下边线
-(void)viewWillDisappear:(BOOL)animated{
    [self.line removeFromSuperview];

}

@end
