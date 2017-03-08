//
//  YYflowLay.m
//  电商
//
//  Created by 万宇 on 2017/2/20.
//  Copyright © 2017年 万宇. All rights reserved.
//

#import "YYflowLay.h"

@implementation YYflowLay
// 这个方法在调用的时候 一定准备好了 collectionView
// 并不是在创建完布局的时候就调用
- (void)prepareLayout
{
    // 一定要去调用父类方法
    [super prepareLayout];
    
    CGFloat w = self.collectionView.bounds.size.width / 3;
//    CGFloat h = self.collectionView.bounds.size.height/2-50;
    CGFloat h = 166;
    self.itemSize = CGSizeMake(w, h); // cell大小
    self.minimumLineSpacing = 1; // 行间距
    self.minimumInteritemSpacing = 0; // cell间距
    self.headerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 40);
    self.footerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 10);
//    self.scrollDirection = UICollectionViewScrollDirectionHorizontal; // 设置水平滑动
}

@end
