//
//  ViewController.m
//  expandDemo
//
//  Created by simp on 2017/11/3.
//  Copyright © 2017年 yiyou. All rights reserved.
//

#import "ViewController.h"
#import "TTExpandLoadingView.h"
#import "Masonry.h"
#import "TTMoveController.h"

@interface ViewController ()
@property (nonatomic, strong) TTExpandLoadingView * loadingView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self initialUI];
    self.navigationController.navigationBar.hidden = NO;
    // Do any additional setup after loading the view.
}

- (void)initialUI {
    [self initialNavigation];
    [self initialLoadingView];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"transparent"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    UILabel *label = [[UILabel alloc] init];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] init];
    NSTextAttachment * attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:@"navbar_icon_diamond"];
    attach.bounds = CGRectMake(0, 0, 16, 16);
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attach];
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:@"8764\n"];
    [string1 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 3)];
    [string1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, 3)];
    
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:@"我的红钻"];
    [string2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.73 green:0.73 blue:0.73 alpha:1] range:NSMakeRange(0, 4)];
    [string2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:NSMakeRange(0, 4)];
    
    [attr appendAttributedString:string];
    [attr appendAttributedString:string1];
    [attr appendAttributedString:string2];
    
    label.attributedText = attr;
    
    self.navigationItem.titleView = label;
    label.numberOfLines = 0;
    [label sizeToFit];
    label.textAlignment = NSTextAlignmentCenter;
    

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [button setImage:[UIImage imageNamed:@"navbar_icon_mycard"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = right;

}

- (void)rightItemClick:(id)sender {
    TTMoveController *vc = [[TTMoveController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)initialNavigation {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"transparent"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initialLoadingView {
    self.loadingView = [[TTExpandLoadingView alloc] init];
    [self.view addSubview:self.loadingView];
    
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    self.loadingView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [self.loadingView startAnimate];
}



@end
