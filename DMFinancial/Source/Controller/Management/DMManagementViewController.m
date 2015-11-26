//
//  DMManagementViewController.m
//  DMFinancial
//
//  Created by 陈彦岐 on 15/11/24.
//  Copyright © 2015年 陈彦岐. All rights reserved.
//

#import "DMManagementViewController.h"
#import "DMManagementItemCell.h"
#define itemSpacing 10
@interface DMManagementViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *arrayList;
@end

@implementation DMManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"管理";
    
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
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
    longPress.delegate = self;
    [_collectionView addGestureRecognizer:longPress];
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[DMManagementItemCell class] forCellWithReuseIdentifier:@"cell"];
    
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _collectionView.frame = self.view.bounds;
}

/** @brief Returns a customized snapshot of a given view. */
- (UIView *)customSnapshoFromView:(UIView *)inputView {
    
    // Make an image from the input view.
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Create an image view.
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
}

-(void)startTimer:(CGPoint)point {
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(scrollWithPoint:) userInfo:nil repeats:YES];
}
-(void)scrollWithPoint:(CGPoint)point {
    CGPoint contentOffset = _collectionView.contentOffset;
    
    //向上滚动 (手势坐标向上超过collectionView 并且collectionView没有滚动到顶部)
    if (point.y < 0 && contentOffset.y > 0) {
        contentOffset.y -=2;
    }
    //向下滚动 (手势坐标向下超过collectionView 并且collectionView没有滚动到低部)
    if (600< point.y && point.y <_collectionView.contentSize.height) {
        contentOffset.y +=2;
    };

    _collectionView.contentOffset = contentOffset;
    DMLOG(@"_collectionView.contentSize = %@",NSStringFromCGSize(_collectionView.contentSize));
}

-(void)action:(UILongPressGestureRecognizer *)ges {
    static NSIndexPath *sourceIndexPath = nil;
    static UIView       *snapshot = nil;
    CGPoint location = [ges locationInView:_collectionView];
    DMLOG(@"%@",NSStringFromCGPoint(location));
    static CGPoint offsetPoint;//手指位置距离cell中心点的偏移量
    NSIndexPath *indexPath = [_collectionView indexPathForItemAtPoint:location];

    switch (ges.state) {
        case UIGestureRecognizerStateBegan:{
            DMManagementItemCell *cell = (DMManagementItemCell *)[_collectionView cellForItemAtIndexPath:indexPath];
            CGPoint tmpPoint = [ges locationInView:cell];

            cell.showDelButton = YES;
            snapshot = [self customSnapshoFromView:cell];

            // Add the snapshot as subview, centered at cell's center...
            __block CGPoint center = cell.center;
            offsetPoint.x = cell.width/2 - tmpPoint.x;
            offsetPoint.y = cell.height/2 - tmpPoint.y;
            snapshot.center = center;
            snapshot.alpha = 0.0;
            [_collectionView addSubview:snapshot];
            [UIView animateWithDuration:0.25 animations:^{
                
                // Offset for gesture location.
                snapshot.center = center;
                snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                snapshot.alpha = 0.98;
                cell.alpha = 0.0;
                
            } completion:^(BOOL finished) {
                
                cell.hidden = YES;
                
            }];
            sourceIndexPath = indexPath;
        }
            break;
        case UIGestureRecognizerStateChanged:{
//            [self scrollWithPoint:location];
            [self startTimer:location];
            CGPoint center;
            center.x = location.x + offsetPoint.x;
            center.y = location.y + offsetPoint.y;

            snapshot.center = center;
            
            if (indexPath && ![indexPath isEqual:sourceIndexPath]) {
                [self.arrayList exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
                [_collectionView moveItemAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                sourceIndexPath = indexPath;
            }
        }
            break;
        default: {
            // Clean up.
            DMManagementItemCell *cell = (DMManagementItemCell *)[_collectionView cellForItemAtIndexPath:sourceIndexPath];
            cell.hidden = NO;
            cell.alpha = 0.0;
            
            [UIView animateWithDuration:0.25 animations:^{
                
                snapshot.center = cell.center;
                snapshot.transform = CGAffineTransformIdentity;
                snapshot.alpha = 0.0;
                cell.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                
                sourceIndexPath = nil;
                [snapshot removeFromSuperview];
                snapshot = nil;
                
            }];
            
            break;
        }
    }
}

#pragma mark UICollectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DMManagementItemCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
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
