//
//  TTExpandCircleCell.h
//  expandDemo
//
//  Created by simp on 2017/11/6.
//  Copyright © 2017年 yiyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TTExpandCircleCellProtocol <NSObject>

/**是否能够被拖动*/
- (BOOL)ttExpandCircleCellCanStartDrag;

- (void)ttExpandCircleCellDisAppear;

@end

@interface TTExpandCircleCell : UICollectionViewCell

@property (nonatomic, weak) id<TTExpandCircleCellProtocol> delegate;

- (void)toRightDisappear;

- (void)toLeftDisappear;

@end
