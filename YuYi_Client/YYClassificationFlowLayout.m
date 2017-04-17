//
//  YYClassificationFlowLayout.m
//  电商
//
//  Created by 万宇 on 2017/2/21.
//  Copyright © 2017年 万宇. All rights reserved.
//

#import "YYClassificationFlowLayout.h"

@implementation YYClassificationFlowLayout
- (void)prepareLayout
{
    // 一定要去调用父类方法
    [super prepareLayout];
    self.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    CGFloat w = (self.collectionView.bounds.size.width-35) / 4;
    CGFloat h = 34;
    self.itemSize = CGSizeMake(w, h); // cell大小
    self.minimumLineSpacing = 10; // 行间距
    self.minimumInteritemSpacing = 5; // cell间距
    self.headerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 40*kiphone6);
    self.footerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 10*kiphone6);
    //    self.scrollDirection = UICollectionViewScrollDirectionHorizontal; // 设置水平滑动
}

@end
