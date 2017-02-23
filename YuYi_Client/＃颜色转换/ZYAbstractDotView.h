//
//  ZYactDotView.h
//
//  Created by 张洋 on 15/11/19.
//  Copyright © 2015年 张洋. All rights reserved.
//
#import <UIKit/UIKit.h>


@interface ZYAbstractDotView : UIView


/**
 *  A method call let view know which state appearance it should take. Active meaning it's current page. Inactive not the current page.
 *
 *  @param active BOOL to tell if view is active or not
 */
- (void)changeActivityState:(BOOL)active;


@end
