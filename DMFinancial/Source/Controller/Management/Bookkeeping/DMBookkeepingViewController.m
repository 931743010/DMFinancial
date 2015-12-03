//
//  DMBookkeepingViewController.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/12/2.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMBookkeepingViewController.h"
#import "DMBookkeepingCollectionView.h"
#import "DMManageBaobaoEditViewController.h"

@interface DMBookkeepingViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *arrayList;

@end

#define itemSpacing 10

@implementation DMBookkeepingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"记一笔";
    [self createSubViews];
}

-(void)createSubViews {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = itemSpacing;
    layout.minimumLineSpacing = itemSpacing;
    CGFloat itemWidth = (kScreenWidth - itemSpacing*3)/2;
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    layout.sectionInset = UIEdgeInsetsMake(itemSpacing, itemSpacing, itemSpacing, itemSpacing);
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[DMBookkeepingCollectionView class] forCellWithReuseIdentifier:@"DMBookkeepingCollectionView"];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _collectionView.frame = self.view.bounds;
}

#pragma mark UICollectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DMBookkeepingCollectionView *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"DMBookkeepingCollectionView" forIndexPath:indexPath];
    cell.backgroundColor = kDMPinkColor;
    cell.item = [self.arrayList objectAt:indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DMBookkeepingItem *item = [self.arrayList objectAt:indexPath.row];
    DMManageBaobaoEditViewController *controller = [[DMManageBaobaoEditViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
//    controller.AssetsType = item.itemId;
    controller.titleString = item.itemName;
    [self.navigationController pushViewController:controller animated:YES];

}

#pragma mark ---------getter setter ---------

-(NSMutableArray *)arrayList {
    if (!_arrayList) {
        _arrayList = [[NSMutableArray alloc] init];
        NSArray *array = @[@"宝宝",@"P2P",@"基金",@"银行理财",@"保险",@"国债",@"银行卡",@"其他资产"];
        for (NSUInteger i = 0; i < array.count; i++) {
            DMBookkeepingItem *item = [[DMBookkeepingItem alloc] init];
            item.itemName = [array objectAt:i];
            item.itemId = i;
            [_arrayList addObject:item];
        }
    }
    return _arrayList;
}

@end
