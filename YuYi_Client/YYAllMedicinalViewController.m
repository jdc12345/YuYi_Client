//
//  YYAllMedicinalViewController.m
//  电商
//
//  Created by 万宇 on 2017/2/21.
//  Copyright © 2017年 万宇. All rights reserved.
//

#import "YYAllMedicinalViewController.h"
#import "YYAllMedicinalFlowLayout.h"
#import "YYAllMedicinalCollectionViewCell.h"
#import "UIColor+colorValues.h"
#import "Masonry.h"
#import "YYAllMedicinalTitleBtn.h"
#import "YYClassificationFlowLayout.h"
#import "YYModel.h"
#import "HttpClient.h"
#import "YYMedinicalDetailModel.h"
#import "YYMedicinalDetailVC.h"
#import "YYCategoryModel.h"


static NSString* allMedicinalCellid = @"allMedicinal_cell";
static NSString* classificationCellid = @"classification_cell";
@interface YYAllMedicinalViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
//商城首页药品分类按钮数据
@property (nonatomic,strong) NSArray<YYMedinicalDetailModel *> *categoryArr;
@property (nonatomic,strong) NSArray<YYCategoryModel *> *bigCategoryArr;
//分类按钮图标切换
@property(nonatomic,assign)BOOL flag;
//全部视图
@property(nonatomic,weak)UICollectionView * collectionView;
//分类头部试图
@property(nonatomic,weak)UICollectionReusableView *header;
//分类视图
@property(nonatomic,weak)UICollectionView * classificationView;
//
@property(nonatomic,weak)UIView * lineView;
//组标题数据
@property(nonatomic,strong)NSArray *groupTitles;
//具体分类详情标题数据
@property(nonatomic,strong)NSArray *detailTitles;
//分类头部左侧按钮
@property(nonatomic,weak)UIButton *selectionBtn;
//分类头部右侧按钮
@property(nonatomic,weak)UIButton *button;
//大组数据Id
@property(nonatomic,copy)NSString *bigCategoryId;
//小组数据Id
@property(nonatomic,copy)NSString *smallCategoryId;



@end

@implementation YYAllMedicinalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部药品";
    self.view.backgroundColor = [UIColor whiteColor];
    //加载数据
    [self loadData];
}
//
-(void)loadData{
//    self.groupTitles = @[@"常用",@"肠胃用药",@"滋补调养",@"女性用药",@"风湿骨病"];
//    self.detailTitles = @[@[@"常用",@"肠胃用药",@"滋补调养",@"女性用药",@"风湿骨病",@"肠胃用药",@"滋补调养",@"女性用药"],@[@"常用",@"肠胃用药",@"滋补调养",@"女性用药",@"风湿骨病",@"肠胃用药",@"滋补调养",@"女性用药"],@[@"常用",@"肠胃用药",@"滋补调养",@"女性用药"],@[@"滋补调养",@"女性用药",@"风湿骨病",@"肠胃用药",@"滋补调养",@"女性用药"],@[@"常用",@"肠胃用药",@"滋补调养",@"女性用药"]];
    NSString *urlString = [NSString string];
    if ([self.id isEqualToString:@"106"]) {
        urlString = allCategoryBtnInfo;
//         urlString = @"http://192.168.1.55:8080/yuyi/drugs/findall.do?start=0&limit=10";
    }else{
        urlString = [otherCategoryBtnsInfo stringByAppendingString:[NSString stringWithFormat:@"%@&start=0&limit=10",self.id]];
//        urlString = [NSString stringWithFormat:@"http://192.168.1.55:8080/yuyi/drugs/getcid1.do?cid1=%@&start=0&limit=10",self.id];
    }
    HttpClient *httpManager = [HttpClient defaultClient];
    [httpManager requestWithPath:urlString method:HttpRequestGet parameters:nil prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *categoryArr = ((NSDictionary*)responseObject)[@"rows"];
        self.categoryArr = [NSArray yy_modelArrayWithClass:[YYMedinicalDetailModel class] json:categoryArr];
        [self addAllMedicinalCollectionView];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        return ;
    }];

}
//添加全部药品collectionView
-(void)addAllMedicinalCollectionView{
    // 创建流水布局
    YYAllMedicinalFlowLayout* layout = [[YYAllMedicinalFlowLayout alloc] init];
    
    // 创建集合视图
    UICollectionView* collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView = collectionView;
    
    // 注册单元格
    [collectionView registerClass:[YYAllMedicinalCollectionViewCell class] forCellWithReuseIdentifier:allMedicinalCellid];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
    // 取消指示器(滚动条)
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.pagingEnabled = YES;
    
    // 设置背景颜色
    collectionView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    
    // 设置数据源
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    // 添加视图
    [self.view addSubview:collectionView];
    
    // 设置自动布局
    [collectionView mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.left.right.offset(0);
        make.bottom.offset(0);
        
    }];

    
}
#pragma collectionViewDatasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (collectionView==self.collectionView) {
        return 1;
    }else{
        return self.bigCategoryArr.count;
    }
    
}
- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView==self.collectionView) {
        return self.categoryArr.count;
    }else{
        YYCategoryModel *model = self.bigCategoryArr[section];
        NSArray *smallArr = model.children;
        return smallArr.count;
    }

}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{    
    if (collectionView==self.collectionView) {
        YYAllMedicinalCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:allMedicinalCellid forIndexPath:indexPath];
        YYMedinicalDetailModel *model = self.categoryArr[indexPath.row];
        cell.model = model;
        return cell;

    }else{
        UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:classificationCellid forIndexPath:indexPath];
        UIButton *titleBtn = [[UIButton alloc]init];
        [titleBtn.layer setMasksToBounds:YES];
        [titleBtn.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
        //边框宽度
        [titleBtn.layer setBorderWidth:0.8];
        titleBtn.layer.borderColor=[UIColor colorWithHexString:@"#f3f3f3"].CGColor;
        [cell.contentView addSubview:titleBtn];
        titleBtn.frame = cell.contentView.frame;
        //取出大类的model
        YYCategoryModel *model = self.bigCategoryArr[indexPath.section];
        NSArray *smallArr = model.children;
        YYCategoryModel *smallModel = [[YYCategoryModel alloc]init];
        NSDictionary *dic = smallArr[indexPath.row];
        
         [smallModel setValuesForKeysWithDictionary:dic];

        [titleBtn setTitle:smallModel.name forState:UIControlStateNormal];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [titleBtn setTitleColor:[UIColor colorWithHexString:@"6a6a6a"]
                  forState:UIControlStateNormal];
        //传递小类id
        titleBtn.tag = [smallModel.id intValue];
        //item上button点击事件
        [titleBtn addTarget:self action:@selector(clickClassItem:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;

    }
    }
//点击cell跳转
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.collectionView) {
        //传药品的详情
        YYAllMedicinalCollectionViewCell *cell = (YYAllMedicinalCollectionViewCell*)[collectionView  cellForItemAtIndexPath:indexPath];
        YYMedicinalDetailVC *mdVC = [[YYMedicinalDetailVC alloc]init];
        mdVC.id = cell.model.id;
        [self.navigationController pushViewController:mdVC animated:true];
    }
    
}
//全部分类页面分类按钮点击事件
-(void)clickClassItem:(UIButton*)sender{
    self.selectionBtn.titleLabel.text = sender.titleLabel.text;
    [self packup:self.button];
//    NSString *urlString = [NSString stringWithFormat:@"http://192.168.1.55:8080/yuyi/drugs/getcid2.do?cid2=%ld&start=0&limit=10",sender.tag];
    NSString *urlString = [smallCategoryInfo stringByAppendingString:[NSString stringWithFormat:@"%ld&start=0&limit=10",sender.tag]];
    HttpClient *httpManager = [HttpClient defaultClient];
    [httpManager requestWithPath:urlString method:HttpRequestGet parameters:nil prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *categoryArr = ((NSDictionary*)responseObject)[@"rows"];
        self.categoryArr = [NSArray yy_modelArrayWithClass:[YYMedinicalDetailModel class] json:categoryArr];
        [self.collectionView reloadData];
        [self.classificationView removeFromSuperview];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        return ;
    }];
    self.categoryName = sender.titleLabel.text;

    NSLog(@"-------此处更改全部药品页面数据源");
}
//添加头部试图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    //判断collectionView
    if (collectionView == self.collectionView) {
    NSArray *kinds = @[@"全部分类"];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        self.header = header;
        header.backgroundColor = [UIColor whiteColor];
        
        //添加右侧分类按钮
            YYAllMedicinalTitleBtn *button = [[YYAllMedicinalTitleBtn alloc]init];
        self.button = button;
            [button setTitle:kinds[indexPath.section]  forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"open"] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
            UIView *line = [[UIView alloc]init];
            [header addSubview:line];
            line.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.offset(0);
                make.height.offset(1);
            }];
            //设定flag初始值
            self.flag = true;
            if (self.flag) {
                [button addTarget:self action:sel_registerName("doOpen:") forControlEvents:UIControlEventTouchUpInside];
            }
            
            //        button.tag = 1000 + indexPath.section;
            for (UIView *view in header.subviews) {
                        [view removeFromSuperview];
                    } // 防止复用分区头
            [header addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.right.bottom.offset(0);
                make.width.offset(100);
            }];
        //添加左侧选中分类按钮
        YYAllMedicinalTitleBtn *selectionBtn = [YYAllMedicinalTitleBtn buttonWithType:UIButtonTypeCustom];
        [selectionBtn.layer setMasksToBounds:YES];
        [selectionBtn.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
        //边框宽度
        [selectionBtn.layer setBorderWidth:0.8];
        selectionBtn.layer.borderColor=[UIColor colorWithHexString:@"25F368"].CGColor;
//        [selectionBtn setTitle:@"常用药品"  forState:UIControlStateNormal];
        [selectionBtn setTintColor:[UIColor colorWithHexString:@"25F368"] ];
        [selectionBtn setImage:[UIImage imageNamed:@"close_classify"] forState:UIControlStateNormal];
        [selectionBtn setTitleColor:[UIColor colorWithHexString:@"25F368"] forState:UIControlStateNormal];
        
        [selectionBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [header addSubview:selectionBtn];
        [selectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.width.offset(85);
            make.centerY.equalTo(button.mas_centerY);
        }];
        self.selectionBtn = selectionBtn;
        [self.selectionBtn setTitle:self.categoryName forState:UIControlStateNormal];
        return header;
    } else{
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
       
        return footer;
    }
    }else{
        if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
            kind = @"UICollectionElementKindSectionHeader";
        }
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            UICollectionReusableView *classHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader        withReuseIdentifier:@"header" forIndexPath:indexPath];

            classHeader.backgroundColor = [UIColor whiteColor];

            UIButton *titleBtn = [[UIButton alloc]init];
            for (UIView *view in classHeader.subviews) {
            [view removeFromSuperview];
            } // 防止复用分区头
            [classHeader addSubview:titleBtn];
            YYCategoryModel *model = self.bigCategoryArr[indexPath.section];
            [titleBtn setTitle:model.name forState:UIControlStateNormal];
            titleBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            [titleBtn setTitleColor:[UIColor colorWithHexString:@"6a6a6a"] forState:UIControlStateNormal];
            [titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.offset(10);
            }];
            //传递大组id
            titleBtn.tag = [model.id intValue];
            [titleBtn addTarget:self action:@selector(updateDataSource:) forControlEvents:UIControlEventTouchUpInside];

            return classHeader;

        }else{
            return nil;
        }
}
}
//分类按钮open点击事件
-(void)updateDataSource:(UIButton*)sender{
    
//    NSString *urlString = [NSString stringWithFormat:@"http://192.168.1.55:8080/yuyi/drugs/getcid1.do?cid1=%ld&start=0&limit=10",sender.tag];
    NSString *urlString = [bigCategoryInfo stringByAppendingString:[NSString stringWithFormat:@"%ld&start=0&limit=10",sender.tag]];
    HttpClient *httpManager = [HttpClient defaultClient];
    [httpManager requestWithPath:urlString method:HttpRequestGet parameters:nil prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *categoryArr = ((NSDictionary*)responseObject)[@"rows"];
        self.categoryArr = [NSArray yy_modelArrayWithClass:[YYMedinicalDetailModel class] json:categoryArr];
        [self.collectionView reloadData];
        [self.classificationView removeFromSuperview];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        return ;
    }];
    self.categoryName = sender.titleLabel.text;

}
//分类按钮open点击事件
-(void)doOpen:(UIButton*)sender{
    self.flag = false;
   
    if (self.flag == false) {
         [sender setImage:[UIImage imageNamed:@"pack_up"] forState:UIControlStateNormal];
         [sender addTarget:self action:@selector(packup:) forControlEvents:UIControlEventTouchUpInside];
        //防止重复添加
        if (self.classificationView == nil) {
//            NSString *urlString = @"http://192.168.1.55:8080/yuyi/category/listAllTree.do";
            NSString *urlString = categorysInfo;
            HttpClient *httpManager = [HttpClient defaultClient];
            [httpManager requestWithPath:urlString method:HttpRequestGet parameters:nil prepareExecute:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                NSArray *bigCategoryArr = ((NSDictionary*)responseObject)[@"category"];
                self.bigCategoryArr = [NSArray yy_modelArrayWithClass:[YYCategoryModel class] json:bigCategoryArr];
                [self addCategoryCollectionView];

            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                return ;
            }];
        }
 
       }
}
//添加分类collectionView
-(void)addCategoryCollectionView{
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor whiteColor];
    self.lineView = lineView;
    // 创建流水布局
    YYClassificationFlowLayout* layout = [[YYClassificationFlowLayout alloc] init];
    
    // 创建集合视图
    UICollectionView* classificationView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.classificationView = classificationView;
    // 注册单元格
    [classificationView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:classificationCellid];
    [classificationView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    //    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
    // 取消指示器(滚动条)
    classificationView.showsVerticalScrollIndicator = NO;
    classificationView.showsHorizontalScrollIndicator = NO;
    classificationView.pagingEnabled = YES;
    
    // 设置背景颜色
    classificationView.backgroundColor = [UIColor whiteColor];
    
    // 设置数据源
    classificationView.dataSource = self;
    classificationView.delegate = self;
    
    // 添加视图
    [self.view addSubview:classificationView];
    [self.view addSubview:lineView];
    // 设置自动布局
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.header.mas_bottom);
        make.left.right.offset(0);
        make.height.offset(10);
    }];
    [classificationView mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.equalTo(lineView.mas_bottom);
        make.left.right.offset(0);
        make.bottom.offset(0);
        
    }];
}
//分类按钮packup点击事件
-(void)packup:(UIButton*)sender{
    self.flag = true;
    [sender setImage:[UIImage imageNamed:@"open"] forState:UIControlStateNormal];
    [sender addTarget:self action:@selector(doOpen:) forControlEvents:UIControlEventTouchUpInside];
    [self.classificationView removeFromSuperview];
    [self.lineView removeFromSuperview];
}


@end
