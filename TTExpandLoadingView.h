//
//  TTExpandLoadingView.h
//  TT
//
//  Created by simp on 2017/11/3.
//  Copyright © 2017年 yiyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTExpandLoadingView : UIView

@property (nonatomic, strong) UIImageView * avatorView;

- (void)startAnimate;

- (void)stopAnimate;

@end
