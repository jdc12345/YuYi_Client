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

@interface YYConfirmVC ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,weak)UIView *line;
//收货信息三个label
@property(nonatomic,strong)NSArray *preArr;
@property(nonatomic,strong)NSArray *infoArr;
//即时，预约送btn
@property(nonatomic,weak)UIButton *nowSendBtn;
@property(nonatomic,weak)UIButton *preSendBtn;
//日期、时间
@property(nonatomic,strong)NSArray *proDateList;
@property(nonatomic,strong)NSArray *proTimeList;
@property(nonatomic,weak)UILabel *dayLabel;
@property(nonatomic,weak)UILabel *timeLabel;
//pickView
@property(nonatomic,weak)UIPickerView *pickView;

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
    NSArray *proDateList = [[NSArray alloc]initWithObjects:@"今天",@"明天",nil];
    NSArray *proTimeList = [[NSArray alloc]initWithObjects:@"8:00", @"8:30",@"9:00",@"9:30",@"10:00",@"10:30",@"11:00",@"11:30",@"12:00",@"12:30",@"13:00",@"13:30",@"14:00", @"14:30",@"15:00",@"15:30",@"16:00",@"16:30",@"17:00",@"17:30",@"18:00",nil];
    self.proDateList = proDateList;
    self.proTimeList = proTimeList;
    
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
    //priceLabel
    UILabel *priceLabel = [[UILabel alloc]init];
    NSNumber *pn = self.shopingCarDetails[2];
    NSString *ps = [NSString stringWithFormat:@"%@",pn];
    priceLabel.text = ps;
    priceLabel.font = [UIFont systemFontOfSize:14];
    priceLabel.textColor = [UIColor colorWithHexString:@"e00610"];
    [lowView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(medicinalImage.mas_right).offset(10);
        make.bottom.equalTo(medicinalImage);
    }];
    //药品名称
    UILabel *namelabel = [[UILabel alloc]init];
    namelabel.text = self.shopingCarDetails[1];
    namelabel.font = [UIFont systemFontOfSize:14];
    namelabel.textColor = [UIColor colorWithHexString:@"6a6a6a"];
    [lowView addSubview:namelabel];
    [namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(priceLabel);
        make.bottom.equalTo(priceLabel.mas_top).offset(-10);
    }];
    //数量label
    UILabel *numberLabel = [[UILabel alloc]init];
    NSInteger i = self.number;
    numberLabel.text = [NSString stringWithFormat:@"X %ld",i];
    numberLabel.font = [UIFont systemFontOfSize:14];
    numberLabel.textColor = [UIColor colorWithHexString:@"6a6a6a"];
    [lowView addSubview:numberLabel];
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.bottom.equalTo(priceLabel.mas_bottom);
    }];
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
    UILabel *allLabel = [[UILabel alloc]init];
    allLabel.text = @"总计";
    allLabel.font = [UIFont systemFontOfSize:15];
    allLabel.textColor = [UIColor colorWithHexString:@"6a6a6a"];
    [lowView addSubview:allLabel];
    [allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.equalTo(line2.mas_bottom).offset(20);
    }];
    
    UILabel *allNumberLabel = [[UILabel alloc]init];
    allNumberLabel.text = [NSString stringWithFormat:@"共%ld件",i];
    allNumberLabel.font = [UIFont systemFontOfSize:12];
    allNumberLabel.textColor = [UIColor colorWithHexString:@"6a6a6a"];
    [lowView addSubview:allNumberLabel];
    [allNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(allLabel);
        make.centerX.equalTo(self.view);
    }];
    UILabel *allpriceLabel = [[UILabel alloc]init];
    allpriceLabel.text = [NSString stringWithFormat:@"¥%ld",i*[pn integerValue]];
    allpriceLabel.font = [UIFont systemFontOfSize:12];
    allpriceLabel.textColor = [UIColor colorWithHexString:@"6a6a6a"];
    [lowView addSubview:allpriceLabel];
    [allpriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(allLabel);
        make.right.offset(-20);
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
    //即时送药
    UIButton *nowSendBtn = [[UIButton alloc]init];
    [nowSendBtn setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
    [lowView addSubview:nowSendBtn];
    self.nowSendBtn = nowSendBtn;
    [nowSendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3.mas_bottom).offset(35);
        make.left.offset(20);
    }];
    [nowSendBtn addTarget:self action:@selector(nowSend:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *nowSendLabel = [[UILabel alloc]init];
    nowSendLabel.text = @"即时送药（1小时极速送药）";
    nowSendLabel.font = [UIFont systemFontOfSize:15];
    nowSendLabel.textColor = [UIColor colorWithHexString:@"6a6a6a"];
    [lowView addSubview:nowSendLabel];
    [nowSendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nowSendBtn);
        make.left.equalTo(nowSendBtn.mas_right).offset(10);
    }];
    //预约送药
    UIButton *preSendBtn = [[UIButton alloc]init];
    [preSendBtn setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
    [lowView addSubview:preSendBtn];
    self.preSendBtn = preSendBtn;
    [preSendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nowSendBtn.mas_bottom).offset(35);
        make.left.offset(20);
    }];
    [preSendBtn addTarget:self action:@selector(preSend:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *preSendLabel = [[UILabel alloc]init];
    preSendLabel.text = @"预约送药";
    preSendLabel.font = [UIFont systemFontOfSize:15];
    preSendLabel.textColor = [UIColor colorWithHexString:@"6a6a6a"];
    [lowView addSubview:preSendLabel];
    [preSendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(preSendBtn);
        make.left.equalTo(preSendBtn.mas_right).offset(10);
    }];
    //时间label
    UILabel *dayLabel = [[UILabel alloc]init];
    dayLabel.textAlignment = NSTextAlignmentCenter;
    dayLabel.text = @"今天";
    dayLabel.font = [UIFont systemFontOfSize:14];
    dayLabel.textColor = [UIColor colorWithHexString:@"6a6a6a"];
    [dayLabel.layer setBorderWidth:0.8];
    dayLabel.layer.borderColor=[UIColor colorWithHexString:@"e4e4e4"].CGColor;
    [lowView addSubview:dayLabel];
    [dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(preSendBtn);
        make.left.equalTo(preSendLabel.mas_right).offset(10);
        make.width.offset(40);
        make.height.offset(26);
    }];
    self.dayLabel = dayLabel;
    //时刻label
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.text = @"8:00";
    timeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.textColor = [UIColor colorWithHexString:@"6a6a6a"];
    [timeLabel.layer setBorderWidth:0.8];
    timeLabel.layer.borderColor=[UIColor colorWithHexString:@"e4e4e4"].CGColor;
    [lowView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(preSendBtn);
        make.left.equalTo(dayLabel.mas_right).offset(3);
        make.width.offset(60);
        make.height.offset(26);
    }];
    self.timeLabel = timeLabel;
    //选择时间selectTimeBtn
    UIButton *selectTimeBtn = [[UIButton alloc]init];
    [selectTimeBtn setImage:[UIImage imageNamed:@"moreTime"] forState:UIControlStateNormal];
    [lowView addSubview:selectTimeBtn];
    [selectTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeLabel);
        make.left.equalTo(timeLabel.mas_right).offset(10);
    }];
    [selectTimeBtn addTarget:self action:@selector(selectTime:) forControlEvents:UIControlEventTouchUpInside];
    //添加pickView
    UIPickerView *pickView = [[UIPickerView alloc]init];
    [lowView addSubview:pickView];
    //隐藏pickView
    self.pickView = pickView;
    self.pickView.hidden = true;
    [pickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(preSendBtn.mas_bottom).offset(10);
        make.left.right.offset(0);
        make.bottom.offset(-60);
    }];
    pickView.dataSource = self;
    pickView.delegate = self;
    pickView.showsSelectionIndicator = YES;
    //确认订单order
    UIButton *orderBtn = [[UIButton alloc]init];
    orderBtn.backgroundColor = [UIColor colorWithHexString:@"#fcd186"];
    [orderBtn setTitle:@"确认付款" forState:UIControlStateNormal];
    orderBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [lowView addSubview:orderBtn];
    [orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(60);
        make.left.bottom.right.offset(0);
    }];
    
}
#pragma - mark pickView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [self.proDateList count];
    }
    
    return [self.proTimeList count];
}

#pragma Mark -- UIPickerViewDelegate
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    if (component == 1) {
        return 100;
    }
    return 100;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        NSString  *_proNameStr = [self.proDateList objectAtIndex:row];
        self.dayLabel.text = _proNameStr;
    } else {
        NSString  *_proTimeStr = [self.proTimeList objectAtIndex:row];
        self.timeLabel.text = _proTimeStr;
    }

}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [self.proDateList objectAtIndex:row];
    } else {
        return [self.proTimeList objectAtIndex:row];
        
    }
}
#pragma - btn点击事件
//地址编辑按钮点击事件
-(void)addressEditBtn:(UIButton*)sender{
    NSLog(@"此处跳转地址编辑页面-----");
}
//选择送药方式nowSendBtn点击事件
-(void)nowSend:(UIButton*)sender{
    UIImage *unImage = [UIImage imageNamed:@"unselected"];
    UIImage *seImage = [UIImage imageNamed:@"Selected"];
    if ([sender.imageView.image isEqual:unImage] ) {
        [sender setImage:seImage forState:UIControlStateNormal];
        [self.preSendBtn setImage:unImage forState:UIControlStateNormal];
    }else{
         [sender setImage:unImage forState:UIControlStateNormal];
    }
    
}
//选择送药方式preSendBtn点击事件
-(void)preSend:(UIButton*)sender{
    UIImage *unImage = [UIImage imageNamed:@"unselected"];
    UIImage *seImage = [UIImage imageNamed:@"Selected"];
    if ([sender.imageView.image isEqual:unImage] ) {
        [sender setImage:seImage forState:UIControlStateNormal];
        [self.nowSendBtn setImage:unImage forState:UIControlStateNormal];
    }else{
        [sender setImage:unImage forState:UIControlStateNormal];
    }
    
}
//选择时间selectTimeBtn点击事件
-(void)selectTime:(UIButton*)sender{
    if (self.pickView.hidden == false) {
        self.pickView.hidden = true;
    }else{
        self.pickView.hidden = false;
    }
    
}
//移除导航栏下边线
-(void)viewWillDisappear:(BOOL)animated{
    [self.line removeFromSuperview];

}

@end
