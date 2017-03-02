//
//  YYAddressEditVC.m
//  YuYi_Client
//
//  Created by 万宇 on 2017/2/27.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "YYAddressEditVC.h"
#import "UIColor+colorValues.h"
#import "Masonry.h"
#import "YYAddressEditView.h"
#import "YYareaBtn.h"
#import "UIPlaceholderTextView.h"
#import "YYConfirmVC.h"
@interface YYAddressEditVC ()<UITextFieldDelegate,UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIGestureRecognizerDelegate>
//输入姓名的textField
@property(nonatomic,weak)UITextField *nameTextField;
//输入电话的textField
@property(nonatomic,weak)UITextField *telNumberTextField;
//输入选择区域的btn
@property(nonatomic,weak)YYareaBtn *areaBtn;
//输入详细地址的textView
@property(nonatomic,weak)UIPlaceholderTextView *detailAddressView;
//城市列表
@property(nonatomic,strong)NSArray *province;
@property(nonatomic,strong)NSDictionary *city;
@property(nonatomic,strong)NSDictionary *country;

@property(nonatomic,weak)UIPickerView *pickerView;
//pickerView的收起视图
@property(nonatomic,weak)UIView *topView;
@end

@implementation YYAddressEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = true;
    self.navigationController.navigationBar.translucent = false;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    self.addressInfos = [NSMutableArray array];
    [self loadData];
    [self setupUI];
}
-(void)loadData{
    //省
    self.province = @[@"北京", @"广西", @"广东"];
    //市
    self.city = @{
              @"北京":@[@"朝阳区", @"东城区", @"西城区"],
              @"广西":@[@"桂林市", @"南宁市"],
              @"广东":@[@"惠州市", @"广州市", @"深圳市",@"东莞市"]
              };
              //县区
              self.country = @{
                  @"朝阳区":@[@"朝阳区1", @"朝阳区2", @"朝阳区3"],
                  @"东城区":@[@"东城区1", @"东城区2",@"东城区3",@"东城区4"],
                  @"西城区":@[@"西城区1", @"西城区2", @"西城区3",@"西城区4"],
                  @"桂林市":@[@"桂林市1", @"桂林市2", @"桂林市3"],
                  @"南宁市":@[@"南宁市1", @"南宁市2",@"南宁市3",@"南宁市4"],
                  @"惠州市":@[@"惠州市1", @"惠州市2", @"惠州市3",@"惠州市4"],
                  @"广州市":@[@"广州市1", @"广州市2", @"广州市3"],
                  @"深圳市":@[@"深圳市1", @"深圳市2",@"深圳市3",@"深圳市4"],
                  @"东莞市":@[@"东莞市1", @"东莞市2", @"东莞市3",@"东莞市4"],
                  };
    
}
-(void)setupUI{
    //确定按钮
    UIButton *confirmBtn = [[UIButton alloc]init];
    confirmBtn.frame = CGRectMake(0, 0, 44, 44);
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor colorWithHexString:@"25f368"] forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:confirmBtn];
    [confirmBtn addTarget:self action:@selector(saveAddress:) forControlEvents:UIControlEventTouchUpInside];
    
    //添加收货人
    YYAddressEditView *personView = [[YYAddressEditView alloc]init];
    [self.view addSubview:personView];
    [personView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(10);
        make.right.offset(-10);
        make.height.offset(50);
    }];
    personView.preLabel.text = @"收货人";
    personView.textField.placeholder = @"姓名";
    personView.textField.delegate = self;
    self.nameTextField = personView.textField;
    //添加收货人联系电话
    YYAddressEditView *telNumberView = [[YYAddressEditView alloc]init];
    [self.view addSubview:telNumberView];
    [telNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(personView);
        make.height.offset(50);
        make.top.equalTo(personView.mas_bottom).offset(1);
    }];
    telNumberView.preLabel.text = @"联系电话";
    telNumberView.textField.placeholder = @"11位手机号码";
    telNumberView.textField.delegate = self;
    self.telNumberTextField = telNumberView.textField;
    telNumberView.textField.keyboardType = UIKeyboardTypeNumberPad;//设置键盘的样式
    //添加选择地区
    YYAddressEditView *areaView = [[YYAddressEditView alloc]init];
    [areaView.textField removeFromSuperview];
    [self.view addSubview:areaView];
    [areaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(telNumberView);
        make.height.offset(50);
        make.top.equalTo(telNumberView.mas_bottom).offset(1);
    }];
    areaView.preLabel.text = @"选择地区";
    YYareaBtn *areaBtn = [[YYareaBtn alloc]init];
    [areaView addSubview:areaBtn];
    [areaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(areaView.preLabel.mas_right).offset(13);
        make.top.right.bottom.equalTo(areaView);
    }];
    [areaBtn setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    [areaBtn setTitle:@"河北省 保定市 涿州市" forState:UIControlStateNormal];
    areaBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [areaBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [areaBtn addTarget:self action:@selector(cityPickerView:) forControlEvents:UIControlEventTouchUpInside];
    self.areaBtn = areaBtn;
    //添加详细地址
    UIView *detailAddressView = [[UIView alloc]init];
    detailAddressView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:detailAddressView];
    [detailAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(areaView);
        make.height.offset(82);
        make.top.equalTo(areaView.mas_bottom).offset(1);
        }];
    UILabel *preLabel = [[UILabel alloc]init];//添加左侧类别Label
    preLabel.text = @"详细地址";
    preLabel.font = [UIFont systemFontOfSize:14];
    preLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [detailAddressView addSubview:preLabel];
    [preLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(18);
        make.width.offset(60);
    }];
    //添加右侧详情textView
    UIPlaceholderTextView *textView = [[UIPlaceholderTextView alloc]init];
    textView.placeholder = @"填写你的详细街道/小区/门牌号";
    textView.scrollEnabled = true;
    textView.delegate = self;
    //设置输入框内容的字体样式和大小
    textView.font = [UIFont fontWithName:@"Arial" size:14.0f];
    //内容对齐方式
    textView.textAlignment = NSTextAlignmentLeft;
    //设置字体颜色
//    textView.textColor = [UIColor colorWithHexString:@"333333"];
    [detailAddressView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(preLabel.mas_right).offset(10);
        make.top.offset(11);
        make.right.bottom.equalTo(detailAddressView);
    }];
    self.detailAddressView = textView;
    //添加邮政编码
    YYAddressEditView *postcodeView = [[YYAddressEditView alloc]init];
    [self.view addSubview:postcodeView];
    [postcodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(detailAddressView);
        make.height.offset(50);
        make.top.equalTo(detailAddressView.mas_bottom).offset(1);
    }];
    postcodeView.preLabel.text = @"邮编地址";
    postcodeView.textField.text = @"072750";
    postcodeView.textField.delegate = self;
    postcodeView.textField.keyboardType = UIKeyboardTypeNumberPad;//设置键盘的样式
    //pickerView的工具栏
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 50)];
    topView.hidden = true;
    self.topView = topView;
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(postcodeView.mas_bottom).offset(10);
        make.left.right.offset(0);
        make.height.offset(50);
    }];
    topView.backgroundColor = [UIColor colorWithHexString:@"#f3f3f3"];
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(kScreenW-40, 10, 40, 20);
    [btn setTitleColor:[UIColor colorWithHexString:@"25f368"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dismissPickerView:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [topView addSubview:btn];

    //添加pickView
    UIPickerView *pickView = [[UIPickerView alloc]init];
    [self.view addSubview:pickView];
    pickView.backgroundColor = [UIColor whiteColor];
    //隐藏pickView
    self.pickerView = pickView;
    pickView.hidden = true;
    [pickView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.bottom.left.right.offset(0);
    }];
    pickView.dataSource = self;
    pickView.delegate = self;
    pickView.showsSelectionIndicator = YES;
        //添加tap手势：
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(event:)];
    //将手势添加至需要相应的view中
    [self.view addGestureRecognizer:tapGesture];
//    [pickView setValue:topView forKey:@"inputAccessoryView"];
    }

-(void)dismissPickerView:(UIButton*)sender{
    self.pickerView.hidden = true;
    self.topView.hidden = true;
}
//执行手势触发的方法：
- (void)event:(UITapGestureRecognizer *)gesture
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];//取消键盘
    self.topView.hidden = true;
    self.pickerView.hidden = true;


}
#pragma mark - 该方法的返回值决定该控件包含多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 3;
}
#pragma mark - 该方法的返回值决定该控件指定列包含多少个列表项
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (0 == component)
    {
        return _province.count;
    }
    if (1 == component) {
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        NSString *provinceName = _province[rowProvince];
        NSArray *citys = _city[provinceName];
        return citys.count;
    }else{
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        NSString *provinceName = _province[rowProvince];
        NSArray *citys = _city[provinceName];
        NSInteger rowCity = [pickerView selectedRowInComponent:1];
        NSString *cityName = citys[rowCity];
        NSArray *country = _country[cityName];
        return country.count;
    }
}
#pragma mark - 该方法返回的NSString将作为UIPickerView中指定列和列表项的标题文本
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (0 == component) {
        return _province[row];
    }
    if(1 == component){
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        NSString *provinceName = _province[rowProvince];
        NSArray *citys = _city[provinceName];
        return citys[row];
    }else{
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        NSString *provinceName = _province[rowProvince];
        NSArray *citys = _city[provinceName];
        NSInteger rowCity = [pickerView selectedRowInComponent:1];
        NSString *cityName = citys[rowCity];
        NSArray *country = _country[cityName];
        return country[row];
    }
}
#pragma mark - 当用户选中UIPickerViewDataSource中指定列和列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(0 == component){
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
    }
    if(1 == component)
        [pickerView reloadComponent:2];
    NSInteger rowOne = [pickerView selectedRowInComponent:0];
    NSInteger rowTow = [pickerView selectedRowInComponent:1];
    NSInteger rowThree = [pickerView selectedRowInComponent:2];
    NSString *provinceName = _province[rowOne];
    NSArray *citys = _city[provinceName];
    NSString *cityName = citys[rowTow];
    NSArray *countrys = _country[cityName];
    NSLog(@"%@~%@~%@", _province[rowOne], citys[rowTow],countrys[rowThree]);
    [self.areaBtn setTitle:[NSString stringWithFormat:@"%@ %@ %@", _province[rowOne], citys[rowTow],countrys[rowThree]] forState:UIControlStateNormal];
}
#pragma UItextdelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.topView.hidden = true;
    self.pickerView.hidden = true;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

{  //string就是此时输入的那个字符 textField就是此时正在输入的那个输入框 返回YES就是可以改变输入框的值 NO相反
    if ([string isEqualToString:@"\n"])  //按会车可以改变
    {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    if (self.telNumberTextField == textField)  //判断是否时我们想要限定的那个输入框
        
    {
        
        if ([textField.text length] > 11) { //如果输入框内容大于20则弹出警告
            
            textField.text = [toBeString substringToIndex:11];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请输入正确的11位电话号码" preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
//            [alert addAction:cancelAction];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
            
            return NO; 
            
        } 
        
    }
    return YES; 
    
}
#pragma mark - UITextView Delegate Methods
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //滑动开始时调用
    [scrollView resignFirstResponder];
}
#pragma btnClick
-(void)saveAddress:(UIButton*)sender{
    [self.addressInfos removeAllObjects];
    [self.addressInfos addObject:self.nameTextField.text];
    [self.addressInfos addObject:self.telNumberTextField.text];
    [self.addressInfos addObject:self.areaBtn.titleLabel.text];
    [self.addressInfos addObject:self.detailAddressView.text];
    NSLog(@"%@",self.addressInfos);
    //遍历addressInfo
    for (NSString *str in self.addressInfos) {
        if ([str isEqualToString:@""]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请确认所有选项已填写" preferredStyle:UIAlertControllerStyleAlert];
            //  UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
            //  [alert addAction:cancelAction];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    //返回确认付款页面
    for (UIViewController *cfVC in self.navigationController.childViewControllers) {
        if ([cfVC isKindOfClass:[YYConfirmVC class]]) {
            [self.navigationController popViewControllerAnimated:true];
            YYConfirmVC *confirmVC = (YYConfirmVC*)cfVC;
            confirmVC.nameLabel.text = [NSString stringWithFormat:@"收货人：%@", self.addressInfos[0]];
            confirmVC.detailAddressLabel.text = [NSString stringWithFormat:@"详细地址：%@%@", self.addressInfos[2],self.addressInfos[3]];
            confirmVC.numberLabel.text = [NSString stringWithFormat:@"联系人电话：%@", self.addressInfos[1]];

            
        }
    }
    
}
-(void)cityPickerView:(UIButton*)sender{
    if (self.pickerView.hidden==true) {
        [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];//取消键盘
        self.pickerView.hidden = false;
        self.topView.hidden = false;
    }else{
        self.topView.hidden = true;
        self.pickerView.hidden = true;
    }
   
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
