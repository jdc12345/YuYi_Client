//
//  YYRecoderAnalysisTVCell.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/9/28.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYRecoderAnalysisTVCell.h"
#import "YYRecardTableViewCell.h"
#import "UILabel+Addition.h"

@interface YYRecoderAnalysisTVCell()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *empBackView;//空页面背景
@end
@implementation YYRecoderAnalysisTVCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];//[UIColor colorWithHexString:@"#f6f6f6"];
        [self createDetailView];
    }
    return self;
}
- (void)createDetailView{
    //加载空页面
    [self loadEmptyView];
    //加载tableview
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
}
  //加载空页面
-(void)loadEmptyView{
    UIView *empBackView = [[UIView alloc]init];
    empBackView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:empBackView];
    [empBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
    self.empBackView = empBackView;
    UIImageView *emptyView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nothing"]];
    [empBackView addSubview:emptyView];
    [emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
    UILabel *noticelabel = [UILabel labelWithText:@"这里什么都没有" andTextColor:[UIColor colorWithHexString:@"bababa"] andFontSize:15];
    [empBackView addSubview:noticelabel];
    [noticelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(emptyView.mas_bottom).offset(30*kiphone6);
        make.centerX.equalTo(emptyView);
    }];
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.indicatorStyle =
        _tableView.rowHeight = kScreenW *77/320.0 +10;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[YYRecardTableViewCell class] forCellReuseIdentifier:@"YYRecardTableViewCell"];
        [self.contentView addSubview:_tableView];
        
    }
    return _tableView;
}
#pragma mark -
#pragma mark ------------Tableview Delegate----------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RecardModel *recardModel = self.recoderData[indexPath.row];
    self.recoderCellClick(recardModel);
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}
#pragma mark -
#pragma mark ------------TableView DataSource----------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.recoderData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 85 *kiphone6H;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYRecardTableViewCell *homeTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"YYRecardTableViewCell" forIndexPath:indexPath];
    RecardModel *recardModel = self.recoderData[indexPath.row];
    homeTableViewCell.model = recardModel;
    
    return homeTableViewCell;
    
}

-(void)setRecoderData:(NSMutableArray *)recoderData{
    _recoderData = recoderData;
    if (recoderData.count>0) {
        self.tableView.hidden = false;
        self.empBackView.hidden = true;
    }else{
        self.tableView.hidden = true;
        self.empBackView.hidden = false;
    }
    [self.tableView reloadData];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
