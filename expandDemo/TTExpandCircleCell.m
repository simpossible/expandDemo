//
//  TTExpandCircleCell.m
//  expandDemo
//
//  Created by simp on 2017/11/6.
//  Copyright © 2017年 yiyou. All rights reserved.
//

#import "TTExpandCircleCell.h"
#import "Masonry.h"



@interface TTExpandCircleCell ()<UIGestureRecognizerDelegate>

/**
 * 动画视图
 */
@property (nonatomic, strong) UIView * animateView;

/**
 * 最大的旋转角度
 */
@property (nonatomic, assign) CGFloat rotationAngel;

/**
 * 最大的旋转系数
 * 通过最大的旋转角度 * 旋转系数来确定具体旋转角度的
 */
@property (nonatomic, assign) CGFloat rotationPowerMax;

/**最大的旋转距离 超过这个距离不再旋转*/
@property (nonatomic, assign) CGFloat maxPandistance;

/***/
@property (nonatomic, assign) CGFloat powerLenght;

@property (nonatomic, assign) CGFloat radiuY;

@property (nonatomic, strong) CADisplayLink * dispalyLink;



@property (nonatomic, assign) CGFloat disAppearIndex;

@property (nonatomic, assign) CGFloat disAppearFlag;


@end

@implementation TTExpandCircleCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor yellowColor];
        self.radiuY = 490;
        self.rotationAngel = M_PI/8;
        self.rotationPowerMax = 1;
        self.maxPandistance = 120;
        self.powerLenght = [[UIScreen mainScreen] bounds].size.width;
    }
    [self initialUI];
    [self addGesture];
    self.layer.masksToBounds = NO;
    return self;
}

- (void)initialUI {
    self.animateView = [[UIView alloc] init];
    self.animateView.backgroundColor = [UIColor blueColor];;
    [self addSubview:self.animateView];
    [self.animateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    UIButton * disButton = [[UIButton alloc] initWithFrame:CGRectMake(80, 80, 100, 100)];
    [disButton addTarget:self action:@selector(todisAppear) forControlEvents:UIControlEventTouchUpInside];
    [disButton setTitle:@"消失" forState:UIControlStateNormal];
    disButton.backgroundColor = [UIColor redColor];
    [self.animateView addSubview:disButton];
}

- (void)todisAppear {
    [self toRightDisappear];
}

/** 添加手势 */
- (void)addGesture {
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] init];
    pan.delegate = self;
    [pan addTarget:self action:@selector(gestureMoved:)];
    [self addGestureRecognizer:pan];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self.delegate respondsToSelector:@selector(ttExpandCircleCellCanStartDrag)]) {
        return [self.delegate ttExpandCircleCellCanStartDrag];
    }
//    return NO;
    return YES;
}

- (void)gestureMoved:(UIPanGestureRecognizer *)pan {
    
    if (pan.state == UIGestureRecognizerStateBegan) {
    
    }else if (pan.state == UIGestureRecognizerStateChanged) {
        [self contentToChange:pan];

    }else if (pan.state == UIGestureRecognizerStateEnded) {
        [self backToCenter];
     
    }
}

- (void)backToCenter {
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5f initialSpringVelocity:10 options:0 animations:^{
          self.animateView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        self.animateView.transform = CGAffineTransformMakeRotation(0);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)contentToChange:(UIPanGestureRecognizer *)pan {
    CGPoint tran =  [pan translationInView:self];
    CGFloat x = tran.x;
    CGFloat y = tran.y;
    [self animateWithPoint:tran];
//    CGFloat rotationStrength = MIN(tran.x / ROTATION_STRENGTH, ROTATION_MAX);
    
//    CGFloat rotationAngel = (CGFloat) (ROTATION_ANGLE * rotationStrength);
//    CGFloat trans = 0;
//    CGFloat sin = x/self.radiuY;
//    CGFloat asin = asinf(sin);
//    NSLog(@"___%f",asin);
//    self.animateView.transform = CGAffineTransformMakeRotation(asin/2);
    
//    CGPoint center=self.animateView.center;
//    center.y=self.animateView.center.y-(30)*fabs(x/PAN_DISTANCE)*0.6;//此处的0.6同上
//    self.animateView.center=center;
    
}

- (void)animateWithPoint:(CGPoint)transition {
    CGFloat x = transition.x;
    CGFloat y = transition.y;
    self.animateView.center = CGPointMake(self.frame.size.width/2 + transition.x, self.frame.size.height/2 + transition.y);
    
    CGFloat rotationStrength = MIN(x / self.powerLenght, self.rotationPowerMax);
    
    CGFloat rotationAngel = (CGFloat) (self.rotationAngel * rotationStrength);
    
    self.animateView.center = CGPointMake(self.frame.size.width/2 + x, self.frame.size.height/2 + y);
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(rotationAngel);
    
    self.animateView.transform = transform;
    
    CGPoint center=self.animateView.center;
    center.y=self.animateView.center.y-(30)*fabs(x/self.maxPandistance)*0.6;//此处的0.6同上
    self.animateView.center=center;
    
}

- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint oldOrigin = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = view.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    
    view.center = CGPointMake (view.center.x - transition.x, view.center.y - transition.y);
}

- (void)toRightDisappear {
    if (!self.dispalyLink) {
        self.dispalyLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(disAppearGoing)];
   
        self.disAppearIndex = 0;
        self.disAppearFlag = 15;
        [self.dispalyLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    
}

- (void)toLeftDisappear {
    if (!self.dispalyLink) {
        self.dispalyLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(disAppearGoing)];
        self.disAppearIndex = 0;
        self.disAppearFlag = -15;
        [self.dispalyLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)disAppearGoing {
    self.disAppearIndex += self.disAppearFlag;
    CGFloat index = fabs(self.disAppearIndex);
    if (index > self.frame.size.width+ 100) {
        [self.dispalyLink invalidate];
        self.dispalyLink = nil;
        self.dispalyLink = nil;
        return;
    }
    [self animateWithPoint:CGPointMake(index, 0)];
}

@end
