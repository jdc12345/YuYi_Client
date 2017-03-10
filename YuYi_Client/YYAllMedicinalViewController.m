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
static NSString* allMedicinalCellid = @"allMedicinal_cell";
static NSString* classificationCellid = @"classification_cell";
@interface YYAllMedicinalViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
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


@end

@implementation YYAllMedicinalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部药品";
    self.view.backgroundColor = [UIColor whiteColor];
    [self addAllMedicinalCollectionView];
    //加载数据
    [self loadData];
}
//
-(void)loadData{
    self.groupTitles = @[@"常用",@"肠胃用药",@"滋补调养",@"女性用药",@"风湿骨病"];
    self.detailTitles = @[@[@"常用",@"肠胃用药",@"滋补调养",@"女性用药",@"风湿骨病",@"肠胃用药",@"滋补调养",@"女性用药"],@[@"常用",@"肠胃用药",@"滋补调养",@"女性用药",@"风湿骨病",@"肠胃用药",@"滋补调养",@"女性用药"],@[@"常用",@"肠胃用药",@"滋补调养",@"女性用药"],@[@"滋补调养",@"女性用药",@"风湿骨病",@"肠胃用药",@"滋补调养",@"女性用药"],@[@"常用",@"肠胃用药",@"滋补调养",@"女性用药"]];
    
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
        return self.groupTitles.count;
    }
    
}
- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView==self.collectionView) {
        return 8;
    }else{
        NSArray *titles = self.detailTitles[section];
        return titles.count;
    }

}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{    
    if (collectionView==self.collectionView) {
        YYAllMedicinalCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:allMedicinalCellid forIndexPath:indexPath];

        
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
        NSArray *titles = self.detailTitles[indexPath.section];
        [titleBtn setTitle:titles[indexPath.row] forState:UIControlStateNormal];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [titleBtn setTitleColor:[UIColor colorWithHexString:@"6a6a6a"]
                  forState:UIControlStateNormal];
        //item上button点击事件
        [titleBtn addTarget:self action:@selector(clickClassItem:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;

    }
    }
//全部分类页面分类按钮点击事件
-(void)clickClassItem:(UIButton*)sender{
    self.selectionBtn.titleLabel.text = sender.titleLabel.text;
    [self packup:self.button];

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
        [selectionBtn setTitle:@"常用药品"  forState:UIControlStateNormal];
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
            UILabel *titleLabel = [[UILabel alloc]init];
            for (UIView *view in classHeader.subviews) {
            [view removeFromSuperview];
            } // 防止复用分区头
            [classHeader addSubview:titleLabel];
            titleLabel.text = self.groupTitles[indexPath.section];
            titleLabel.font = [UIFont systemFontOfSize:13];
            titleLabel.textColor = [UIColor colorWithHexString:@"6a6a6a"];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.offset(10);
            }];

            return classHeader;

        }else{
            return nil;
        }
}
}
//分类按钮open点击事件
-(void)doOpen:(UIButton*)sender{
    self.flag = false;
   
    if (self.flag == false) {
         [sender setImage:[UIImage imageNamed:@"pack_up"] forState:UIControlStateNormal];
         [sender addTarget:self action:@selector(packup:) forControlEvents:UIControlEventTouchUpInside];
        //防止重复添加
        if (self.classificationView == nil) {
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
 
       }
}
//分类按钮packup点击事件
-(void)packup:(UIButton*)sender{
    self.flag = true;
    [sender setImage:[UIImage imageNamed:@"open"] forState:UIControlStateNormal];
    [sender addTarget:self action:@selector(doOpen:) forControlEvents:UIControlEventTouchUpInside];
    [self.classificationView removeFromSuperview];
    [self.lineView removeFromSuperview];
}
//
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
