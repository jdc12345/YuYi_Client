//
//  ZYActionSheet.m
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/24.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import "ZYActionSheet.h"

#import "UIColor+Extension.h"
#define DefaultButtonHeight 45
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#define DefaultButtonTextFont [UIFont systemFontOfSize:17]
#define DefaultButtonTextColor [UIColor blackColor]
#define DefaultButtonBackgroundColor [UIColor whiteColor]

@interface ZYActionSheet ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) NSMutableArray *buttons;
@property (strong, nonatomic) NSMutableArray *lines;
@property (strong, nonatomic) UIView *maskView;
@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UIWindow *actionWindow;
@property (strong, nonatomic) UIButton *cancelButton;
@property (weak, nonatomic) id<ZYActionSheetDelegate> delegate;
@property (assign, nonatomic) CGFloat buttonW;
@property (nonatomic) BOOL isShow;

@end


@implementation ZYActionSheet

+ (instancetype)actionSheetWithTitle:(NSString *)title
                        buttonTitles:(NSArray *)buttonTitles
                   cancelButtonTitle:(NSString *)cancelButtonTitle
                            delegate:(id<ZYActionSheetDelegate>)delegate {
    return [[self alloc] initWithTitle:title buttonTitles:buttonTitles cancelButtonTitle:cancelButtonTitle delegate:delegate];
}

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
        _titleHeight = DefaultButtonHeight;
        _buttonHeight = DefaultButtonHeight;
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
        //        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        //        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
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
        
        CGFloat bottomH = CGRectGetMaxY(cancelBtn.frame);
        [bottomView setFrame:CGRectMake(0, SCREEN_SIZE.height, buttonW, bottomH)];
        
        [self setFrame:(CGRect){0, 0, SCREEN_SIZE}];
        [self.actionWindow addSubview:self];
    }
    
    return self;
}

- (void)show{
    if (self.isShow) {
        return;
    }
    
    _actionWindow.hidden = NO;
    [self prepareUI];
    [self setFrame:(CGRect){0, 0, SCREEN_SIZE}];
    [self setNeedsLayout];
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         [_maskView setAlpha:_maskAlpha];
                         [_maskView setUserInteractionEnabled:YES];
                         
                         CGRect frame = _bottomView.frame;
                         frame.origin.y -= frame.size.height;
                         [_bottomView setFrame:frame];
                         
                     }
                     completion:nil];
    
    self.isShow = YES;
}
- (void)showWithFrame:(CGRect)frame{
    if (self.isShow) {
        return;
    }
    
    _actionWindow.hidden = NO;
    [self prepareUI];
    [self setFrame:(CGRect){0, frame.origin.y +135 *kiphone6 -kScreenH, kScreenW,kScreenH -(frame.origin.y +135 *kiphone6-kScreenH)}];
    [_maskView setFrame:(CGRect){0, 0, kScreenW,kScreenH -(frame.origin.y +135 *kiphone6-kScreenH)}];
    
    for ( int i = 0; i < self.buttons.count;  i++) {
        UIButton *btn = self.buttons[i];
        CGRect btnFrame = btn.frame;
        btnFrame.origin.x = frame.origin.x;
        btnFrame.size.width = frame.size.width;
        [btn setFrame:btnFrame];
        // btn.backgroundColor = [UIColor redColor];
        
        NSLog(@"%g,",btn.frame.size.width);
    }
    [self setNeedsLayout];
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         [_maskView setAlpha:_maskAlpha];
                         [_maskView setUserInteractionEnabled:YES];
                         
                         CGRect frame = _bottomView.frame;
                         frame.origin.y -= frame.size.height;
                         [_bottomView setFrame:frame];
                         
                     }
                     completion:nil];
    
    self.isShow = YES;
}

- (void)layoutSubviews {
    
    if (_titleLabel) {
        UIImageView *topLine = [self.lines objectAtIndex:0];
        [topLine setFrame:CGRectMake(0, 0, _buttonW, 1)];
        
        [_titleLabel setFrame:CGRectMake((kScreenW -_buttonW) /2.0, 1, _buttonW, _titleHeight)];
    }
    CGFloat topY = _titleLabel ? CGRectGetMaxY(_titleLabel.frame) : 0;
    for (int index = 0; index < self.buttons.count; index++) {
        //        int lineIndex = _titleLabel ? index : index + 1;
        UIImageView *line = [self.lines objectAtIndex:index];
        CGFloat lineY = topY + index * (_buttonHeight + 1);
        [line setFrame:CGRectMake((kScreenW -_buttonW) /2.0, lineY, _buttonW, 1)];
        
        UIButton *button = [self.buttons objectAtIndex:index];
        CGFloat buttonY = lineY + 1;
        [button setFrame:CGRectMake((kScreenW -_buttonW)/2.0, buttonY, _buttonW, _buttonHeight)];
    }
    
    CGFloat bottomH = CGRectGetMaxY(_cancelButton.frame);
    [_bottomView setFrame:CGRectMake(0, SCREEN_SIZE.height - bottomH, SCREEN_SIZE.width, bottomH)];
}

#pragma mark - ......::::::: Private Method :::::::......

- (UIFont *)buttonTextFontAtIndex:(NSInteger)index {
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:buttonTextFontAtIndex:)]) {
        return [self.delegate actionSheet:self buttonTextFontAtIndex:index];
    }
    
    return DefaultButtonTextFont;
}

- (UIColor *)buttonTextColorAtIndex:(NSInteger)index {
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:buttonTextColorAtIndex:)]) {
        return [self.delegate actionSheet:self buttonTextColorAtIndex:index];
    }
    
    return DefaultButtonTextColor;
}

- (UIColor *)buttonBackgroundColorAtIndex:(NSInteger)index {
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:buttonBackgroundColorAtIndex:)]) {
        return [self.delegate actionSheet:self buttonBackgroundColorAtIndex:index];
    }
    
    return DefaultButtonBackgroundColor;
}

- (void)prepareUI {
    _maskView.backgroundColor = self.maskBackgroundColor;
    _titleLabel.font = self.titleFont;
    _titleLabel.textColor = self.titleColor;
    _titleLabel.backgroundColor = self.titleBackgroundColor;
    
    for (UIImageView *line in self.lines) {
        line.backgroundColor = self.lineColor;
    }
    
    for (int index = 0; index < [self.buttons count]; index++) {
        UIButton *button = self.buttons[index];
        [button setBackgroundColor:[self buttonBackgroundColorAtIndex:index]];
        [[button titleLabel] setFont:[self buttonTextFontAtIndex:index]];
        //        [button setTitleColor:[self buttonTextColorAtIndex:index] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        //        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        //        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
    }
}

- (void)dismiss:(UITapGestureRecognizer *)tap {
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         [_maskView setAlpha:0];
                         [_maskView setUserInteractionEnabled:NO];
                         
                         CGRect frame = _bottomView.frame;
                         frame.origin.y += frame.size.height;
                         [_bottomView setFrame:frame];
                     }
                     completion:^(BOOL finished) {
                         _actionWindow.hidden = YES;
                         
                         [self removeFromSuperview];
                         self.isShow = NO;
                     }];
}

- (void)didClickBtn:(UIButton *)btn {
    
    [self dismiss:nil];
    
    if ([_delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        [_delegate actionSheet:self clickedButtonAtIndex:btn.tag];
    }
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

#pragma mark - ......::::::: Getter and Setter :::::::......

- (UIWindow *)actionWindow {
    if (_actionWindow == nil) {
        
        _actionWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _actionWindow.windowLevel       = UIWindowLevelStatusBar;
        _actionWindow.backgroundColor   = [UIColor clearColor];
        _actionWindow.hidden = NO;
    }
    
    return _actionWindow;
}

- (NSMutableArray *)buttons {
    if (!_buttons) {
        _buttons = [[NSMutableArray alloc] init];
    }
    return _buttons;
}

- (NSMutableArray *)lines {
    if (!_lines) {
        _lines = [[NSMutableArray alloc] init];
    }
    return _lines;
}
- (void)button1BackGroundNormal:(UIButton *)sender
{
    
    sender.backgroundColor = [UIColor colorWithHexString:@"25f368"];
}
//  button1高亮状态下的背景色
- (void)button1BackGroundHighlighted:(UIButton *)sender
{
    sender.backgroundColor = [UIColor colorWithHexString:@"25f368"];
}

@end
