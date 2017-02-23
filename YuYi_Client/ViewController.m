//
//  ViewController.m
//  电商
//
//  Created by 万宇 on 2017/1/5.
//  Copyright © 2017年 万宇. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+colorValues.h"
#import "Masonry.h"
#import "searchBar.h"
#import "YYflowLay.h"
#import "YYCollectionViewCell.h"
#import "headerTitleBtn.h"
//#import "YYAllMedicinalViewController.h"
//#import "YYMedicinalDetailVC.h"

static NSString* cellid = @"business_cell";
@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"医药商城";
    self.automaticallyAdjustsScrollViewInsets = NO;
     [self.navigationController.navigationBar    setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"333333"],NSFontAttributeName:[UIFont systemFontOfSize:17.0f]}];
//        UIImage *backButtonImage = [[UIImage imageNamed:@"back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
//        [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
        [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"back"]];
        [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back"]];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithHexString:@"333333"]];
    //添加配送范围标题
    UILabel *psLabel = [[UILabel alloc]init];
    [self.view addSubview:psLabel];
    [psLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(0);
        make.height.offset(20);
    }];
    [psLabel setBackgroundColor:[UIColor colorWithHexString:@"#25f368"]];
    [psLabel setText:@"目前只支持涿州市区范围"];
    psLabel.textAlignment = NSTextAlignmentCenter;
    [psLabel setTextColor:[UIColor colorWithHexString:@"ffffff"]];
    [psLabel setFont:[UIFont systemFontOfSize:12]];
    //添加搜索框
    searchBar *searchBtn = [[searchBar alloc]init];
    [self.view addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.offset(-20);
        make.top.equalTo(psLabel.mas_bottom).offset(10);
        make.height.offset(40);
    }];
    searchBtn.backgroundColor = [UIColor colorWithHexString:@"#f3f3f3"];

    [searchBtn setTitleColor:[UIColor colorWithHexString:@"aaa9a9"] forState:UIControlStateNormal];
    [searchBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
//    [button addTarget:self action:@selector(childButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    NSDictionary *dict = arr[i];
    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateHighlighted];
    [searchBtn setTitle:@"搜索所有药品" forState:UIControlStateNormal];
    //添加药品分类按钮
    NSArray *nameArray = @[@"中药调理",@"肠胃用药",@"保健滋补",@"眼鼻喉耳",@"皮肤用药",@"全部"];
    NSMutableArray *classBtn = [NSMutableArray array];
    for (int i = 0; i<6; i++) {
        UIButton *btn = [[UIButton alloc]init];
        [btn.layer setMasksToBounds:YES];
        [btn.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
        //边框宽度
        [btn.layer setBorderWidth:0.8];
        btn.layer.borderColor=[UIColor colorWithHexString:@"#f3f3f3"].CGColor;
        [btn setTitle:nameArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"6a6a6a"]
                  forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(105);
            make.height.offset(39);
        }];
        [classBtn addObject:btn];
        //添加button的点击事件
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(medicinalClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }

    for (int i = 0; i < 3; i++) {
        if (i<2) {
            UIButton* currentBtn = classBtn[i];
            UIButton* nextBtn = classBtn[i + 1];
            [classBtn[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(searchBtn.mas_bottom).offset(10);
            }];
            if (i == 0) { // 如果是第一个需要设置左边
                [currentBtn mas_makeConstraints:^(MASConstraintMaker* make) {
                    make.left.offset(20);
                }];
            }
            
            [nextBtn mas_makeConstraints:^(MASConstraintMaker* make) {
                // 后一个的左边 和 前一个的右边 一样
                make.left.equalTo(currentBtn.mas_right).offset(10);
            }];
        }
        if (i==2) {
            UIButton* twoBtn = classBtn[i - 1];
            [classBtn[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(twoBtn.mas_right).offset(10);
                make.top.equalTo(searchBtn.mas_bottom).offset(10);
                
            }];
        }
        
    }
    for (int i = 3; i < 6; i++) {
        if (i<5) {
            UIButton* currentBtn = classBtn[i];
            UIButton* nextBtn = classBtn[i + 1];
            [classBtn[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(searchBtn.mas_bottom).offset(59);
            }];
            if (i == 3) { // 如果是第一个需要设置左边
                [currentBtn mas_makeConstraints:^(MASConstraintMaker* make) {
                    make.left.offset(20);
                }];
            }
            
            [nextBtn mas_makeConstraints:^(MASConstraintMaker* make) {
                // 后一个的左边 和 前一个的右边 一样
                make.left.equalTo(currentBtn.mas_right).offset(10);
            }];
        }
        if (i==5) {
            UIButton* fourBtn = classBtn[i - 1];
            [classBtn[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(fourBtn.mas_right).offset(10);
                 make.top.equalTo(searchBtn.mas_bottom).offset(59);
            }];
        }
    }
    //添加分割view
    UIView *sepView = [[UIView alloc]init];
    [self.view addSubview:sepView];
    sepView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    [sepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(183);
        make.left.right.offset(0);
        make.height.offset(10);
    }];
    //添加药品模块
    [self addMedicinals];
}
//添加药品模块
-(void)addMedicinals{
    // 创建流水布局
    YYflowLay* layout = [[YYflowLay alloc] init];
    
    // 创建集合视图
    UICollectionView* collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    
    // 注册单元格
    [collectionView registerClass:[YYCollectionViewCell class] forCellWithReuseIdentifier:cellid];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
    // 取消指示器(滚动条)
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.pagingEnabled = YES;
    
    // 设置背景颜色
    collectionView.backgroundColor = [UIColor whiteColor];
    
    // 设置数据源
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    // 添加视图
    [self.view addSubview:collectionView];
    
    // 设置自动布局
    [collectionView mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.offset(193);
        make.left.right.offset(0);
        make.bottom.offset(0);
        
    }];

}
//药品点击事件
-(void)medicinalClick:(UIButton*)btn{
//    if (btn.tag == 105) {
//        [self.navigationController pushViewController:[[YYAllMedicinalViewController alloc]init] animated:true];
//    }
}
#pragma collectionViewDatasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    
    NSLog(@"cellForItemAtIndexPath");
    YYCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    
    //    cell.xxxxx = 数组[indexPath.row];
//    cell.businessType = self.buinessTypeData[indexPath.row];
    
        // 设置随机颜色 测试
//        cell.backgroundColor = [UIColor redColor];
    
    return cell;
}
//
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    NSArray *kinds = @[@"常用药品",@"滋补调养"];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        header.backgroundColor = [UIColor whiteColor];
        headerTitleBtn *button = [[headerTitleBtn alloc]init];
        button.frame = header.bounds;
        [button setTitle:kinds[indexPath.section]  forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"6a6a6a"] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        UIView *line = [[UIView alloc]init];
        [button addSubview:line];
        line.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.offset(0);
            make.height.offset(1);
        }];
//        [button addTarget:self action:sel_registerName("doOpen:") forControlEvents:UIControlEventTouchUpInside];
//        button.tag = 1000 + indexPath.section;
//        for (UIView *view in header.subviews) {
//            [view removeFromSuperview];
//        } // 防止复用分区头
        [header addSubview:button];
        return header;
    } else if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        footer.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        return footer;
    }else{
        return nil;
    }
}
//点击药品cell
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //传药品的详情
//   YYCollectionViewCell *cell = (YYCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
//    YYMedicinalDetailVC *mdVC = [[YYMedicinalDetailVC alloc]init];
//    [self.navigationController pushViewController:mdVC animated:true];
    

}
//
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}


@end
