//
//  MainViewController.m
//  XYSegementView
//
//  Created by 向阳 on 16/11/22.
//  Copyright © 2016年 xiangyang. All rights reserved.
//

#import "MainViewController.h"
#import "XYTitleView.h"
#import "FirstCollectionViewCell.h"
#import "SecondCollectionViewCell.h"
#import "ThirdCollectionViewCell.h"
#import "FourthCollectionViewCell.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface MainViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) XYTitleView      *titleView;
@property (nonatomic ,retain) UICollectionView *collectionView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"分段视图";
    
    [self createTitleView];
    [self createCollectionView];
}

- (void)createTitleView
{
    NSArray *titleArray = @[@"一页",@"两页",@"三页",@"四页"];
    _titleView = [[XYTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40) TitleArray:titleArray];
    _titleView.titleClickBlock = ^(NSInteger index){
        
    };
    [self.view addSubview:_titleView];
}

- (void)createCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight-64-40);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight-40-64) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.contentSize = CGSizeMake(kScreenWidth * 4, kScreenHeight-40-64);
    [_collectionView registerClass:[FirstCollectionViewCell class] forCellWithReuseIdentifier:@"cellOne"];
    [_collectionView registerClass:[SecondCollectionViewCell class] forCellWithReuseIdentifier:@"cellTwo"];
    [_collectionView registerClass:[ThirdCollectionViewCell class] forCellWithReuseIdentifier:@"cellThree"];
    [_collectionView registerClass:[FourthCollectionViewCell class] forCellWithReuseIdentifier:@"cellFour"];
    [self.view addSubview:_collectionView];
    [_collectionView.panGestureRecognizer requireGestureRecognizerToFail:self.screenEdgePanGestureRecognizer];
}

- (UIScreenEdgePanGestureRecognizer *)screenEdgePanGestureRecognizer {
    UIScreenEdgePanGestureRecognizer *screenEdgePanGestureRecognizer = nil;
    if (self.navigationController.view.gestureRecognizers.count > 0) {
        for (UIGestureRecognizer *recognizer in self.navigationController.view.gestureRecognizers) {
            if ([recognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
                screenEdgePanGestureRecognizer = (UIScreenEdgePanGestureRecognizer *)recognizer;
                break;
            }
        }
    }
    return screenEdgePanGestureRecognizer;
}

#pragma mark UICollectionViewDelegate && UICollectionDataSource && UICollectionViewDelegateFlowLayout

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        FirstCollectionViewCell *cellOne = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellOne" forIndexPath:indexPath];
        return cellOne;
    }else if (indexPath.row == 1) {
        SecondCollectionViewCell *cellTwo = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellTwo" forIndexPath:indexPath];
        return cellTwo;
    }else if (indexPath.row == 2) {
        ThirdCollectionViewCell *cellThree = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellThree" forIndexPath:indexPath];
        return cellThree;
    }else if (indexPath.row == 3) {
        FourthCollectionViewCell *cellFour = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellFour" forIndexPath:indexPath];
        return cellFour;
    }
    return nil;
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger pageNum = offsetX/kScreenWidth;
    [_titleView itemSelected:pageNum];
}

@end
