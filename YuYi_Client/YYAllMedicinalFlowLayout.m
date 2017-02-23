//
//  YYAllMedicinalFlowLayout.m
//  电商
//
//  Created by 万宇 on 2017/2/21.
//  Copyright © 2017年 万宇. All rights reserved.
//

#import "YYAllMedicinalFlowLayout.h"

@implementation YYAllMedicinalFlowLayout
- (void)prepareLayout
{
    // 一定要去调用父类方法
    [super prepareLayout];
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    CGFloat w = (self.collectionView.bounds.size.width-30) / 2;
    CGFloat h = 225;
    self.itemSize = CGSizeMake(w, h); // cell大小
    self.minimumLineSpacing = 10; // 行间距
    self.minimumInteritemSpacing = 10; // cell间距
    self.headerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 40);
    self.footerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 10);
    //    self.scrollDirection = UICollectionViewScrollDirectionHorizontal; // 设置水平滑动
}

@end
