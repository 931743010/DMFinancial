//
//  DMNewcomerViewController.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/11/30.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMNewcomerViewController.h"
#import "DMNewcomerCell.h"
#import "DMNewcomerItem.h"

@interface DMNewcomerViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *arrayList;

@end

#define itemSpacing 10

@implementation DMNewcomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新手入门";
    
    [self createSubViews];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _collectionView.frame = self.view.bounds;
}

-(void)createSubViews {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = itemSpacing;
    layout.minimumLineSpacing = itemSpacing;
    CGFloat itemWidth = kScreenWidth - itemSpacing*2;
    layout.itemSize = CGSizeMake(itemWidth, 300);
    layout.sectionInset = UIEdgeInsetsMake(itemSpacing, itemSpacing, itemSpacing, itemSpacing);
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[DMNewcomerCell class] forCellWithReuseIdentifier:@"cell"];

}

#pragma mark UICollectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DMNewcomerCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.item = [self.arrayList objectAt:indexPath.row];
    return cell;
}


#pragma mark ---------getter setter ---------

-(NSMutableArray *)arrayList {
    if (!_arrayList) {
        _arrayList = [[NSMutableArray alloc] init];
        for (NSUInteger i = 0; i < 10; i++) {
            DMNewcomerItem *item = [[DMNewcomerItem alloc] init];
            item.itemId = [NSString stringWithFormat:@"%@",@(i)];
            item.url = @"http://img0.imgtn.bdimg.com/it/u=1070902365,2619384777&fm=21&gp=0.jpg";
            item.imageUrl = @"http://ww4.sinaimg.cn/bmiddle/537719cagw1eyk7c6r4lmj215o0ry4qp.jpg";
            [_arrayList addObject:item];
        }
    }
    return _arrayList;
}

@end
