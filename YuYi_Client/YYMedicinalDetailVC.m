//
//  YYMedicinalDetailVC.m
//  电商
//
//  Created by 万宇 on 2017/2/22.
//  Copyright © 2017年 万宇. All rights reserved.
//

#import "YYMedicinalDetailVC.h"
#import "UIColor+colorValues.h"
#import "Masonry.h"
#import "YYConfirmVC.h"
#import "YYShopCartVC.h"
#import "YYOrderDetailVC.h"
static NSString *cellId = @"cell_id";
@interface YYMedicinalDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *preTexts;
@property(nonatomic,strong)NSArray *detailTexts;
@property(nonatomic,strong)NSMutableArray *btns;
//加减数量
@property(nonatomic,assign)NSInteger number;
//价格
@property(nonatomic,assign)NSInteger priceNumber;
@property(nonatomic,weak)UILabel *displayLabel;
//购物车商品详情
@property(nonatomic,strong)NSMutableArray *shopingCarDetails;
//选项View
@property(nonatomic,strong)UIView *optionView;
//立刻购买Btn
@property(nonatomic,strong)UIButton *buyBtn;
@end

@implementation YYMedicinalDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = true;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    self.navigationController.navigationBar.layer.masksToBounds = YES;// 去掉横线（没有这一行代码导航栏的最下面还会有一个横线）
    // 4、设置导航栏半透明
    self.navigationController.navigationBar.translucent = true;
    //为了去除子页面的返回按钮字样
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    //自定义右侧购物车按钮
    UIButton *rightButton = [[UIButton alloc]init];
    rightButton.frame = CGRectMake(0, 0, 44, 44);
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -15);
    [rightButton setImage:[UIImage imageNamed:@"shoppingcart"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(shoppingcar:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    [self loadData];
    [self setupUI];
}
//防止导航栏设置影响其他页面
-(void)viewWillAppear:(BOOL)animated{
    //把导航栏变透明
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.translucent = false;
    self.navigationController.navigationBar.layer.masksToBounds = false;
}
//shoppingcar点击事件
-(void)shoppingcar:(UIButton*)sender{
   YYShopCartVC *shopCartVC = [[YYShopCartVC alloc]init];
    [self.navigationController pushViewController:shopCartVC animated:true];
}
//加载数据
-(void)loadData{
    self.preTexts = @[@"产品名称:",@"药品分类:",@"包装大小:",@"药品商品名:",@"药品通用名:",@"批准文号:",@"生产企业:",@"品牌:",@"药品类型:",@"剂型:",@"适用人群:"];
    self.detailTexts = @[@"感冒灵颗粒",@"(非处方药)中成药",@"100",@"感冒灵颗粒",@"感冒灵颗粒",@"国药准字Z44021940",@"华润三九医药股份有限公司",@"999",@"中药",@"颗粒",@"不限"];
    self.shopingCarDetails = [NSMutableArray array];
}
//UI
-(void)setupUI{
    //添加头部图片视图
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.right.offset(0);
        make.height.offset(313);
    }];
    //图片
    UIImageView *imageView = [[UIImageView alloc]init];
    UIImage *image = [UIImage imageNamed:@"timg-8"];
    //记录药品图片
    [self.shopingCarDetails addObject:image];
    imageView.image = image;
    [headerView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.offset(240);
    }];
    //nameLabel
    UILabel *namelabel = [[UILabel alloc]init];
    namelabel.text = @"999感冒灵颗粒";
    //记录药品名称
    NSString *medicinalName = namelabel.text;
    [self.shopingCarDetails addObject:medicinalName];
    namelabel.font = [UIFont systemFontOfSize:17];
    namelabel.textColor = [UIColor colorWithHexString:@"6a6a6a"];
    [headerView addSubview:namelabel];
    [namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.equalTo(imageView.mas_bottom).offset(15);
    }];
    //priceLabel
    UILabel *priceLabel = [[UILabel alloc]init];
    //价格数字
    NSInteger priceNumber = 38;
    self.priceNumber = priceNumber;
    priceLabel.text = [NSString stringWithFormat:@"¥%ld",priceNumber];
    
    //记录药品价格
    NSNumber *medicinalPrice = [NSNumber numberWithInteger:self.priceNumber];
    [self.shopingCarDetails addObject:medicinalPrice];
    priceLabel.font = [UIFont systemFontOfSize:15];
    priceLabel.textColor = [UIColor colorWithHexString:@"e00610"];
    [headerView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.equalTo(namelabel.mas_bottom).offset(10);
    }];
    //详情view
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom).offset(10);
        make.left.right.bottom.offset(0);
    }];
    //行高
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 22;
    //去除分割线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    //底部button
    UIButton *shopCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:shopCarBtn];
    [shopCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.offset(0);
        make.height.offset(60);
        make.width.offset((self.view.frame.size.width-1)*0.5);
    }];
    [shopCarBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [shopCarBtn setTitleColor:[UIColor colorWithHexString:@"6a6a6a"] forState:UIControlStateNormal];
    shopCarBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    shopCarBtn.backgroundColor = [UIColor colorWithHexString:@"#6dfbca"];
    UIButton *buyBtn = [[UIButton alloc]init];
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    buyBtn.titleLabel.textColor = [UIColor colorWithHexString:@"6a6a6a"];
    buyBtn.backgroundColor = [UIColor colorWithHexString:@"#fcd186"];
    
    [self.view addSubview:buyBtn]; 
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.offset(0);
        make.height.offset(60);
        make.width.offset((self.view.frame.size.width-1)*0.5);
    }];
    //添加立即购买按钮的点击事件
    [buyBtn addTarget:self action:@selector(buyNow:) forControlEvents:UIControlEventTouchUpInside];
    //添加加入购物车按钮的点击事件
    [shopCarBtn addTarget:self action:@selector(shoppingcar:) forControlEvents:UIControlEventTouchUpInside];

}
//立即购买
-(void)buyNow:(UIButton*)sender{
    //大蒙布View
    UIView *buyView = [[UIView alloc]init];
    buyView.backgroundColor = [UIColor colorWithHexString:@"#333333"];
    buyView.alpha = 0.2;
    [self.view addSubview:buyView];
    [buyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.offset(0);
    }];
    buyView.userInteractionEnabled = YES;
    //添加tap手势：
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(event:)];
    //将手势添加至需要相应的view中
    [buyView addGestureRecognizer:tapGesture];

    //商品规格选项
    UIView *optionView = [[UIView alloc]init];
    optionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:optionView];
    self.optionView = optionView;
    [optionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.top.offset(self.view.frame.size.height-320);
    }];
    //imageView
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"timg-8"];
    [optionView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.offset(-40);
        make.height.offset(100);
        make.width.offset(100);
    }];
    //边框宽度
    [imageView.layer setBorderWidth:0.8];
    imageView.layer.borderColor=[UIColor colorWithHexString:@"#f3f3f3"].CGColor;
    //nameLabel
    UILabel *namelabel = [[UILabel alloc]init];
    namelabel.text = @"999感冒灵颗粒";
    namelabel.font = [UIFont systemFontOfSize:16];
    namelabel.textColor = [UIColor colorWithHexString:@"6a6a6a"];
    [optionView addSubview:namelabel];
    [namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).offset(15);
        make.top.offset(15);
    }];
    //priceLabel
    UILabel *priceLabel = [[UILabel alloc]init];
    //价格数字
    priceLabel.text = [NSString stringWithFormat:@"¥%ld",self.priceNumber];
    priceLabel.font = [UIFont systemFontOfSize:14];
    priceLabel.textColor = [UIColor colorWithHexString:@"e00610"];
    [optionView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).offset(15);
        make.top.equalTo(namelabel.mas_bottom).offset(7);
    }];
    //line1
    UIView *line = [[UIView alloc]init];
    [optionView addSubview:line];
    line.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.offset(-20);
        make.top.equalTo(imageView.mas_bottom).offset(20);
        make.height.offset(1);
    }];
    //line2
    UIView *line2 = [[UIView alloc]init];
    [optionView addSubview:line2];
    line2.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.offset(-20);
        make.top.equalTo(line.mas_bottom).offset(75);
        make.height.offset(1);
    }];
    //数量选项
    NSArray *numberOptions = @[@"24袋",@"38袋"];
    NSMutableArray *btns = [NSMutableArray array];
    for (int i = 0; i<numberOptions.count; i++) {
        UIButton *btn = [[UIButton alloc]init];
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
        //边框宽度
        [btn.layer setBorderWidth:0.8];
        btn.layer.borderColor=[UIColor colorWithHexString:@"999999"].CGColor;
        [btn setTitle:numberOptions[i]   forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"999999"]
                  forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:12.3]];
        [optionView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(75);
            make.height.offset(35);
        }];
        [btns addObject:btn];
        //添加button的点击事件
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(numberOptionClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    self.btns = btns;
    if (numberOptions.count==1) {
        UIButton *oneBtn = btns[0];
        [oneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(20);
            make.top.equalTo(line.mas_bottom).offset(20);
        }];
    }
    if (numberOptions.count==2) {
        UIButton *oneBtn = btns[0];
        UIButton *twoBtn = btns[1];
        [oneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(20);
            make.top.equalTo(line.mas_bottom).offset(20);
        }];
        
        [twoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneBtn.mas_right).offset(15);
            make.top.equalTo(oneBtn);
        }];
    }
    if (numberOptions.count==3) {
        for (int i = 0; i < 3; i++) {
            if (i<2) {
                UIButton* currentBtn = btns[i];
                UIButton* nextBtn = btns[i + 1];
                [btns[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(line.mas_bottom).offset(20);
                }];
                if (i == 0) { // 如果是第一个需要设置左边
                    [currentBtn mas_makeConstraints:^(MASConstraintMaker* make) {
                        make.left.offset(20);
                    }];
                }
                
                [nextBtn mas_makeConstraints:^(MASConstraintMaker* make) {
                    // 后一个的左边 和 前一个的右边 一样
                    make.left.equalTo(currentBtn.mas_right).offset(15);
                }];
            }
            if (i==2) {
                UIButton* twoBtn = btns[i - 1];
                [btns[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(twoBtn.mas_right).offset(15);
                    make.top.equalTo(line.mas_bottom).offset(20);
                    
                }];
            }
        }
    }
    //buyNumber购买数量
    UILabel *buyNumberLabel = [[UILabel alloc]init];
    buyNumberLabel.text = @"购买数量";
    buyNumberLabel.textColor = [UIColor colorWithHexString:@"999999"];
    buyNumberLabel.font = [UIFont systemFontOfSize:13];
    [optionView addSubview:buyNumberLabel];
    [buyNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.equalTo(line2.mas_bottom).offset(40);
    }];
    //plusBtn
    UIButton *plusBtn = [[UIButton alloc]init];
    [plusBtn setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    //边框宽度
    [plusBtn.layer setBorderWidth:0.8];
    plusBtn.layer.borderColor=[UIColor colorWithHexString:@"e4e4e4"].CGColor;
    [optionView addSubview:plusBtn];
    [plusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.top.equalTo(line2.mas_bottom).offset(40);
        make.width.height.offset(30);
    }];
    //
    [plusBtn addTarget:self action:@selector(plus) forControlEvents:UIControlEventTouchUpInside];
    //displayNumberLabel
    NSInteger number = 1;
    self.number = number;
    UILabel *displayNumberLabel = [[UILabel alloc]init];
    displayNumberLabel.text = [NSString stringWithFormat:@"%ld",self.number] ;
    displayNumberLabel.font = [UIFont systemFontOfSize:17];
     self.displayLabel = displayNumberLabel;
    displayNumberLabel.textAlignment = NSTextAlignmentCenter;
    
    //边框宽度
    [displayNumberLabel.layer setBorderWidth:0.8];
    displayNumberLabel.layer.borderColor=[UIColor colorWithHexString:@"e4e4e4"].CGColor;
    [optionView addSubview:displayNumberLabel];
    [displayNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(plusBtn.mas_left);
        make.top.equalTo(plusBtn);
        make.width.height.offset(30);
    }];
    //minusBtn
    UIButton *minusBtn = [[UIButton alloc]init];
    [minusBtn setImage:[UIImage imageNamed:@"minus"] forState:UIControlStateNormal];
    //边框宽度
    [minusBtn.layer setBorderWidth:0.8];
    minusBtn.layer.borderColor=[UIColor colorWithHexString:@"e4e4e4"].CGColor;
    [optionView addSubview:minusBtn];
    [minusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(displayNumberLabel.mas_left);
        make.top.equalTo(plusBtn);
        make.width.height.offset(30);
    }];
    //
    [minusBtn addTarget:self action:@selector(minus) forControlEvents:UIControlEventTouchUpInside];
    //buyNowButton
    UIButton *buyNowButton = [[UIButton alloc]init];
    [buyNowButton setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyNowButton setTitleColor:[UIColor colorWithHexString:@"6a6a6a"] forState:UIControlStateNormal];
    buyNowButton.titleLabel.font = [UIFont systemFontOfSize:18];
    buyNowButton.backgroundColor = [UIColor colorWithHexString:@"#fcd186"];
    [self.view addSubview:buyNowButton];
    self.buyBtn = buyNowButton;
    [buyNowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.offset(60);
    }];
    //添加立即购买按钮的点击事件
    [buyNowButton addTarget:self action:@selector(buyNowWithOptions:) forControlEvents:UIControlEventTouchUpInside];

    }
//跳转确认购买页面
-(void)buyNowWithOptions:(UIButton*)sender{
    YYConfirmVC *conVC = [[YYConfirmVC alloc]init];
    conVC.shopingCarDetails = self.shopingCarDetails;
    conVC.number = self.number;
    [self.navigationController pushViewController:conVC animated:true];
}
//药品数量加减
-(void)plus{
    self.number+=1;
    self.displayLabel.text = [NSString stringWithFormat:@"%ld",self.number];
}
-(void)minus{
    self.number-=1;
    if (self.number<0) {
        self.number = 0;
    }
    self.displayLabel.text = [NSString stringWithFormat:@"%ld",self.number];
}
//选择数量规格
-(void)numberOptionClick:(UIButton*)sender{
    [sender setTitleColor:[UIColor colorWithHexString:@"25f368"]  forState:UIControlStateNormal];
    sender.layer.borderColor=[UIColor colorWithHexString:@"25f368"].CGColor;
    for (int i = 0; i<self.btns.count; i++) {
        UIButton *btn = self.btns[i];
        if (sender.tag != btn.tag) {
            [btn setTitleColor:[UIColor colorWithHexString:@"999999"]  forState:UIControlStateNormal];
            btn.layer.borderColor=[UIColor colorWithHexString:@"999999"].CGColor;
            
        }
    }
    //换到个人信息订单详情页面
    [self.navigationController pushViewController:[[YYOrderDetailVC alloc]init] animated:true];
}
//执行手势触发的方法：
- (void)event:(UITapGestureRecognizer *)gesture
{
    //移除view
    [gesture.view removeFromSuperview];
    [self.optionView removeFromSuperview];
    [self.buyBtn removeFromSuperview];
    }
#pragma tableviewDelegate,datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",self.preTexts[indexPath.row],self.detailTexts[indexPath.row]];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"6a6a6a"];
    [cell.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.offset(0);
        make.bottom.offset(10);
    }];
    cell.userInteractionEnabled = false;
    return cell;
}
//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 22;
}
//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
//商品详情
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    UILabel *lable = [[UILabel alloc]init];
    lable.text = @"商品详情";
    lable.font = [UIFont systemFontOfSize:15];
    lable.textColor = [UIColor colorWithHexString:@"25f368"];
    [view addSubview:lable];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(20);
        make.bottom.offset(0);
    }];
    return view;
}

@end
