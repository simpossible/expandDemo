//
//  TTExpandLayout.m
//  expandDemo
//
//  Created by simp on 2017/11/6.
//  Copyright © 2017年 yiyou. All rights reserved.
//

#import "TTExpandLayout.h"


@interface TTExpandLayout ()

@property (nonatomic, strong) NSMutableDictionary * caches;

@property (nonatomic, weak) id<UICollectionExpandDelegate> delegate;

@end

@implementation TTExpandLayout

- (instancetype)init {
    if (self = [super init]) {
        self.caches = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)prepareLayout {
    self.delegate = self.collectionView.delegate;
    [self caculateItems];
}

- (CGSize)collectionViewContentSize {
    return self.collectionView.frame.size;
}

- (void)caculateItems {
    NSInteger rowNumber = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:0];
    CGSize size = self.collectionView.frame.size;
    for (int i = 0 ; i < rowNumber; i ++) {
         NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
           UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        UIEdgeInsets inset = [self.delegate edgeForExtendViewAtIndexPath:indexPath];
        CGRect frame = CGRectMake(inset.left, inset.top, size.width-inset.left-inset.right, size.height-inset.top-inset.bottom);
        attr.frame = frame;
        [self.caches setObject:attr forKey:@(i)];
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return [self.caches allValues];
}
@end
