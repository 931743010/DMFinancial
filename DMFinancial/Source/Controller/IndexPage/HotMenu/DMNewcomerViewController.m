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
    cell.backgroundColor = [UIColor redColor];
    cell.item = [self.arrayList objectAt:indexPath.row];
    return cell;
}


#pragma mark ---------getter setter ---------

-(NSMutableArray *)arrayList {
    if (!_arrayList) {
        _arrayList = [[NSMutableArray alloc] init];
        for (NSUInteger i = 0; i < 10; i++) {
            DMManagementItem *item = [[DMManagementItem alloc] init];
            item.name = [NSString stringWithFormat:@"资产%@",@(i)];
            item.number = @"10000";
            item.yield = @"4%";
            item.dayGains = @"0.04";
            item.url = @"http://img0.imgtn.bdimg.com/it/u=1070902365,2619384777&fm=21&gp=0.jpg";
            item.hasNew = YES;
            [_arrayList addObject:item];
        }
    }
    return _arrayList;
}

@end
