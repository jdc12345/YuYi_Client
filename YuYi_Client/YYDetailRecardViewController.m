//
//  YYDetailRecardViewController.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/24.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYDetailRecardViewController.h"
#import "YYHomeNewTableViewCell.h"
//#import "YYSectionViewController.h"
#import "YYPersonalTableViewCell.h"
#import "YYRecardTableViewCell.h"
#import "YYPInfomationTableViewCell.h"
#import "HttpClient.h"
#import "CcUserModel.h"
#import "RecardDetailModel.h"
#import <MJExtension.h>
#import "YYMedicalRecoderPhotoFlowLayout.h"
#import "YYMedicalRecoderPhotoDisplayCVCell.h"
#import <UIImageView+WebCache.h>
#import "HUPhotoBrowser.h"

static NSString* collectionCellid = @"collection_cell";
static NSString* photoCellid = @"photo_cell";
@interface YYDetailRecardViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
//@property (nonatomic, strong) NSArray *iconList;
//@property (nonatomic, strong) RecardDetailModel *dataModel;
@property(nonatomic,strong)NSArray *imagesArr;
@property(nonatomic,strong)NSMutableArray *urlStrs;
@property(nonatomic,weak)UICollectionView *collectionView;
@end

@implementation YYDetailRecardViewController

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10*kiphone6, 0, kScreenW-20*kiphone6, kScreenH) style:UITableViewStylePlain];
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
- (NSMutableArray *)urlStrs{
    if (_urlStrs == nil) {
        _urlStrs = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return _urlStrs;
}
- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc]initWithCapacity:2];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"病例查看";
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    
    self.dataSource = [[NSMutableArray alloc]initWithArray:@[@"就诊时间",@"就诊医院",@"就诊科室",@"就诊医生"]];
}
- (UIView *)personInfomation{
    UIView *personV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 262 *kiphone6)];
    personV.backgroundColor = [UIColor whiteColor];
    NSInteger collectionViewH = 0;//collectionView高度
    if (![self.model.picture isEqualToString:@""]) {
        NSArray *array = [self.model.picture componentsSeparatedByString:@";"];
        NSMutableArray *arr = [NSMutableArray arrayWithArray:array];
        [arr removeLastObject];
        self.imagesArr = arr;
        for (int i=0; i<arr.count; i++) {
            NSString *urlStr = [NSString stringWithFormat:@"%@%@",mPrefixUrl,arr[i]];
            [self.urlStrs addObject:urlStr];
        }
        if (self.imagesArr.count<5 && self.imagesArr.count>0) {//一排图片
            personV.frame = CGRectMake(0, 0, kScreenW, 262 *kiphone6H+(kScreenW-85*kiphone6)/3);
            collectionViewH = (kScreenW-85*kiphone6)/3;
            
            }else if (self.imagesArr.count>4 && self.imagesArr.count<9){//俩排图片
            personV.frame = CGRectMake(0, 0, kScreenW, 262 *kiphone6H+(kScreenW-45*kiphone6)/3*2+15*kiphone6H);
            collectionViewH = (kScreenW-85*kiphone6)/3*2+15*kiphone6H;

        }
    }else{//0图片
        personV.frame = CGRectMake(0, 0, kScreenW, 282 *kiphone6H);
        collectionViewH = 0;

    }
   
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(10 *kiphone6, 15 *kiphone6H, kScreenW -40*kiphone6, 232 *kiphone6)];
    headerView.backgroundColor = [UIColor colorWithHexString:@"f0f8fa"];
    
    [personV addSubview:headerView];
    
    //
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"病例内容";
    nameLabel.textColor = [UIColor colorWithHexString:@"666666"];
    nameLabel.font = [UIFont systemFontOfSize:14];
    //
    
    UITextView *textView = [[UITextView alloc]init];
    textView.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0);
    textView.backgroundColor = [UIColor clearColor];
    textView.text = self.model.medicalrecord;
    textView.textColor = [UIColor colorWithHexString:@"333333"];
    textView.font = [UIFont systemFontOfSize:13];
    textView.editable = NO;
    [headerView addSubview:textView];
    [headerView addSubview:nameLabel];
    
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(10 *kiphone6H);
    }];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(15 *kiphone6H);
        make.left.offset(10 *kiphone6);
        make.right.offset(-10*kiphone6);
        make.bottom.offset(-48*kiphone6H);
    }];
    
    //photoCollectionView
    UICollectionView *photoCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[[YYMedicalRecoderPhotoFlowLayout alloc]init]];
    [personV addSubview:photoCollectionView];
    self.collectionView = photoCollectionView;
    photoCollectionView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    photoCollectionView.dataSource = self;
    photoCollectionView.delegate = self;
    // 注册单元格
    [photoCollectionView registerClass:[YYMedicalRecoderPhotoDisplayCVCell class] forCellWithReuseIdentifier:photoCellid];
    photoCollectionView.bounces = false;
    photoCollectionView.scrollEnabled = false;
    photoCollectionView.showsHorizontalScrollIndicator = false;
    photoCollectionView.showsVerticalScrollIndicator = false;
    [photoCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom).offset(15*kiphone6H);
        make.left.offset(10*kiphone6);
        make.right.offset(-10*kiphone6);
        make.height.offset(collectionViewH);
    }];
    
    return personV;
}

#pragma mark -
#pragma mark ------------Tableview Delegate----------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    [self.navigationController pushViewController:[[YYSectionViewController alloc]init] animated:YES];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark -
#pragma mark ------------TableView DataSource----------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 48 *kiphone6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10 *kiphone6;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 10)];
    headerView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    
    return headerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYPInfomationTableViewCell *homeTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"YYPInfomationTableViewCell" forIndexPath:indexPath];
    
    homeTableViewCell.titleLabel.text = self.dataSource[indexPath.row];
    switch (indexPath.row) {
        case 0:
        {
            NSString *time = [self.model.createTimeString substringToIndex:10];
            homeTableViewCell.seeRecardLabel.text = time;
        }
            break;
        case 1:
            homeTableViewCell.seeRecardLabel.text = self.model.hospitalName;
            break;
        case 2:
            homeTableViewCell.seeRecardLabel.text = self.model.departmentName;
            break;
        case 3:
            homeTableViewCell.seeRecardLabel.text = self.model.physicianName?self.model.physicianName:@"未记录";
            break;
        default:
            break;
    }
    
    return homeTableViewCell;
    
}
#pragma mark -
#pragma mark ------------collectionView DataSource----------------------
#pragma mark - UICollectionView
// 有多少行
- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imagesArr.count;
}

// cell内容
- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    // 去缓存池找
    YYMedicalRecoderPhotoDisplayCVCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:photoCellid forIndexPath:indexPath];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",mPrefixUrl,self.imagesArr[indexPath.row]];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    return cell;
    
}
// cell点击事件
- (void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath*)indexPath
{
    YYMedicalRecoderPhotoDisplayCVCell *cell = (YYMedicalRecoderPhotoDisplayCVCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    [HUPhotoBrowser showFromImageView:cell.imageView withURLStrings:self.urlStrs placeholderImage:[UIImage imageNamed:@"icon"] atIndex:indexPath.row dismiss:nil];
    
}



#pragma mark -
#pragma mark ------------setModel----------------------
-(void)setModel:(RecardModel *)model{
    _model = model;
    self.tableView.tableFooterView = [self personInfomation];
}
//- (void)httpRequest{
//    [[HttpClient defaultClient]requestWithPath:[NSString stringWithFormat:@"%@%@",mMedicalDetail,self.recardID] method:0 parameters:nil prepareExecute:^{
//        
//    } success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@",responseObject);
////        NSArray *array = responseObject;
//        NSDictionary *dict = responseObject;
//        self.dataModel = [RecardDetailModel mj_objectWithKeyValues:dict];
//        self.tableView.tableFooterView = [self personInfomation];
////        [self.tableView reloadData];
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//    }];
//}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
