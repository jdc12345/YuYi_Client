//
//  ZYActionSheet.h
//  YuYi_Client
//
//  Created by wylt_ios_1 on 2017/2/24.
//  Copyright © 2017年 wylt_ios_1. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZYActionSheetDelegate;

@interface ZYActionSheet : UIView

/**
 *  遮罩层背景颜色, 默认为blackColor
 */
@property (strong, nonatomic) UIColor *maskBackgroundColor;
/**
 *  遮罩层的alpha值，默认为0.5
 */
@property (nonatomic) CGFloat maskAlpha;

/**
 *  Default: [UIFont systemFontOfSize:20]
 */
@property (strong, nonatomic) UIFont *titleFont;
/**
 *  default: blackColor
 */
@property (strong, nonatomic) UIColor *titleColor;
/**
 *  default: whiteColor
 */
@property (strong, nonatomic) UIColor *titleBackgroundColor;

/**
 *  分割线颜色, default: lightGrayColor
 */
@property (strong, nonatomic) UIColor *lineColor;
/**
 *  按钮高度 默认为49
 */
@property (assign,nonatomic) CGFloat buttonHeight;
/**
 *  标题的高度 默认为49
 */
@property (assign,nonatomic) CGFloat titleHeight;

+ (instancetype)actionSheetWithTitle:(NSString *)title
                        buttonTitles:(NSArray *)buttonTitles
                   cancelButtonTitle:(NSString *)cancelButtonTitle
                            delegate:(id<ZYActionSheetDelegate>)delegate;

- (instancetype)initWithTitle:(NSString *)title
                 buttonTitles:(NSArray *)buttonTitles
            cancelButtonTitle:(NSString *)cancelButtonTitle
                     delegate:(id<ZYActionSheetDelegate>)delegate;

- (instancetype)initWithTitle:(NSString *)title
                 buttonTitles:(NSArray *)buttonTitles
            cancelButtonTitle:(NSString *)cancelButtonTitle
                     delegate:(id<ZYActionSheetDelegate>)delegate
                      buttonW:(CGFloat)buttonW;

- (void)show;
- (void)showWithFrame:(CGRect)frame;

@end

@protocol ZYActionSheetDelegate <NSObject>

@optional
- (void)actionSheet:(ZYActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

- (UIFont *)actionSheet:(ZYActionSheet *)actionSheet buttonTextFontAtIndex:(NSInteger)bottonIndex;
- (UIColor *)actionSheet:(ZYActionSheet *)actionSheet buttonTextColorAtIndex:(NSInteger)bottonIndex;
- (UIColor *)actionSheet:(ZYActionSheet *)actionSheet buttonBackgroundColorAtIndex:(NSInteger)bottonIndex;


@end
