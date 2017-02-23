//
//  ZYactDotView.m
//
//  Created by 张洋 on 15/11/19.
//  Copyright © 2015年 张洋. All rights reserved.
//

#import "ZYAbstractDotView.h"


@implementation ZYAbstractDotView


- (id)init
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in %@", NSStringFromSelector(_cmd), self.class]
                                 userInfo:nil];
}


- (void)changeActivityState:(BOOL)active
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in %@", NSStringFromSelector(_cmd), self.class]
                                 userInfo:nil];
}

@end


