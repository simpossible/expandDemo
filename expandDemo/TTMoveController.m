//
//  TTMoveController.m
//  expandDemo
//
//  Created by simp on 2017/11/6.
//  Copyright © 2017年 yiyou. All rights reserved.
//

#import "TTMoveController.h"
#import "TTExpandLayout.h"
#import "TTExpandCircleCell.h"
#import "Masonry.h"

@interface TTMoveController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * expandView;

@end

@implementation TTMoveController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialUI];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}

- (void)initialUI {
    [self initialCollectionView];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)initialCollectionView {
    TTExpandLayout *layout = [[TTExpandLayout alloc] init];
    self.expandView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.expandView.delegate = self;
    self.expandView.dataSource = self;
    [self.expandView registerClass:[TTExpandCircleCell class] forCellWithReuseIdentifier:@"hehehe"];
    self.expandView.backgroundColor = [UIColor orangeColor];
    self.expandView.layer.masksToBounds = NO;
    
    [self.view addSubview:self.expandView];
    
    [self.expandView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(64);
//        make.bottom.equalTo(self.view.mas_bottom).offset(-200);
        make.height.mas_equalTo(490);
    }];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TTExpandCircleCell *cell = (TTExpandCircleCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"hehehe" forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, 100);
}

- (UIEdgeInsets)edgeForExtendViewAtIndexPath:(NSIndexPath *)indexPath {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
