//
//  TTExpandLayout.h
//  expandDemo
//
//  Created by simp on 2017/11/6.
//  Copyright © 2017年 yiyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UICollectionExpandDelegate <UICollectionViewDelegate>

- (UIEdgeInsets)edgeForExtendViewAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface TTExpandLayout : UICollectionViewLayout

@end
