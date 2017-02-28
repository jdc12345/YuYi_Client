//
//  ZYLActionSheet.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/24.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#import "ZYLActionSheet.h"
#import "UIColor+Extension.h"
@interface ZYLActionSheet()
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) NSMutableArray *buttons;
@property (strong, nonatomic) NSMutableArray *lines;
@property (strong, nonatomic) UIView *maskView;
@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UIWindow *actionWindow;
@property (strong, nonatomic) UIButton *cancelButton;
@property (weak, nonatomic) id<ZYLActionSheetDelegate> delegate;
@property (assign, nonatomic) CGFloat buttonW;
@property (nonatomic) BOOL isShow;
@end

@implementation ZYLActionSheet
- (instancetype)initWithTitle:(NSString *)title
                 buttonTitles:(NSArray *)buttonTitles
            cancelButtonTitle:(NSString *)cancelButtonTitle
                     delegate:(id<ZYActionSheetDelegate>)delegate
                      buttonW:(CGFloat)buttonW{
    if (self = [super init]) {
        _delegate = delegate;
        _titleColor = [UIColor blackColor];
        _titleFont = [UIFont systemFontOfSize:20];
        _titleBackgroundColor = [UIColor whiteColor];
//        _titleHeight = DefaultButtonHeight;
//        _buttonHeight = DefaultButtonHeight;
        _lineColor = [UIColor lightGrayColor];
        _maskBackgroundColor = [UIColor blackColor];
        _maskAlpha = 0.5;
        _buttonW = buttonW;
        
        UIView *maskView = [[UIView alloc] init];
        [maskView setAlpha:0];
        [maskView setUserInteractionEnabled:NO];
        [maskView setFrame:(CGRect){0, 0, SCREEN_SIZE}];
        [maskView setBackgroundColor:_maskBackgroundColor];
        [self addSubview:maskView];
        _maskView = maskView;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
        [maskView addGestureRecognizer:tap];
        
        UIView *bottomView = [[UIView alloc] init];
        [self addSubview:bottomView];
        _bottomView = bottomView;
        
        if ([title length]) {
            UIImageView *topLine = [[UIImageView alloc] init];
            topLine.backgroundColor = _lineColor;
            [topLine setFrame:CGRectMake(0, 0, _buttonW, 1.0f)];
            [bottomView addSubview:topLine];
            [self.lines addObject:topLine];
            
            // 标题
            UILabel *label = [[UILabel alloc] init];
            [label setText:title];
            [label setTextColor:_titleColor];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setFont:_titleFont];
            [label setBackgroundColor:[UIColor whiteColor]];
            [label setFrame:CGRectMake(0, 1, buttonW, _titleHeight)];
            [bottomView addSubview:label];
            _titleLabel = label;
        }
        
        CGFloat topY = _titleLabel ? CGRectGetMaxY(_titleLabel.frame) : 0;
        
        if (buttonTitles.count) {
            for (int i = 0; i < buttonTitles.count; i++) {
                UIImageView *line = [[UIImageView alloc] init];
                line.backgroundColor = _lineColor;
                CGFloat lineY = topY + i * (_buttonHeight + 1);
                [line setFrame:CGRectMake(0, lineY, _buttonW, 1.0f)];
                [bottomView addSubview:line];
                [self.lines addObject:line];
                
                // 所有按钮
                UIButton *btn = [[UIButton alloc] init];
                [btn setTag:i];
                [btn setTitle:buttonTitles[i] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchDown];
                [btn addTarget:self action:@selector(button1BackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
                [btn addTarget:self action:@selector(button1BackGroundNormal:) forControlEvents:UIControlEventTouchUpInside];
                CGFloat btnY = topY + i * (_buttonHeight + 1) + 1;
                [btn setFrame:CGRectMake(0, btnY, buttonW, _buttonHeight)];
                [bottomView addSubview:btn];
                [self.buttons addObject:btn];
                
            }
        }
        
        topY = topY + self.buttons.count * (_buttonHeight + 1);
        UIImageView *line = [[UIImageView alloc] init];
        line.backgroundColor = _lineColor;
        [line setFrame:CGRectMake((kScreenW -_buttonW) /2.0, topY, _buttonW, 1.0f)];
        [bottomView addSubview:line];
        [self.lines addObject:line];
        
        
        
        // 取消按钮
        UIButton *cancelBtn = [[UIButton alloc] init];
        [cancelBtn setTag:buttonTitles.count];
        [cancelBtn setTitle:cancelButtonTitle forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchDown];
        [cancelBtn addTarget:self action:@selector(button1BackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
        [cancelBtn addTarget:self action:@selector(button1BackGroundNormal:) forControlEvents:UIControlEventTouchUpInside];
        if (![cancelButtonTitle length]){
            cancelBtn.hidden = YES;
        }
        CGFloat btnY = topY + 1;
        [cancelBtn setFrame:CGRectMake(0, btnY, buttonW, _buttonHeight)];
        [bottomView addSubview:cancelBtn];
        [self.buttons addObject:cancelBtn];
        _cancelButton = cancelBtn;
        CGFloat bottomH;
        if (![cancelButtonTitle length]){
            cancelBtn.hidden = YES;
            bottomH = CGRectGetMaxY(cancelBtn.frame);
        }else{
            bottomH = CGRectGetMaxY(line.frame);
        }
        
        [bottomView setFrame:CGRectMake(0, SCREEN_SIZE.height, buttonW, bottomH)];
        
        [self setFrame:(CGRect){0, 0, SCREEN_SIZE}];
        [self.actionWindow addSubview:self];
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
